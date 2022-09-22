import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import '../../router/application.dart';

class RootCriminalProceedings extends StatefulWidget {
  const RootCriminalProceedings({Key? key}) : super(key: key);

  @override
  State<RootCriminalProceedings> createState() => _RootCriminalProceedingsState();
}

class _RootCriminalProceedingsState extends State<RootCriminalProceedings> {
  final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'CriminalProceedingRoot');

  @override
  void initState() {
    configRouter();
    super.initState();
  }

  void configRouter() {
    var router = FluroRouter();
    CriminalProceedingsRouters.configureRoutes(router);
    Application.routerCriminalProceedings = router;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: Application.routerCriminalProceedings.generator,
        ),
        onWillPop: () async => _navigatorKey.currentState!.canPop());
  }
}
