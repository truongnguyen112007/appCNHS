import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/app_text.dart';
import '../../config/constant.dart';
import '../../gen/assets.gen.dart';
import '../../router/router.dart';
import '../../router/router_utils.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          homeHeading('Văn bản mới', Assets.svg.vector),
          homeHeading('Chỉ dẫn pháp luật mới', Assets.svg.book)
        ],
      ),
      appbar: AppBar(
        foregroundColor: Colors.red,
        centerTitle: true,
        leadingWidth: 25,
        leading: Container(
          padding: EdgeInsets.only(left: 5.w),
          child: InkWell(
            onTap: () {
              RouterUtils.pushHome(
                  context: context,
                  route: HomeRouters.search,
                  argument: BottomnavigationConstant.TAB_HOME);
            },
            child: SvgPicture.asset(Assets.svg.search),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 14.w, bottom: 18.h),
              child: Image.asset(
                Assets.png.laws.path,
                width: 40,
              ),
            ),
            AppText(
              'Cẩm nang hình sự',
              style:
                  typoHeadingText.copyWith(fontSize: 18.sp, color: colorWhite),
            )
          ],
        ),
        backgroundColor: colorPrimaryOrange,
        automaticallyImplyLeading: false,
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
