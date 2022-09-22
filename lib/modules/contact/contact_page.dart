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
              style: typoSuperSmallTextRegular.copyWith(color: colorWhite,fontSize: 16.sp),
        )
      ),
      body: Container()
    );

  }
  @override
  int get tabIndex => widget.index;
}

