import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/data/model/category_model.dart';
import 'package:base_bloc/data/model/feed_model.dart';
import 'package:base_bloc/modules/tab_home/tab_home_cubit.dart';
import 'package:base_bloc/modules/tab_home/tab_home_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/app_text.dart';
import '../../config/constant.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../router/router.dart';
import '../../router/router_utils.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with AutomaticKeepAliveClientMixin {
  late TabHomeCubit _bloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _bloc = TabHomeCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: colorWhite,
      appbar: appBarHome(),
      body: RefreshIndicator(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          child: BlocBuilder<TabHomeCubit, TabHomeState>(
            bloc: _bloc,
            builder: (c, state) {
              switch (state.status) {
                case FeedStatus.initial:
                case FeedStatus.refresh:
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: const AppCircleLoading(),
                  );
                case FeedStatus.success:
                  return Column(
                    children: [
                      for (int i = 0; i < state.lCategory.length; i++)
                        categoryWidget(state.lCategory[i])
                    ],
                  );
                case FeedStatus.failure:
                  return Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: const AppText('Không tìm thấy dữ liệu'));
              }
            },
          ),
        ),
        onRefresh: () async => _bloc.refresh(),
      ),
    );
  }

  Widget categoryWidget(CategoryModel categoryModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: titleCategoryWidget(
                categoryModel.name ?? '', Assets.svg.vector)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          primary: true,
          itemBuilder: (c, i) => itemHeading(i, categoryModel.lFeed![i]),
          itemCount: categoryModel.lFeed?.length ?? 0,
        )
      ],
    );
  }

  Widget itemHeading(int index, FeedModel model) {
    return InkWell(
      onTap: () {
        RouterUtils.pushHome(
            context: context,
            route: HomeRouters.detail,
            argument: [BottomNavigationConstant.TAB_HOME,model]);
      },
      child: Container(
        color: (index % 2 == 0)
            ? colorPrimaryOrange.withOpacity(0.12)
            : colorWhite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h, right: 5.w, left: 5.w),
              child: const Icon(
                Icons.circle_sharp,
                size: 5,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      model.name ?? '',
                      maxLine: 4,
                      overflow: TextOverflow.ellipsis,
                      style: typoExtraSmallTextRegular,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 5.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Spacer(),
                          AppText(
                            AppLocalizations.of(context)!.effectiveFrom,
                            style: typoSuperSmallTextRegular.copyWith(
                                color: colorPrimaryOrange,fontSize: 8.sp),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          AppText(
                            Utils.convertDateTimeToDDMMYY(
                                model.createdAt ?? DateTime.now()),
                            style: typoSuperSmallTextRegular.copyWith(
                                color: colorPrimaryOrange,fontSize: 8.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBarHome() {
    return AppBar(
      centerTitle: true,
      leadingWidth: 32,
      leading: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: InkWell(
          onTap: () {
            RouterUtils.pushHome(
                context: context,
                route: HomeRouters.search,
                argument: BottomNavigationConstant.TAB_HOME);
          },
          child: SvgPicture.asset(
            Assets.svg.search,
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 14.w, bottom: 16.h),
            child: Image.asset(
              Assets.png.laws.path,
              width: 40,
            ),
          ),
          AppText(
            AppLocalizations.of(context)!.textAppBar,
            style: typoHeadingText.copyWith(color: colorWhite),
          )
        ],
      ),
      backgroundColor: colorPrimaryOrange,
    );
  }

  Widget titleCategoryWidget(String text, String icon) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 9.w, right: 12.w,top: 5.h,bottom: 5.h),
          child: SvgPicture.asset(
            icon,
            color: colorPrimaryOrange,
          ),
        ),
        AppText(
          text,
          style: typoHeadingText,
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
