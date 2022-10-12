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
    return Column(
      children: [
        Expanded(
            child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            NewDetail(
              index: widget.index,
              postId: widget.model?.prevId ?? 1,
            ),
            NewDetail(
              index: widget.index,
              postId: (widget.model?.id ?? 1),
            ),
            NewDetail(
              index: widget.index,
              postId: widget.model?.nextId ?? 1,
            )
          ],
        )),
        Container(
          height: 1,
          color: colorGrey80,
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (currentPage == 0) return;
                  currentPage--;
                  jumToPage(currentPage);
                },
                child: Icon(
                  Icons.chevron_left,
                  color: colorPrimaryOrange,
                  size: 25.sp,
                ),
              ),
              AppText(
                '${currentPage + 1}',
                style: typoLargeTextBold.copyWith(color: colorPrimaryOrange),
              ),
              Text(
                '/',
                style: TextStyle(color: colorPrimaryOrange, fontSize: 25.sp),
              ),
              AppText(
                '3',
                style: typoLargeTextBold.copyWith(color: colorPrimaryOrange),
              ),
              InkWell(
                onTap: () {
                  if (currentPage == 2) return;
                  currentPage++;
                  jumToPage(currentPage);
                },
                child: Icon(
                  Icons.chevron_right,
                  color: colorPrimaryOrange,
                  size: 25.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void jumToPage(int index) {
    pageController.jumpToPage(index);
    setState(() {});
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
