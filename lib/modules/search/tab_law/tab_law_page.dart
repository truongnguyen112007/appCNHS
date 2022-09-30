import 'dart:async';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/item_feed_widget.dart';
import 'package:base_bloc/modules/search/tab_law/tab_law_cubit.dart';
import 'package:base_bloc/modules/search/tab_law/tab_law_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import '../../../components/app_circle_loading.dart';
import '../../../config/constant.dart';
import '../../../data/eventbus/search_event.dart';
import '../../../data/model/tab_criminal_law_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../localizations/app_localazations.dart';
import '../../../router/router.dart';
import '../../../router/router_utils.dart';

class TabLawPage extends StatefulWidget {
  final int index;
  final int catId;

  const TabLawPage({Key? key, required this.index, required this.catId})
      : super(key: key);

  @override
  State<TabLawPage> createState() => _TabLawPageState();
}

class _TabLawPageState extends State<TabLawPage>
    with AutomaticKeepAliveClientMixin {
  final box = GetStorage();
  var isFirstOpen = true;
  late TabLawCubit _bloc;

  final _scrollController = ScrollController();
  StreamSubscription<SearchEvent>? _searchStream;

  @override
  void initState() {
    _bloc = TabLawCubit(widget.catId);
    _searchStream = Utils.eventBus.on<SearchEvent>().listen((event) {
      if (!isFirstOpen && event.key.isNotEmpty)
        _bloc.getSearch(keySearch: event.key);
    });
    isFirstOpen = false;
    paging();
    super.initState();
  }

  @override
  void dispose() {
    _searchStream?.cancel();
    super.dispose();
  }

  void paging() {
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      if (currentScroll >= (maxScroll * 0.9)) _bloc.getSearch(isPaging: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: RefreshIndicator(
        child: BlocBuilder<TabLawCubit, TabLawState>(
          bloc: _bloc,
          builder: (c, state) => state.status == FeedStatus.initial
              ? emptyPage()
              : state.status == FeedStatus.refresh
                  ? Container(
                      height: MediaQuery.of(context).size.height / 3,
                      alignment: Alignment.center,
                      child: const AppCircleLoading(),
                    )
                  : state.lFeed.isNotEmpty
                      ? ListView.separated(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              index == state.lFeed.length
                                  ? const Center(
                                      child: AppCircleLoading(),
                                    )
                                  : ItemFeedWidget(
                                      isSearch: true,
                                      index: index,
                                      model: state.lFeed[index],
                                      callback: (model) =>
                                          _bloc.itemOnclick(context, model)),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 5,
                          ),
                          itemCount: !state.readEnd && state.isLoading
                              ? state.lFeed.length + 1
                              : state.lFeed.length,
                        )
                      : emptyPage(),
        ),
        onRefresh: () async => _bloc.refresh(),
      ),
    );
  }

  Widget item(int index, FeedModelCriminalLaw model) {
    return InkWell(
      onTap: () {
        RouterUtils.pushCriminalLaw(
            context: context,
            route: CriminalLawRouters.detail,
            argument: BottomnavigationConstant.TAB_CRIMINALLAWPAGE);
      },
      child: Container(
        color: (index % 2 == 0)
            ? colorPrimaryOrange.withOpacity(0.12)
            : colorWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: RichText(
                  text: TextSpan(
                      text: model.content.split(' ').first,
                      style: typoSuperSmallTextBold.copyWith(
                          color: colorSemanticRed100),
                      children: [
                    TextSpan(
                        text:
                            " ${model.content.substring(model.content.split(' ').first.length + 1, model.content.length - 1)}",
                        style: typoSuperSmallTextRegular)
                  ])),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.w, bottom: 5.h),
              child: AppText(
                '${model.creatDate} ${model.date}',
                style: typoSuperSmallTextRegular.copyWith(
                    color: colorPrimaryOrange),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget emptyPage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.svg.search,
            color: colorGrey50,
            width: 30,
          ),
          SizedBox(
            height: 10.h,
          ),
          AppText(
            AppLocalizations.of(context)!.textTabOfSearch,
            style: typoSuperSmallTextRegular.copyWith(color: colorGrey50),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
