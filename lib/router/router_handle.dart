import 'package:fluro/fluro.dart';
import '../modules/home/home_page.dart';
import '../modules/search/search_page.dart';
import '../modules/splash/splash_page.dart';

var routeSplash = Handler(handlerFunc: (c, p) => const SplashPage());

var routeHome = Handler(handlerFunc: (c,p)=> const HomePage());

var routeSearch = Handler(handlerFunc: (c,p) => const SearchPage());

// var routeHome = Handler(handlerFunc: (c, p) => HomePage());
/*var routeTest = Handler(
    handlerFunc: (context, p) => TestPage(
          tabIndex: context!.settings!.arguments as int,
        ));

var routeTabMain = Handler(handlerFunc: (c, p) => TabMain());

var routeTabSecond = Handler(handlerFunc: (c, p) => TabSecond());
var routeTest2 = Handler(
    handlerFunc: (c, p) => Test2Page(tabIndex: c!.settings!.arguments as int));*/
