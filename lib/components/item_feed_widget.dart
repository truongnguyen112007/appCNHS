import 'package:base_bloc/data/model/feed_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../localizations/app_localazations.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import '../utils/app_utils.dart';
import 'app_text.dart';
import 'highlight_text.dart';

class ItemFeedWidget extends StatelessWidget {
  final int index;
  final FeedModel model;
  final String highLight;
  final Function(FeedModel) callback;
  final bool isSearch;

  const ItemFeedWidget(
      {Key? key,
      required this.index,
      required this.model,
      required this.callback,
      this.isSearch = false, required this.highLight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(model),
      child: Container(
        color: (index % 2 == 0)
            ? colorPrimaryOrange.withOpacity(0.12)
            : colorWhite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSearch
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(top: 8.h, right: 5.w, left: 5.w),
                    child: const Icon(
                      Icons.circle_sharp,
                      size: 5,
                    ),
                  ),
                Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isSearch
                        ? Padding(
                            padding: const EdgeInsets.all(5),
                            child:  TextHighlight(
                              text: model.name ?? '',
                              words: {
                                highLight: HighlightedWord(
                                    textStyle: typoSuperSmallTextRegular.copyWith(
                                        color: colorSemanticRed100),padding: EdgeInsets.all(0))
                              },
                              matchCase: false,
                              textStyle:typoSuperSmallTextRegular,
                            ),
                          )
                        : AppText(
                            model.name ?? '',
                            maxLine: 4,
                            overflow: TextOverflow.ellipsis,
                            style: typoExtraSmallTextRegular,
                          ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 5.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Spacer(),
                          AppText(
                            AppLocalizations.of(context)!.effectiveFrom,
                            style: typoSuperSmallTextRegular.copyWith(
                                color: colorPrimaryOrange, fontSize: 8.sp),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          AppText(
                            Utils.convertDateTimeToDDMMYY(
                                model.createdAt ?? DateTime.now()),
                            style: typoSuperSmallTextRegular.copyWith(
                                color: colorPrimaryOrange, fontSize: 8.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
