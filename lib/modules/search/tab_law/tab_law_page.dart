import 'dart:async';

import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/new_details/new_detail.dart';
import 'package:base_bloc/modules/root/root_criminal_law.dart';
import 'package:base_bloc/modules/search/tab_law/tab_law_cubit.dart';
import 'package:base_bloc/modules/search/tab_law/tab_law_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
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

  const TabLawPage({Key? key, required this.index}) : super(key: key);

  @override
  State<TabLawPage> createState() => _TabLawPageState();
}

class _TabLawPageState extends State<TabLawPage> {
  final box = GetStorage();

  late TabLawCubit _bloc;

  final _scrollController = ScrollController();
  StreamSubscription<SearchEvent>? _searchStream;

  @override
  void initState() {
    _searchStream = Utils.eventBus.on<SearchEvent>().listen((event) {
      if (event.index == widget.index) {
        logE("TAG KEY SEARCH: ${event.key}");
      }
    });
    _bloc = TabLawCubit();
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
      if (currentScroll >= (maxScroll * 0.9)) _bloc.getFeed(isPaging: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: RefreshIndicator(
        child: Container(
          child: BlocBuilder<TabLawCubit, TabLawState>(
            bloc: _bloc,
            builder: (c, state) => state.status == FeedStatus.initial ||
                    state.status == FeedStatus.refresh
                ? Container(
                    height: MediaQuery.of(context).size.height / 3,
                    alignment: Alignment.center,
                    child: const AppCircleLoading(),
                  )
                : state.lFeed!.isNotEmpty
                    ? ListView.separated(
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
                            : state.lFeed.length,
                      )
                    : Center(
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
                            style: typoSuperSmallTextRegular.copyWith(
                                color: colorGrey50),
                          ),
                        ],
                      )),
          ),
        ),
        onRefresh: () async => _bloc.refresh(),
      ),
    );
  }

  Widget item(int index, FeedModelCriminalLaw model) {
    return InkWell(
      onTap: (){
        RouterUtils.pushCriminalLaw(
            context: context,
            route: CriminalLawRouters.detail,
            argument: BottomnavigationConstant.TAB_CRIMINALLAWPAGE);
      },
      child: Container(
        height: 111.h,
        color:
            (index % 2 == 0) ? colorPrimaryOrange.withOpacity(0.12) : colorWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
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
