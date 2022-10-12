import 'package:base_bloc/components/app_button.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/localizations/app_localazations.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../base/base_state.dart';
import '../../gen/assets.gen.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  final int index;

  LoginPage({Key? key, required this.index}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePopState<LoginPage> {
  late LoginCubit _bloc;
  final phoneController = TextEditingController();

  @override
  void initState() {
    _bloc = LoginCubit();
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.only(left: contentPadding, top: 20.h,right: contentPadding),
      appbar: AppBar(
        backgroundColor: colorPrimaryOrange,
        centerTitle: true,
        leadingWidth: 30,
        leading: Container(
          padding: EdgeInsets.only(left: 5.w),
          child: InkWell(
              onTap: () {
                Utils.hideKeyboard(context);
                Navigator.pop(context);
              },
              child: SvgPicture.asset(Assets.svg.back,)),
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
                AppLocalizations.of(context)!.phoneNumber,
                style: typoExtraSmallTextBold,
              ),
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Stack(
            children: [
              BlocBuilder<LoginCubit, LoginState>(
                bloc: _bloc,
                builder: (c, state) => AppTextField(
                  controller: phoneController,
                  errorText: state.errorPhone,
                  onChanged: (text) => _bloc.checkValid(text, context),
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  textStyle: typoExtraSmallTextRegular,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 60.w, bottom: 6.h),
                    hintStyle:
                        typoSuperSmallTextRegular.copyWith(color: colorText40),
                    hintText: AppLocalizations.of(context)!.yourPhone,
                    border: UnderlineInputBorder(borderSide: borderSize()),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: borderSize()),
                    focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: colorSemanticRed100)),
                    errorBorder: UnderlineInputBorder(borderSide: borderSize()),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: borderSize()),
                    enabled: true,
                    isDense: true,
                    prefixIconConstraints: BoxConstraints(maxHeight: 15.h),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.png.logophone.path),
                  SizedBox(
                    width: 8.w,
                  ),
                  AppText(
                    "+84",
                    style: typoExtraSmallTextBold,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Center(
            child: AppButton(
              onPress: () =>
                  _bloc.onClickContinue(phoneController.text, context),
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

  BorderSide borderSize() => const BorderSide(color: colorSemanticRed100);

  @override
  int get tabIndex => widget.index;
}
