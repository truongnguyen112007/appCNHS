import 'package:base_bloc/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../gen/assets.gen.dart';
import '../../theme/colors.dart';

class NewDetail extends StatefulWidget {
  final int index;

  const NewDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<NewDetail> createState() => _NewDetailState();
}

class _NewDetailState extends BasePopState<NewDetail> {
  @override
  Widget buildWidget(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
        title: const AppText(
          'Detail page demo',
          style: TextStyle(color: colorWhite),
        ),
        backgroundColor: colorPrimaryOrange,
      ),
      body: Stack(children: [
        Container(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Divider(
              color: colorGrey50,
              thickness: 1,
            ),
            Container(
              color: colorPrimaryOrange,
              height: size.height / 15,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(onTap: () {}, child: Icon(Icons.chevron_left)),
                  Text('1'),
                  Text('/'),
                  Text('200'),
                  InkWell(onTap: () {}, child: Icon(Icons.chevron_right))
                ],
              ),
            )
          ],
        )
      ]),
    );
  }

  @override
  int get tabIndex => widget.index;
}
