import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../localizations/app_localazations.dart';
import '../../../theme/app_styles.dart';
import '../../../theme/colors.dart';

class TabProceduralPage extends StatefulWidget {
  const TabProceduralPage({Key? key}) : super(key: key);

  @override
  State<TabProceduralPage> createState() => _TabProceduralPageState();
}

class _TabProceduralPageState extends State<TabProceduralPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.svg.search,color: colorGrey50,width: 30,),
              SizedBox(height: 10.h,),
              AppText(AppLocalizations.of(context)!.textTabOfSearch,style: typoSuperSmallTextRegular.copyWith(color: colorGrey50),),
            ],
          )
      ),
    );
  }
}
