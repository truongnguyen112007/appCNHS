import 'package:base_bloc/modules/otp/otp_cubit.dart';
import 'package:base_bloc/modules/otp/otp_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/app_button.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../components/app_text_field.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';
import '../login/login_cubit.dart';
import '../login/login_state.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;

  const OtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpController = TextEditingController();
  late OtpCubit _bloc;

  @override
  void initState() {
    logE("TAG PHONE: ${widget.phoneNumber}");
    _bloc = OtpCubit(widget.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.only(left: 12.w, top: 20.h),
      appbar: AppBar(
        backgroundColor: colorPrimaryOrange,
        centerTitle: true,
        leadingWidth: 25,
        leading: Container(
          padding: EdgeInsets.only(left: 5.w),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(Assets.svg.back)),
        ),
        title: AppText(
          'OTP',
          style:
              typoExtraSmallTextBold.copyWith(color: colorWhite, fontSize: 17),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            AppLocalizations.of(context)!.pleaseLoginMobile,
            style: typoExtraSmallTextRegular.copyWith(
                color: colorGrey80, fontSize: 13.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                'OTP',
                style: typoExtraSmallTextBold,
              ),
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 10,),
          BlocBuilder<OtpCubit, OtpState>(
              bloc: _bloc,
              builder: (c, state) => AppTextField(
                controller: otpController,
                autofocus: true,
                keyboardType: TextInputType.phone,
                textStyle: typoExtraSmallTextRegular,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 6.w, bottom: 6.h),
                  hintStyle: typoSuperSmallTextBold.copyWith(
                      color: colorText40),
                  hintText: 'Nhap otp',
                  border:
                  UnderlineInputBorder(borderSide: borderSize()),
                  focusedBorder:
                  UnderlineInputBorder(borderSide: borderSize()),
                  focusedErrorBorder: const UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: colorSemanticRed100)),
                  errorBorder:
                  UnderlineInputBorder(borderSide: borderSize()),
                  enabledBorder:
                  UnderlineInputBorder(borderSide: borderSize()),
                  enabled: true,
                  isDense: true,
                  prefixIconConstraints:
                  BoxConstraints(maxHeight: 15.h),
                ),
                hintStyle:
                typoExtraSmallTextBold.copyWith(color: colorText40),
                hintText: AppLocalizations.of(context)!.yourPhone,
              )),
          Center(
            child: AppButton(
              onPress: () {},
              title: AppLocalizations.of(context)!.continueButton,
              textStyle: typoLargeTextBold.copyWith(
                  fontSize: 13.sp, color: colorWhite),
              borderRadius: 30,
              width: MediaQuery.of(context).size.width / 1.5,
              backgroundColor: colorPrimaryOrange,
            ),
          ),
        ],
      ),
    );
  }

  BorderSide borderSize() => const BorderSide(color: colorSemanticRed100);
}
