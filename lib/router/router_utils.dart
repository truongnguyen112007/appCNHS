import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'application.dart';

class RouterUtils {
  static push<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.router.navigateTo(context, route,
        transition: TransitionType.inFromBottom,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static pushHome<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerHome.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static pushAdd<T>(
      {required BuildContext context,
        required String route,
        dynamic argument,
        bool isRemove = false}) async {
    T result = await Application.routerAdd.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static pushCriminalLaw<T>(
      {required BuildContext context,
        required String route,
        dynamic argument,
        bool isRemove = false}) async {
    T result = await Application.routerCriminalLaw.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static pushCriminalProceedings<T>(
      {required BuildContext context,
        required String route,
        dynamic argument,
        bool isRemove = false}) async {
    T result = await Application.routerCriminalProceedings.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static pushInstruction<T>(
      {required BuildContext context,
        required String route,
        dynamic argument,
        bool isRemove = false}) async {
    T result = await Application.routerInstruction.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }
}





