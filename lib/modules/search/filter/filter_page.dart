import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/search/filter/filter_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../gen/assets.gen.dart';
import '../../../localizations/app_localazations.dart';
import '../../../theme/colors.dart';
import 'filter_cubit.dart';

class FilterPage extends StatefulWidget {
  final int index;

  const FilterPage({Key? key, required this.index}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends BasePopState<FilterPage> {
  late FilterCubit _bloc;

  @override
  void initState() {
    _bloc = FilterCubit();
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
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
        title: Text(AppLocalizations.of(context)!.titleFilter),
        backgroundColor: colorPrimaryOrange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.h, left: 12.w),
            child: AppText(AppLocalizations.of(context)!.nameCheckBox,
                style: typoExtraSmallTextBold),
          ),
          itemListRadio(AppLocalizations.of(context)!.radioButton0, 0),
          itemListRadio(AppLocalizations.of(context)!.radioButton1, 1),
          itemListRadio(AppLocalizations.of(context)!.radioButton2, 2),
          itemListRadio(AppLocalizations.of(context)!.radioButton3, 3),
          itemListRadio(AppLocalizations.of(context)!.radioButton4, 4),
          itemListRadio(AppLocalizations.of(context)!.radioButton5, 5),
          itemListRadio(AppLocalizations.of(context)!.radioButton6, 6),
          itemListRadio(AppLocalizations.of(context)!.radioButton7, 7),
          itemListRadio(AppLocalizations.of(context)!.radioButton8, 8),
        ],
      ),
    );
  }

  Widget itemListRadio(String text, int index) {
    return BlocBuilder<FilterCubit, FilterState>(
      bloc: _bloc,
      builder: (c, state) => Padding(
        padding: EdgeInsets.only(top: 12.h, left: 12.w),
        child: InkWell(
          onTap: () {
            _bloc.onClickRadioButton(index);
          },
          child: Row(
            children: [
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: state.currentIndex == index
                          ? colorPrimaryOrange
                          : colorGrey50,
                      width: 1.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Visibility(
                  visible: state.currentIndex == index ? true : false,
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: colorPrimaryOrange,
                      size: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 13.w,
              ),
              AppText(
                text,
                style: typoSuperSmallTextRegular.copyWith(
                    color: state.currentIndex == index
                        ? colorPrimaryOrange
                        : colorBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  int get tabIndex => widget.index;
}
