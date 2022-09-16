import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/data/model/home_model.dart';
import 'package:base_bloc/modules/home/home_cubit.dart';
import 'package:base_bloc/modules/home/home_state.dart';
import 'package:base_bloc/modules/tab_home/tab_home_cubit.dart';
import 'package:base_bloc/modules/tab_home/tab_home_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
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

class _TabHomeState extends State<TabHome> {
  late TabHomeCubit _bloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _bloc = TabHomeCubit();
    paging();
    super.initState();
  }

  void paging() {
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      if (currentScroll >= (maxScroll * 0.9)) _bloc.getFeed(isPaging: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: RefreshIndicator(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                child: homeHeading(AppLocalizations.of(context)!.heading1Home,
                    Assets.svg.vector),
              ),
              BlocBuilder<TabHomeCubit, TabHomeState>(bloc: _bloc,
                  builder: (c, state) => state.status == FeedStatus.initial ||
                          state.status == FeedStatus.refresh
                      ? Container(
                    height: MediaQuery.of(context).size.height/3,
                    alignment: Alignment.center,
                    child: AppCircleLoading(),)
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              itemHeading(index, state.lFeed[index]),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                height: 5,
                              ),
                          itemCount: state.lFeed.length)),
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                child: homeHeading(AppLocalizations.of(context)!.heading2Home,
                    Assets.svg.book),
              ),
              BlocBuilder<TabHomeCubit, TabHomeState>(bloc: _bloc,
                  builder: (c, state) => state.status == FeedStatus.initial ||
                      state.status == FeedStatus.refresh
                      ? Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/3,
                    child: AppCircleLoading(),)
                      : ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          itemHeading(index, state.lFeed[index]),
                      separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 5,
                      ),
                      itemCount: state.lFeed.length)),
            ],
          ),
        ),
        onRefresh: () async => _bloc.refresh(),
      ),
      appbar: appBarHome(),
    );
  }

  Widget itemHeading(int index, HomeModel model) {
    return Container(
      height: 111.h,
      color:
          (index % 2 == 0) ? colorPrimaryOrange.withOpacity(0.12) : colorWhite,
      child: Column(
        children: [
          AppText(model.content,maxLine: 4,overflow: TextOverflow.ellipsis,),
          AppText(model.creatDate+ (model.date))
        ],
      ),
    );
  }

  PreferredSizeWidget appBarHome() {
    return AppBar(
      foregroundColor: Colors.red,
      centerTitle: true,
      leadingWidth: 25,
      leading: Container(
        padding: EdgeInsets.only(left: 5.w),
        child: InkWell(
          onTap: () {
            RouterUtils.pushHome(
                context: context,
                route: HomeRouters.search,
                argument: BottomnavigationConstant.TAB_HOME);
          },
          child: SvgPicture.asset(Assets.svg.search),
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
            maxLine: 4,
            overflow: TextOverflow.ellipsis,
            AppLocalizations.of(context)!.textAppBar,
            style: typoHeadingText.copyWith(color: colorWhite),
          )
        ],
      ),
      backgroundColor: colorPrimaryOrange,
      automaticallyImplyLeading: false,
    );
  }

  Widget homeHeading(String text, String icon) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 9.w, right: 12.w),
          child: SvgPicture.asset(
            icon,
            color: colorPrimaryOrange,
          ),
        ),
        AppText(text, style: typoHeadingText)
      ],
    );
  }
}
