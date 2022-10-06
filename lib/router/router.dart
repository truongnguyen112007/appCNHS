import 'package:base_bloc/router/router_handle.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routers {
  static String root = "/";
  static String home = "/home";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeSplash);
    router.define(home, handler: routeHome);
  }
}

class HomeRouters {
  static String root = "/";
  static String search = "/search";
  static String filter = "/filter";
  static String detail = "/detail";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabHome);
    router.define(search, handler: routeSearch);
    router.define(filter, handler: routeFilter);
    router.define(detail, handler: routeDetail);
  }
}

class AddRouters {
  static String root = "/";
  static String login = "/login";
  static String comment = "/comment";
  static String contact = "/contact";
  static String search = "/search";
  static String otp ='/otp';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeAdd);
    router.define(login, handler: routeLogin);
    router.define(comment, handler: routeComment);
    router.define(contact, handler: routeContact);
    router.define(search, handler: routeSearch);
    router.define(otp, handler: routeOtp);

  }
}
class CriminalLawRouters {
  static String root = "/";
  static String search = "/search";
  static String detail = "/detail";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeCriminalLaw1);
    router.define(search, handler: routeSearch);
    router.define(detail, handler: routeDetail);
  }
}

class CriminalProceedingsRouters {
  static String root = "/";
  static String search = "/search";
  static String detail = "/detail";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routerCriminalProceedings);
    router.define(search, handler: routeSearch);
    router.define(detail, handler: routeDetail);
  }
}

class InstructionRouters {
  static String root = "/";
  static String search = "/search";
  static String detail = "/detail";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routerInstruction);
    router.define(search, handler: routeSearch);
    router.define(detail, handler: routeDetail);
  }
}





