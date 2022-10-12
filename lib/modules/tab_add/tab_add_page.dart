import 'package:base_bloc/components/app_button.dart';
import 'package:base_bloc/data/globals.dart' as globals;
import 'package:base_bloc/modules/tab_add/tab_add_cubit.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../config/constant.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class TabAdd extends StatefulWidget {
  const TabAdd({Key? key}) : super(key: key);

  @override
  State<TabAdd> createState() => _TabAddState();
}

class _TabAddState extends State<TabAdd> with AutomaticKeepAliveClientMixin {
  late AddCubit _bloc;

  @override
  void initState() {
    _bloc = AddCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: colorWhite,
      appbar: AppBar(
        centerTitle: true,
        leadingWidth: 32,
        leading: Container(
          padding: EdgeInsets.only(left: 5.w),
          child: InkWell(
              onTap: () {
                RouterUtils.pushAdd(
                    context: context,
                    route: AddRouters.search,
                    argument: BottomNavigationConstant.TAB_ADD);
              },
              child: SvgPicture.asset(Assets.svg.search)),
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
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (c, s) => Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 45.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              globals.isLogin
                  ? customButton(
                      AppLocalizations.of(context)!.textButtonUpdateInformation,
                      () => _bloc.updateProfileOnClick(context))
                  : customButton(AppLocalizations.of(context)!.textButtonLogin,
                      () => _bloc.loginOnClick(context)),
              customButton(AppLocalizations.of(context)!.textButtonComments,
                  () => _bloc.feedBackOnClick(context)),
              customButton(AppLocalizations.of(context)!.textButtonContact,
                  () => _bloc.contactOnClick(context)),
              Visibility(
                visible: globals.isLogin,
                child: Column(
                  children: [
                    customButton('Các gói dịch vụ', () => null),
                    customButton('Xóa tài khoản', () => _bloc.deleteOnClick()),
                    customButton('Đăng xuất', () => _bloc.logOutOnClick())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton(String title, Function() onClick) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: AppButton(
          width: 300.w,
          height: 50.h,
          title: title,
          textStyle: typoTitleHeader.copyWith(color: colorPrimaryOrange),
          shapeBorder: RoundedRectangleBorder(
            side: const BorderSide(color: colorPrimaryOrange, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          onPress: onClick),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
