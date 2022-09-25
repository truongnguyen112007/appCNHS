import 'package:base_bloc/modules/comment/comment_page.dart';
import 'package:base_bloc/modules/search/filter/filter_page.dart';
import 'package:base_bloc/modules/tab_add/tab_add_page.dart';
import 'package:base_bloc/modules/tab_criminal_proceedings/tab_criminal_proceedings_page.dart';
import 'package:base_bloc/modules/tab_home/tab_home_page.dart';
import 'package:base_bloc/modules/tab_instruction/tab_instruction_page.dart';
import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import '../modules/contact/contact_page.dart';
import '../modules/home/home_page.dart';
import '../modules/login/login_page.dart';
import '../modules/new_details/new_detail.dart';
import '../modules/search/search_page.dart';
import '../modules/splash/splash_page.dart';
import '../modules/tab_criminal_law/tab_criminal_law_page.dart';

var routeSplash = Handler(handlerFunc: (c, p) => const SplashPage());

var routeCriminalLaw = Handler(handlerFunc: (c,p) => const TabCriminalLawPage());

var routerCriminalProceedings = Handler(handlerFunc: (c,p) => const TabCriminalProceedingsPage());

var routerInstruction = Handler(handlerFunc: (c,p) => const TabInstructionPage());

var routeHome = Handler(handlerFunc: (c, p) => const HomePage());

var routeTabHome = Handler(handlerFunc: (c, p) => const TabHome());

var routeAdd = Handler(handlerFunc: (c,p) => const TabAdd());

var routeSearch = Handler(
    handlerFunc: (c, p) => SearchPage(index: c!.settings!.arguments as int));
var routeDetail = Handler(
    handlerFunc: (c, p) => NewDetail(index: c!.settings!.arguments as int));

var routeFilter =  Handler(handlerFunc: (c, p) => FilterPage(index: c!.settings!.arguments as int));

var routeLogin = Handler(handlerFunc: (c, p) => LoginPage(index: c!.settings!.arguments as int));

var routeComment = Handler(handlerFunc: (c, p) => CommentPage(index: c!.settings!.arguments as int));
var routeContact = Handler(handlerFunc: (c, p) => ContactPage(index: c!.settings!.arguments as int));
// var routeHome = Handler(handlerFunc: (c, p) => HomePage());
/*var routeTest = Handler(
    handlerFunc: (context, p) => TestPage(
          tabIndex: context!.settings!.arguments as int,
        ));

var routeTabMain = Handler(handlerFunc: (c, p) => TabMain());

var routeTabSecond = Handler(handlerFunc: (c, p) => TabSecond());
var routeTest2 = Handler(
    handlerFunc: (c, p) => Test2Page(tabIndex: c!.settings!.arguments as int));*/
