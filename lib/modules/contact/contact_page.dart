import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/localizations/app_localazations.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../base/base_state.dart';
import '../../gen/assets.gen.dart';
import '../../theme/colors.dart';

class ContactPage extends StatefulWidget {
  final int index;

  const ContactPage({Key? key, required this.index}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends BasePopState<ContactPage> {
  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
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
          title: AppText(
            AppLocalizations.of(context)!.textButtonContact,
            style: typoSuperSmallTextRegular.copyWith(
                color: colorWhite, fontSize: 16.sp),
          )),
      body: Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: AppLocalizations.of(context)!.address,
                style: typoLargeTextBold,
                children: [
                  TextSpan(
                      text: 'Pho A, Duong B, Ngo C, Thanh Pho\n Ha Noi',
                      style:
                          typoExtraSmallTextRegular.copyWith(fontSize: 15.sp))
                ],
              ),
            ),
            text(AppLocalizations.of(context)!.phone, 'xxxxxxxxxxxxxxxxx'),
            text(AppLocalizations.of(context)!.email, 'xxxxxxxxxxxxxxxx')
          ],
        ),
      ),
    );
  }

  Widget text(String text1, String text2) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      AppText(
        text1,
        style: typoLargeTextBold.copyWith(fontSize: 15.sp),
      ),
      AppText(
        text2,
      )
    ]);
  }

  @override
  int get tabIndex => widget.index;
}
