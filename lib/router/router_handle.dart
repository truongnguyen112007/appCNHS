import 'dart:ffi';

import 'package:base_bloc/modules/tab_home/tab_home_page.dart';
import 'package:fluro/fluro.dart';
import '../modules/home/home_page.dart';
import '../modules/search/search_page.dart';
import '../modules/splash/splash_page.dart';

var routeSplash = Handler(handlerFunc: (c, p) => const SplashPage());

var routeHome = Handler(handlerFunc: (c, p) => const HomePage());
var routeTabHome = Handler(handlerFunc: (c, p) => const TabHome());

var routeSearch = Handler(
    handlerFunc: (c, p) => SearchPage(index: c!.settings!.arguments as int));

// var routeHome = Handler(handlerFunc: (c, p) => HomePage());
/*var routeTest = Handler(
    handlerFunc: (context, p) => TestPage(
          tabIndex: context!.settings!.arguments as int,
        ));

var routeTabMain = Handler(handlerFunc: (c, p) => TabMain());

var routeTabSecond = Handler(handlerFunc: (c, p) => TabSecond());
var routeTest2 = Handler(
    handlerFunc: (c, p) => Test2Page(tabIndex: c!.settings!.arguments as int));*/
