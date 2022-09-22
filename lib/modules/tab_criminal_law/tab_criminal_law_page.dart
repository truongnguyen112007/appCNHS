import 'package:base_bloc/modules/tab_criminal_law/tab_criminal_law_cubit.dart';
import 'package:base_bloc/modules/tab_criminal_law/tab_criminal_law_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/app_circle_loading.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../data/model/tab_criminal_law_model.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../theme/colors.dart';

class TabCriminalLawPage extends StatefulWidget {
  const TabCriminalLawPage({Key? key}) : super(key: key);

  @override
  State<TabCriminalLawPage> createState() => _TabCriminalLawPageState();
}

class _TabCriminalLawPageState extends State<TabCriminalLawPage> {
  late TabCriminalLawCubit _bloc;

  final _scrollController = ScrollController();

  @override
  void initState() {
    _bloc = TabCriminalLawCubit();
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
        leadingWidth:25,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: SvgPicture.asset(Assets.svg.search),
        ),
        title: Text(AppLocalizations.of(context)!.titleTabCriminalLaw),
        backgroundColor: colorPrimaryOrange,
      ),
      body:
      RefreshIndicator(
        child:SingleChildScrollView(
        controller: _scrollController,
        child: Container(
           child: BlocBuilder<TabCriminalLawCubit, TabCriminalLawState>(
                bloc: _bloc,
                builder: (c, state) => state.status == FeedStatus.initial ||
                    state.status == FeedStatus.refresh
                    ? Container(
                  height: MediaQuery.of(context).size.height / 3,
                  alignment: Alignment.center,
                  child: const AppCircleLoading(),
                )
                    : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        item(index, state.lFeed[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      height: 5,
                    ),
                    itemCount: state.lFeed.length)),
        ),
      ),
          onRefresh: () async => _bloc.refresh(),
      ),
    );
  }
  Widget item(int index, FeedModelCriminalLaw model) {
    return Container(
      height: 111.h,
      color:
      (index % 2 == 0) ? colorPrimaryOrange.withOpacity(0.12) : colorWhite,
      child: Column(
        children: [
          AppText(
            model.content,
            maxLine: 4,
            overflow: TextOverflow.ellipsis,
          ),
          AppText(model.creatDate + (model.date),),
        ],
      ),
    );
  }
}
