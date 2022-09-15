import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/app_text.dart';
import '../../gen/assets.gen.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          homeHeading('Văn bản mới', Assets.svg.vector),
          homeHeading('Chỉ dẫn pháp luật mới', Assets.svg.book)
        ],
      ),
    );
  }

  Widget homeHeading(String text, String icon) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 9.w, right: 12.w),
          child: SvgPicture.asset(
            icon,
            color: colorPrimaryOrange,
          ),
        ),
        AppText(text, style: typoHeadingText)
      ],
    );
  }
}
