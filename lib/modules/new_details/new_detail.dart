import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/data/model/feed_model.dart';
import 'package:base_bloc/localizations/app_localazations.dart';
import 'package:base_bloc/modules/new_details/new_detail_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../gen/assets.gen.dart';
import '../../theme/colors.dart';
import 'new_detail_cubit.dart';

class NewDetail extends StatefulWidget {
  final int index;
  final FeedModel? model;
  final int? postId;

  const NewDetail({Key? key, required this.index, this.model, this.postId})
      : super(key: key);

  @override
  State<NewDetail> createState() => _NewDetailState();
}

class _NewDetailState extends State<NewDetail>
    with AutomaticKeepAliveClientMixin {
  late NewDetailCubit _bloc;

  @override
  void initState() {
    _bloc = NewDetailCubit(widget.postId ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewDetailCubit, NewDetailState>(
        bloc: _bloc,
        builder: (c, state) {
          if (state.status == FeedStatus.initial) {
            return const Center(
              child: AppCircleLoading(),
            );
          }
          if (state.status == FeedStatus.success) {
            return PageView(
              children: [
                for (int i = 0;
                    i < (state.postDetailModel?.data?.length ?? 0);
                    i++)
                  AppScaffold(
                    backgroundColor: colorWhite,
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
                      title: AppText(
                        state.postDetailModel!.data![i].name ?? '',
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        style: typoExtraSmallTextRegular.copyWith(
                            fontSize: 15, color: colorWhite),
                      ),
                      backgroundColor: colorPrimaryOrange,
                    ),
                    body: Column(children: [
                      Expanded(
                        child: InAppWebView(
                          initialOptions: InAppWebViewGroupOptions(
                            android: AndroidInAppWebViewOptions(
                                textZoom:
                                    (MediaQuery.of(context).textScaleFactor *
                                            230)
                                        .ceil()),
                            crossPlatform: InAppWebViewOptions(
                                preferredContentMode:
                                    UserPreferredContentMode.MOBILE),
                          ),
                          onWebViewCreated: (ctrl) {},
                          onLoadStop: (ctrl, uri) {},
                          initialData: InAppWebViewInitialData(
                              data: state.postDetailModel!.data![i].content ??
                                  ''),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 1,
                            color: colorGrey80,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: colorPrimaryOrange,
                                    size: 25.sp,
                                  ),
                                ),
                                AppText(
                                  '1',
                                  style: typoLargeTextBold.copyWith(
                                      color: colorPrimaryOrange),
                                ),
                                Text(
                                  '/',
                                  style: TextStyle(
                                      color: colorPrimaryOrange,
                                      fontSize: 25.sp),
                                ),
                                AppText(
                                  '3',
                                  style: typoLargeTextBold.copyWith(
                                      color: colorPrimaryOrange),
                                ),
                                InkWell(
                                  onTap: () {},
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
                      )
                    ]),
                  ),
              ],
            );
          } else if (state.status == FeedStatus.failure) {
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
                  backgroundColor: colorPrimaryOrange,
                ),
                body: Center(
                    child: AppText(
                        AppLocalizations.of(context)!.textTabOfSearch)));
          }
          return const SizedBox();
        });
  }

  @override
  bool get wantKeepAlive => true;
}
