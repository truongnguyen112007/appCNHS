import 'package:base_bloc/data/model/feed_model.dart';
import 'package:base_bloc/modules/comment/comment_page.dart';
import 'package:base_bloc/modules/feed_detail/feed_detail_page.dart';
import 'package:base_bloc/modules/otp/otp_page.dart';
import 'package:base_bloc/modules/search/filter/filter_page.dart';
import 'package:base_bloc/modules/tab_add/tab_add_page.dart';
import 'package:base_bloc/modules/tab_home/tab_home_page.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:fluro/fluro.dart';

import '../config/constant.dart';
import '../localizations/app_localazations.dart';
import '../modules/contact/contact_page.dart';
import '../modules/home/home_page.dart';
import '../modules/login/login_page.dart';
import '../modules/search/search_page.dart';
import '../modules/splash/splash_page.dart';
import '../modules/tab_criminal_law/tab_criminal_law_page.dart';
import '../modules/update_information/update_information_page.dart';

var routeSplash = Handler(handlerFunc: (c, p) => const SplashPage());

var routeCriminalLaw1 = Handler(
  handlerFunc: (c, p) => TabCriminalLawPage(
    tab: BottomnavigationConstant.TAB_CRIMINALLAWPAGE,
    titleAppbar: AppLocalizations.of(c!)!.titleTabCriminalLaw,
    catId: 1,
    itemCallBack: (model) {
      RouterUtils.pushCriminalLaw(
          context: c,
          route: CriminalLawRouters.detail,
          argument: [BottomnavigationConstant.TAB_CRIMINALLAWPAGE, model]);
    },
  ),
);

var routerCriminalProceedings = Handler(
  handlerFunc: (c, p) => TabCriminalLawPage(
    tab: BottomnavigationConstant.TAB_CRIMINALPROCEEDINGSPAGE,
    titleAppbar: AppLocalizations.of(c!)!.titleTabCriminalProceeding,
    catId: 2,
    itemCallBack: (model) {
      RouterUtils.pushCriminalProceedings(
          context: c,
          route: CriminalLawRouters.detail,
          argument: [
            BottomnavigationConstant.TAB_CRIMINALPROCEEDINGSPAGE,
            model
          ]);
    },
  ),
);

var routerInstruction = Handler(
  handlerFunc: (c, p) => TabCriminalLawPage(
    tab: BottomnavigationConstant.TAB_INTRUCTIONPAGE,
    titleAppbar: AppLocalizations.of(c!)!.titleTabInstruction,
    catId: 3,
    itemCallBack: (model) {
      RouterUtils.pushInstruction(
          context: c,
          route: CriminalLawRouters.detail,
          argument: [BottomnavigationConstant.TAB_INTRUCTIONPAGE, model]);
    },
  ),
);

var routeHome = Handler(handlerFunc: (c, p) => const HomePage());

var routeTabHome = Handler(handlerFunc: (c, p) => const TabHome());

var routeAdd = Handler(handlerFunc: (c, p) => const TabAdd());

var routeSearch = Handler(
    handlerFunc: (c, p) => SearchPage(index: c!.settings!.arguments as int));

var routeFeedDetail = Handler(
    handlerFunc: (c, p) => FeedDetailPage(
          index: (c!.settings!.arguments as List)[0] as int,
          model: (c.settings!.arguments as List)[1] as FeedModel,
        ));

var routeFilter = Handler(
    handlerFunc: (c, p) => FilterPage(index: c!.settings!.arguments as int));

var routeLogin = Handler(
    handlerFunc: (c, p) => LoginPage(index: c!.settings!.arguments as int));
var routeOtp = Handler(
    handlerFunc: (c, p) =>
        OtpPage(phoneNumber: c!.settings!.arguments as String));
var routeUpdate = Handler(handlerFunc: (c, p) => const UpdateInformation());
var routeComment = Handler(
    handlerFunc: (c, p) => CommentPage(index: c!.settings!.arguments as int));
var routeContact = Handler(
    handlerFunc: (c, p) => ContactPage(index: c!.settings!.arguments as int));
