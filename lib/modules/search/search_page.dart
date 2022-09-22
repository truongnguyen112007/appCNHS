import 'dart:async';
import 'package:badges/badges.dart';
import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_button.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/search/search_cubit.dart';
import 'package:base_bloc/modules/search/tab_help/tab_help_page.dart';
import 'package:base_bloc/modules/search/tab_law/tab_law_cubit.dart';
import 'package:base_bloc/modules/search/tab_law/tab_law_page.dart';
import 'package:base_bloc/modules/search/tab_procedural/tab_procedural_page.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text_field.dart';
import '../../config/constant.dart';
import '../../data/eventbus/search_event.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../utils/app_utils.dart';

class SearchPage extends StatefulWidget {
  final int index;

  const SearchPage({Key? key, required this.index}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends BasePopState<SearchPage>
    with TickerProviderStateMixin {
  String keySearch = '';
  StreamSubscription<SearchEvent>? _searchEvent;
  final List<Widget> tabSearch = [
    const TabLawPage(
      index: 0,
    ),
    const TabProceduralPage(),
    const TabHelpPage()
  ];

  int _selectedIndex = 0;
  late SearchCubit _bloc;
  var pageController = PageController();
  late TabController tabController;
  TextEditingController? textEditingController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    _bloc = SearchCubit();
    TextEditingController? textEditingController;

    tabController.addListener(() {
      var index = tabController.index;
      _jumpToPage(index);
      setState(() {});
    });

    textEditingController = TextEditingController();

    itemOnChange.debounceTime(const Duration(seconds: 1)).listen(
      (value) {
        Utils.fireEvent(
          SearchEvent(_selectedIndex, value),
        );
        keySearch = value;
        setState(() {});
      },
    );

    _bloc = SearchCubit();
    super.initState();
  }

  final itemOnChange = BehaviorSubject<String>();

  void _jumpToPage(int index) {
    _selectedIndex = index;
    pageController.jumpToPage(_selectedIndex);
    _bloc.jumToPage(_selectedIndex);
  }

  @override
  Widget buildWidget(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AppScaffold(
      isTabToHideKeyBoard: true,
      resizeToAvoidBottomInset: false,
      appbar: appBarWidget(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: TabBar(
              indicatorColor: Colors.transparent,
              controller: tabController,
              tabs: [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.w),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.vector,
                          color: _selectedIndex == 0
                              ? colorPrimaryOrange
                              : colorBlack,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        AppText(
                          AppLocalizations.of(context)!.rules,
                          style: typoSuperSmallTextRegular.copyWith(
                            color: _selectedIndex == 0
                                ? colorPrimaryOrange
                                : colorBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        Assets.svg.trialLawSvgrepo,
                        color: _selectedIndex == 1
                            ? colorPrimaryOrange
                            : colorBlack,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppText(
                        AppLocalizations.of(context)!.rules2,
                        style: typoSuperSmallTextRegular.copyWith(
                          color: _selectedIndex == 1
                              ? colorPrimaryOrange
                              : colorBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  // icon: SvgPicture.asset(Assets.svg.book),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.book,
                          color: _selectedIndex == 2
                              ? colorPrimaryOrange
                              : colorBlack,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AppText(
                          AppLocalizations.of(context)!.help,
                          style: typoSuperSmallTextRegular.copyWith(
                            color: _selectedIndex == 2
                                ? colorPrimaryOrange
                                : colorBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // text: AppLocalizations.of(context)!.help,
                )
              ],
            ),
          ),
          Divider(
            height: 5.h,
            color: colorGrey50,
            thickness: 1,
          ),
          Expanded(
            child: PageView(controller: pageController, children: tabSearch),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      centerTitle: true,
      leadingWidth: 35,
      leading: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(Assets.svg.back)),
      ),
      backgroundColor: colorPrimaryOrange,
      title: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 40),
        child: AppTextField(
          onSubmitted: (text) {
            logE('ssss');
          },
          textInputAction: TextInputAction.search,
          onChanged: (str) => itemOnChange.add(str),
          controller: textEditingController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            hintStyle: const TextStyle(
              color: Color(0xff454545),
            ),
            hintText: AppLocalizations.of(context)!.hinTextSearch,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: colorWhite,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      actions: [
        keySearch.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(
                    top: 6.h, bottom: 6.h, right: 5.w, left: 10.w),
                child: AppButton(
                  padding: EdgeInsets.only(left: 1.w, right: 2.w),
                  titleWidget: Row(
                    children: [
                      AppText(
                        AppLocalizations.of(context)!.filter,
                        style: typoSuperSmallTextRegular.copyWith(
                            color: colorWhite),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Badge(
                          position: BadgePosition(bottom: 12.h, start: 6.w),
                          elevation: 0,
                          badgeColor: colorBlue80,
                          child: SvgPicture.asset(
                            Assets.svg.filter,
                            width: 15,
                          )),
                    ],
                  ),
                  onPress: () {
                    RouterUtils.pushHome(
                        context: context,
                        route: HomeRouters.filter,
                        argument: BottomnavigationConstant.TAB_HOME);
                  },
                  shapeBorder: RoundedRectangleBorder(
                      side: const BorderSide(color: colorWhite, width: 2),
                      borderRadius: BorderRadius.circular(15)),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: InkWell(
                    onTap: () {
                      RouterUtils.pushHome(
                          context: context,
                          route: HomeRouters.filter,
                          argument: BottomnavigationConstant.TAB_HOME);
                    },
                    child: SvgPicture.asset(Assets.svg.filter)),
              ),
      ],
    );
  }

  @override
  int get tabIndex => widget.index;
}
