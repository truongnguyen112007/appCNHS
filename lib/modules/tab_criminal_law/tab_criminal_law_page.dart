import 'package:base_bloc/modules/tab_criminal_law/tab_criminal_law_cubit.dart';
import 'package:base_bloc/modules/tab_criminal_law/tab_criminal_law_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/app_circle_loading.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../data/model/feed_model.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../router/router_utils.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class TabCriminalLawPage extends StatefulWidget {
  final int catId;
  final int tab;
  final String titleAppbar;
  final Function(FeedModel) itemCallBack;

  const TabCriminalLawPage(
      {Key? key,
      required this.tab,
      required this.titleAppbar,
      required this.catId,
      required this.itemCallBack})
      : super(key: key);

  @override
  State<TabCriminalLawPage> createState() => _TabCriminalLawPageState();
}

class _TabCriminalLawPageState extends State<TabCriminalLawPage>
    with AutomaticKeepAliveClientMixin {
  late TabCriminalLawCubit _bloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _bloc = TabCriminalLawCubit(widget.catId);
    paging();
    super.initState();
  }

  void paging() {
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      if (currentScroll >= (maxScroll * 0.9)) _bloc.getPost(isPaging: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: colorWhite,
      appbar: AppBar(
        centerTitle: true,
        leadingWidth: 32,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: InkWell(
              onTap: () {
                RouterUtils.pushCriminalLaw(
                    context: context,
                    route: CriminalLawRouters.search,
                    argument: widget.tab);
              },
              child: SvgPicture.asset(Assets.svg.search)),
        ),
        title: Text(widget.titleAppbar),
        backgroundColor: colorPrimaryOrange,
      ),
      body: RefreshIndicator(
        onRefresh: () async => _bloc.refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          child: BlocBuilder<TabCriminalLawCubit, TabCriminalLawState>(
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
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (c, i) => i == state.lFeed.length
                        ? const Center(
                            child: AppCircleLoading(),
                          )
                        : itemWidget(i, state.lFeed[i]),
                    itemCount: state.isLoading &&
                            !state.readEnd &&
                            state.lFeed.isNotEmpty
                        ? state.lFeed.length + 1
                        : state.lFeed.length,
                  );
                case FeedStatus.failure:
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: const AppText('Không tìm thấy dữ liệu'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget itemWidget(int index, FeedModel model) {
    return InkWell(
      onTap: () {
        widget.itemCallBack(model);
      },
      child: Container(
        color: (index % 2 == 0)
            ? colorPrimaryOrange.withOpacity(0.12)
            : colorWhite,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(model.name ?? '',
                  maxLine: 4,
                  overflow: TextOverflow.visible,
                  style: typoExtraSmallTextRegular),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  const Spacer(),
                  AppText(
                    AppLocalizations.of(context)!.effectiveFrom,
                    style: typoExtraSmallTextRegular.copyWith(
                        color: colorPrimaryOrange, fontSize: 8.sp),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  AppText(
                    Utils.convertDateTimeToDDMMYY(
                        model.createdAt ?? DateTime.now()),
                    style: typoSuperSmallTextRegular.copyWith(
                        color: colorPrimaryOrange, fontSize: 8.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
