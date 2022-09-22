import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class TabInstructionPage extends StatefulWidget {
  const TabInstructionPage({Key? key}) : super(key: key);

  @override
  State<TabInstructionPage> createState() => _TabInstructionPageState();
}

class _TabInstructionPageState extends State<TabInstructionPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: AppBar(
          leadingWidth: 25,
          leading: Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(Assets.svg.search,),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.titleTabInstruction),
          backgroundColor: colorPrimaryOrange,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.svg.search,
                color: colorGrey50,
                width: 30,
              ),
              SizedBox(
                height: 10.h,
              ),
              AppText(
                AppLocalizations.of(context)!.textTabOfSearch,
                style: typoSuperSmallTextRegular.copyWith(color: colorGrey50),
              ),
            ],
          )),
        ));
  }
}
