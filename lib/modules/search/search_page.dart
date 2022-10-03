import 'dart:async';
import 'package:badges/badges.dart';
import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_button.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/data/model/filter_model.dart';
import 'package:base_bloc/modules/search/search_cubit.dart';
import 'package:base_bloc/modules/search/tab_help/tab_help_page.dart';
import 'package:base_bloc/modules/search/tab_law/tab_law_page.dart';
import 'package:base_bloc/modules/search/tab_procedural/tab_procedural_page.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final List<Widget> tabSearch = [
    const TabLawPage(
      index: 0,
      catId: CategoryID.LAW,
    ),
    const TabLawPage(
      index: 1,
      catId: CategoryID.PROCEDURAL,
    ),
    const TabLawPage(
      index: 2,
      catId: CategoryID.HELP,
    ),
  ];

  int _selectedIndex = 0;
  late SearchCubit _bloc;
  var pageController = PageController();
  late TabController tabController;
  TextEditingController? textEditingController;
  final itemOnChange = BehaviorSubject<String>();
  Datum? filterModel;

  @override
  void initState() {
    _bloc = SearchCubit();
    tabController = TabController(length: 3, vsync: this);
    textEditingController = TextEditingController();
    tabController.addListener(() {
      var index = tabController.index;
      _jumpToPage(index);
      setState(() {});
    });
    itemOnChange.debounceTime(const Duration(seconds: 1)).listen(
      (value) {
        Utils.fireEvent(
          SearchEvent(_selectedIndex, value, filterModel),
        );
        keySearch = value;
        setState(() {});
      },
    );
    checkFilter();
    super.initState();
  }

  void checkFilter() async {
    filterModel = await StorageUtils.getFilter();
    setState(() {});
  }

  void _jumpToPage(int index) {
    _selectedIndex = index;
    pageController.jumpToPage(_selectedIndex);
    Timer(
        const Duration(milliseconds: 500),
        () => Utils.fireEvent(
            SearchEvent(_selectedIndex, keySearch, filterModel)));
    _bloc.jumToPage(_selectedIndex);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
        resizeToAvoidBottomInset: false,
        appbar: appBarWidget(),
        body: Column(
          children: [
            BlocBuilder(
                bloc: _bloc,
                builder: (c, state) => Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
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
                            onTap: () => _jumpToPage(0),
                          ),
                          InkWell(
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
                            onTap: () => _jumpToPage(1),
                          ),
                          InkWell(
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
                            onTap: () => _jumpToPage(2),
                          )
                        ],
                      ),
                    )),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 1.h,
              color: colorGrey50,
            ),
            Expanded(
              child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: tabSearch),
            ),
          ],
        ));
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
          autofocus: true,
          onSubmitted: (text) {},
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
        filterModel != null
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
                        ),
                      ),
                    ],
                  ),
                  onPress: () async {
                    Utils.hideKeyboard(context);
                    await RouterUtils.pushHome(
                        context: context,
                        route: HomeRouters.filter,
                        argument: BottomnavigationConstant.TAB_HOME);
                    checkFilter();
                    Utils.fireEvent(
                      SearchEvent(_selectedIndex, keySearch, filterModel),
                    );
                  },
                  shapeBorder: RoundedRectangleBorder(
                      side: const BorderSide(color: colorWhite, width: 2),
                      borderRadius: BorderRadius.circular(15)),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: InkWell(
                    onTap: () async {
                      Utils.hideKeyboard(context);
                      await RouterUtils.pushHome(
                          context: context,
                          route: HomeRouters.filter,
                          argument: BottomnavigationConstant.TAB_HOME);
                      checkFilter();
                      Utils.fireEvent(
                        SearchEvent(_selectedIndex, keySearch, filterModel),
                      );
                    },
                    child: SvgPicture.asset(Assets.svg.filter)),
              ),
      ],
    );
  }

  @override
  int get tabIndex => widget.index;
}
