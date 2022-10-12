import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/localizations/app_localazations.dart';
import 'package:base_bloc/modules/update_information/update_information_cubit.dart';
import 'package:base_bloc/modules/update_information/update_information_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/app_button.dart';
import '../../gen/assets.gen.dart';

class UpdateInformation extends StatefulWidget {
  final String phoneNumber;
  final int userId;

  const UpdateInformation(
      {Key? key, required this.phoneNumber, required this.userId})
      : super(key: key);

  @override
  State<UpdateInformation> createState() => _UpdateInformationState();
}

class _UpdateInformationState extends BasePopState<UpdateInformation> {
  final textController = TextEditingController();
  late UpdateInformationCubit _bloc;

  @override
  void initState() {
    _bloc = UpdateInformationCubit(widget.phoneNumber);
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        leadingWidth: 35,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(Assets.svg.back)),
        ),
        backgroundColor: colorPrimaryOrange,
        centerTitle: true,
        title: AppText(
          AppLocalizations.of(context)!.textButtonUpdateInformation,
          style: typoExtraSmallTextBold.copyWith(color: colorWhite),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 31.h, left: 16.w, right: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(AppLocalizations.of(context)!.name),
            SizedBox(
              height: 5.h,
            ),
            BlocBuilder<UpdateInformationCubit, UpdateInformationState>(
              bloc: _bloc,
              builder: (c, p) => AppTextField(
                errorText: p.errorName,
                controller: textController,
                hintText: AppLocalizations.of(context)!.name,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            AppText(AppLocalizations.of(context)!.phoneNumber),
            SizedBox(
              height: 5.h,
            ),
            AppTextField(
              hintText: widget.phoneNumber.replaceAll('+84', '0'),
              readOnly: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: AppButton(
                onPress: () {
                  _bloc.oncClickButton(textController.text, widget.userId);
                },
                title: AppLocalizations.of(context)!.completed,
                textStyle: typoLargeTextBold.copyWith(
                    fontSize: 13.sp, color: colorWhite),
                borderRadius: 20,
                width: MediaQuery.of(context).size.width / 1,
                backgroundColor: colorPrimaryOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  int get tabIndex => BottomNavigationConstant.TAB_ADD;
}
