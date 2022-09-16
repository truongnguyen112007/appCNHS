import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/app_scalford.dart';
import '../../gen/assets.gen.dart';
import '../../localizations/app_localazations.dart';

class SearchPage extends StatefulWidget {
  final int index;

  const SearchPage({Key? key, required this.index}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends BasePopState<SearchPage> {
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
              child: SvgPicture.asset(Assets.svg.back)),
        ),
        backgroundColor: colorPrimaryOrange,
        title: AppTextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            hintStyle: TextStyle(
              color: Color(0xff454545),
            ),
            hintText: AppLocalizations.of(context)!.hinTextSearch,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: colorWhite,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: SvgPicture.asset(Assets.svg.filter))
        ],
      ),
      body: Center(
        child: AppText("TAG SEARCH"),
      ),
    );
  }

  @override
  int get tabIndex => widget.index;
}
