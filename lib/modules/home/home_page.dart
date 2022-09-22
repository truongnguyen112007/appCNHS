import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/data/eventbus/switch_tab_event.dart';
import 'package:base_bloc/localizations/app_localazations.dart';
import 'package:base_bloc/modules/root/root_add.dart';
import 'package:base_bloc/modules/root/root_criminal_law.dart';
import 'package:base_bloc/modules/root/root_criminal_proceedings.dart';
import 'package:base_bloc/modules/root/root_instruction.dart';
import 'package:base_bloc/modules/tab_criminal_law/tab_criminal_law_page.dart';
import 'package:base_bloc/modules/tab_criminal_proceedings/tab_criminal_proceedings_page.dart';
import 'package:base_bloc/modules/tab_instruction/tab_instruction_page.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constant.dart';
import '../../gen/assets.gen.dart';
import '../../theme/colors.dart';
import '../root/root_home.dart';
import 'home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  var pageController = PageController();
  final List<Widget> tab = [
    const RootHome(),
    const RootCriminalLaw(),
    const RootCriminalProceedings(),
    const RootInstruction(),
    const RootAdd(),
  ];
  late HomeCubit _bloc;
  @override
  void initState() {
    _bloc = HomeCubit();
    super.initState();
  }
  void _jumpToPage(int index) {
    if(index == _currentIndex){
      Utils.fireEvent(SwitchTabEvent(_currentIndex));
    }
    _currentIndex = index;
    pageController.jumpToPage(_currentIndex);
    _bloc.jumToPage(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isTabToHideKeyBoard: true,
      resizeToAvoidBottomInset: false,
      fullStatusBar: true,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: tab,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, state) => Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: colorBackgroundGrey70.withOpacity(0.4),
                  blurRadius: 15.0,
                  offset: const Offset(0.0, 0.6))
            ],
          ),
          child: BlocBuilder(
            builder: (c, x) => bottomNavigationBarWidget(),
            bloc: _bloc,
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationBarWidget() {
    return BottomNavigationBar(
        elevation: 20,
        unselectedItemColor: colorBlack,
        backgroundColor: colorWhite,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorPrimaryOrange,
        selectedLabelStyle: typoSuperSmallText700.copyWith(fontSize: 9.5.sp),
        unselectedLabelStyle: typoSuperSmallText700.copyWith(fontSize: 9.5.sp),
        items: [
          itemBottomNavigationBarWidget(
              index: BottomnavigationConstant.TAB_HOME,
              label: AppLocalizations.of(context)!.home,
              svg: Assets.svg.home),
          itemBottomNavigationBarWidget(
              index: BottomnavigationConstant.TAB_CRIMINALLAWPAGE,
              label: AppLocalizations.of(context)!.rules,
              svg: Assets.svg.vector),
          itemBottomNavigationBarWidget(
              index: BottomnavigationConstant.TAB_CRIMINALPROCEEDINGSPAGE,
              label: AppLocalizations.of(context)!.rules2,
              svg: Assets.svg.trialLawSvgrepo),
          itemBottomNavigationBarWidget(
              index: BottomnavigationConstant.TAB_INTRUCTIONPAGE,
              label: AppLocalizations.of(context)!.help,
              svg: Assets.svg.book),
          itemBottomNavigationBarWidget(
              index: BottomnavigationConstant.TAB_ADD,
              label: AppLocalizations.of(context)!.add,
              svg: Assets.svg.group)
        ],
        currentIndex: _currentIndex,
        onTap: (index) => _jumpToPage(index));
  }
  BottomNavigationBarItem itemBottomNavigationBarWidget(
          {required int index, required String svg, required String label}) =>
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(bottom: 10.42.h, top: 5.h),
          child: SvgPicture.asset(
            svg,
            color: _currentIndex == index ? colorPrimaryOrange : colorBlack,
            width: 20.w,
          ),
        ),
        label: label,
      );
}
