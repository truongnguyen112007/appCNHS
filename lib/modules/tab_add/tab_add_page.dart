import 'package:base_bloc/components/app_button.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        centerTitle: true,
        leadingWidth: 25,
        leading: Container(
          padding: EdgeInsets.only(left: 5.w),
          child:
              InkWell(onTap: () {
                RouterUtils.pushAdd(
                    context: context,
                    route: AddRouters.search,
                    argument: BottomnavigationConstant.TAB_ADD);
              }, child: SvgPicture.asset(Assets.svg.search)),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 45.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customButton(AppLocalizations.of(context)!.textButtonLogin, () {
              RouterUtils.pushAdd(
                  context: context,
                  route: AddRouters.login,
                  argument: BottomnavigationConstant.TAB_ADD);
            }),
            SizedBox(
              height: 15.h,
            ),
            customButton(AppLocalizations.of(context)!.textButtonComments, () {
              RouterUtils.pushAdd(
                  context: context,
                  route: AddRouters.comment,
                  argument: BottomnavigationConstant.TAB_ADD);
            }),
            SizedBox(
              height: 15.h,
            ),
            customButton(AppLocalizations.of(context)!.textButtonContact, () {
              RouterUtils.pushAdd(
                  context: context,
                  route: AddRouters.contact,
                  argument: BottomnavigationConstant.TAB_ADD);
            }),
          ],
        ),
      ),
    );
  }

  Widget customButton(String title, Function() onClick) {
    return AppButton(
        width: 300.w,
        height: 50.h,
        title: title,
        textStyle: typoTitleHeader.copyWith(color: colorPrimaryOrange),
        shapeBorder: RoundedRectangleBorder(
          side: const BorderSide(color: colorPrimaryOrange, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        onPress: onClick);
  }

  @override
  bool get wantKeepAlive => true;
}
