import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/localizations/app_localazations.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../base/base_state.dart';
import '../../gen/assets.gen.dart';

class LoginPage extends StatefulWidget {
  final int index;

  const LoginPage({Key? key, required this.index}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePopState<LoginPage> {
  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
        appbar: AppBar(
          backgroundColor: colorPrimaryOrange,
          centerTitle: true,
          leadingWidth: 25,
          leading: Container(
            padding: EdgeInsets.only(left: 5.w),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                }, child: SvgPicture.asset(Assets.svg.back)),
          ),
          title: AppText(AppLocalizations.of(context)!.textButtonLogin,style: typoExtraSmallTextBold.copyWith(color:colorWhite,fontSize: 17),),
        ),
        body: Container(
          child: Column(
            children: [
              AppText(AppLocalizations.of(context)!.pleaseLoginMobile)
            ],
          ),
        ));
  }

  @override
  int get tabIndex => widget.index;
}
