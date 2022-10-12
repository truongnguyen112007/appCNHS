import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/modules/otp/otp_cubit.dart';
import 'package:base_bloc/modules/otp/otp_state.dart';
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

class OtpPage extends StatefulWidget {
  final String phoneNumber;

  const OtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends BasePopState<OtpPage> {
  final otpController = TextEditingController();
  late OtpCubit _bloc;

  @override
  void initState() {
    _bloc = OtpCubit(widget.phoneNumber);
    super.initState();
  }

  BorderSide borderSize() => const BorderSide(color: colorGrey80);

  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.only(
          left: contentPadding, top: 20.h, right: contentPadding),
      appbar: AppBar(
        backgroundColor: colorPrimaryOrange,
        centerTitle: true,
        leadingWidth: 30,
        leading: Container(
          padding: EdgeInsets.only(left: 5.w),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(Assets.svg.back)),
        ),
        title: AppText(
          AppLocalizations.of(context)!.textButtonLogin,
          style:
              typoExtraSmallTextBold.copyWith(color: colorWhite, fontSize: 17),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            AppLocalizations.of(context)!.sentOTP,
            style: typoLargeTextBold,
          ),
          SizedBox(
            height: 10.h,
          ),
          AppText(
            "${AppLocalizations.of(context)!.codeSentTo} ${widget.phoneNumber.replaceAll('+84', '0')} ${AppLocalizations.of(context)!.checkMessage}",
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
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<OtpCubit, OtpState>(
            bloc: _bloc,
            builder: (c, state) => AppTextField(
              // onChanged: (text) => _bloc.isValid(text),
              controller: otpController,
              errorText: state.errorOTP,
              autofocus: true,
              keyboardType: TextInputType.phone,
              textStyle: typoExtraSmallTextRegular,
              decoration: InputDecoration(
                suffixIconConstraints: BoxConstraints(maxHeight: 24.h),
                suffixIcon: BlocBuilder<OtpCubit, OtpState>(
                  builder: (c, state) => state.timeCountdown == 0
                      ? InkWell(
                          onTap: () {
                            _bloc.resentOnclick();
                          },
                          child: AppText(
                            AppLocalizations.of(context)!.sentAgain,
                            style: typoSuperSmallTextBold.copyWith(
                                color: colorBlue40),
                          ),
                        )
                      : AppText(
                          state.timeDisplay,
                          style: typoSuperSmallTextRegular.copyWith(
                              color: colorPrimaryOrange),
                        ),
                  bloc: _bloc,
                ),
                contentPadding: EdgeInsets.only(left: 0.w, bottom: 6.h),
                hintStyle: typoSuperSmallTextBold.copyWith(color: colorText40),
                hintText: 'Nhập OTP',
                border: UnderlineInputBorder(borderSide: borderSize()),
                focusedBorder: UnderlineInputBorder(borderSide: borderSize()),
                focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorSemanticRed100)),
                errorBorder: UnderlineInputBorder(borderSide: borderSize()),
                enabledBorder: UnderlineInputBorder(borderSide: borderSize()),
                enabled: true,
                isDense: true,
                prefixIconConstraints: BoxConstraints(maxHeight: 15.h),
              ),
            ),
          ),
          Center(
            child: AppButton(
              onPress: () => _bloc.continueOnclick(otpController.text, context),
              title: AppLocalizations.of(context)!.continueButton,
              textStyle: typoLargeTextBold.copyWith(
                  fontSize: 13.sp, color: colorWhite),
              borderRadius: 20,
              width: MediaQuery.of(context).size.width / 1,
              backgroundColor: colorPrimaryOrange,
            ),
          ),
        ],
      ),
    );
  }

  @override
  int get tabIndex => BottomNavigationConstant.TAB_ADD;
}
