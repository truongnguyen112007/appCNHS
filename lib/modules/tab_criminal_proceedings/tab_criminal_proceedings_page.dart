import 'package:base_bloc/modules/tab_criminal_proceedings/tab_criminal_proceedings_cubit.dart';
import 'package:base_bloc/modules/tab_criminal_proceedings/tab_criminal_proceedings_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/app_circle_loading.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../config/constant.dart';
import '../../data/model/test_model.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../router/router_utils.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class TabCriminalProceedingsPage extends StatefulWidget {
  const TabCriminalProceedingsPage({Key? key}) : super(key: key);

  @override
  State<TabCriminalProceedingsPage> createState() =>
      _TabCriminalProceedingPageState();
}

class _TabCriminalProceedingPageState
    extends State<TabCriminalProceedingsPage> {
  late TabCriminalProceedingsCubit _bloc;

  final _scrollController = ScrollController();

  @override
  void initState() {
    _bloc = TabCriminalProceedingsCubit();
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
      appbar: AppBar(
        centerTitle: true,
        leadingWidth: 25,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: InkWell(onTap:(){
            RouterUtils.pushCriminalProceedings(
                context: context,
                route: CriminalProceedingsRouters.search,
                argument: BottomnavigationConstant.TAB_CRIMINALPROCEEDINGSPAGE);
          },child: SvgPicture.asset(Assets.svg.search)),
        ),
        title: Text(AppLocalizations.of(context)!.titleTabCriminalProceeding),
        backgroundColor: colorPrimaryOrange,
      ),
      body: RefreshIndicator(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<TabCriminalProceedingsCubit,
              TabCriminalProceedingsState>(
            bloc: _bloc,
            builder: (c, state) => state.status == FeedStatus.initial ||
                    state.status == FeedStatus.refresh
                ? Container(
                    height: MediaQuery.of(context).size.height / 3,
                    alignment: Alignment.center,
                    child: const Center(child: AppCircleLoading()),
                  )
                : ListView.separated(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        index == state.lFeed.length
                            ? const Center(
                                child: AppCircleLoading(),
                              )
                            : item(index, state.lFeed[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                          height: 5,
                        ),
                    itemCount: !state.readEnd
                        ? state.lFeed.length + 1
                        : state.lFeed.length),
          ),
        ),
        onRefresh: () async => _bloc.refresh(),
      ),
    );
  }

  Widget item(int index, FeedModelCriminalProceedings model) {
    return InkWell(
      onTap: (){
        RouterUtils.pushCriminalProceedings(
            context: context,
            route: CriminalProceedingsRouters.detail,
            argument: BottomnavigationConstant.TAB_CRIMINALPROCEEDINGSPAGE);
      },
      child: Container(
        height: 111.h,
        color:
            (index % 2 == 0) ? colorPrimaryOrange.withOpacity(0.12) : colorWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppText(
              model.content,
              maxLine: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: AppText(model.creatDate +' '+ (model.date),style: typoSuperSmallTextRegular.copyWith(color: colorPrimaryOrange),),
            )
          ],
        ),
      ),
    );
  }
}
