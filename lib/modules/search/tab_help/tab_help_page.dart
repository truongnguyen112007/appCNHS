import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../localizations/app_localazations.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';

class TabHelpPage extends StatefulWidget {
  const TabHelpPage({Key? key}) : super(key: key);

  @override
  State<TabHelpPage> createState() => _TabHelpPageState();
}

class _TabHelpPageState extends State<TabHelpPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
