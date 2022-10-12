import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/modules/new_details/new_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/app_text.dart';
import '../../data/model/feed_model.dart';
import '../../gen/assets.gen.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class FeedDetailPage extends StatefulWidget {
  final int index;
  final FeedModel? model;

  const FeedDetailPage({Key? key, required this.index, this.model})
      : super(key: key);

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends BasePopState<FeedDetailPage> {
  var currentPage = 1;
  var pageController = PageController(initialPage: 1);

  @override
  void initState() {
    pageController.addListener(() {
      final newPage = pageController.page!.round();
      if (currentPage != newPage) {
        currentPage = newPage;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(children: [PageView(
      controller: pageController,
      children: [
        NewDetailPage(
          index: widget.index,
          postId: widget.model?.prevId ?? 1,
          titleCallback: (title) {},
        ),
        NewDetailPage(
          index: widget.index,
          postId: (widget.model?.id ?? 1),
          titleCallback: (title) {},
        ),
        NewDetailPage(
          index: widget.index,
          postId: widget.model?.nextId ?? 1,
          titleCallback: (title) {},
        )
      ],
    ),
    ],);
  }

  PreferredSizeWidget appbar(BuildContext context, String title) => AppBar(
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
        title: AppText(
          title,
          maxLine: 1,
          overflow: TextOverflow.ellipsis,
          style: typoExtraSmallTextRegular.copyWith(
              fontSize: 15, color: colorWhite),
        ),
        backgroundColor: colorPrimaryOrange,
      );

  @override
  int get tabIndex => widget.index;
}
