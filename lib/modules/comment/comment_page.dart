import 'package:base_bloc/components/app_scalford.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../base/base_state.dart';
import '../../components/app_button.dart';
import '../../components/app_text.dart';
import '../../components/app_text_field.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class CommentPage extends StatefulWidget {
  final int index;

  const CommentPage({Key? key, required this.index}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends BasePopState<CommentPage> {
  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
      isTabToHideKeyBoard: true,
      appbar: AppBar(
          centerTitle: true,
          leadingWidth: 35,
          leading: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(Assets.svg.back),
            ),
          ),
          backgroundColor: colorPrimaryOrange,
          title: AppText(
            AppLocalizations.of(context)!.textButtonComments,
            style: typoSuperSmallTextRegular.copyWith(
                color: colorWhite, fontSize: 16.sp),
          )),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 33.h, left: 30.w,bottom: 17.h),
                child: AppText(
                  AppLocalizations.of(context)!.titleComment,
                  style: typoExtraSmallTextBold.copyWith(
                      color: colorPrimaryOrange),
                )),
        Padding(
              padding: EdgeInsets.only(left: 30.w,right: 30.w),
              child: AppTextField(
               maxLine: 10,
                hintText: AppLocalizations.of(context)!.contentComment,
              ),
            ),
               Center(
              child: AppButton(
                width: 300.w,
                height: 50.h,
                title: AppLocalizations.of(context)!.send,
                textStyle: typoTitleHeader.copyWith(color: colorPrimaryOrange),
                shapeBorder: RoundedRectangleBorder(
                  side: const BorderSide(color: colorPrimaryOrange, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  int get tabIndex => widget.index;
}
