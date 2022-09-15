import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../router/application.dart';

class RootHome extends StatefulWidget {
  const RootHome({Key? key}) : super(key: key);

  @override
  State<RootHome> createState() => _RootHomeState();
}

class _RootHomeState extends State<RootHome> {
  final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'HomeRoot');

  @override
  void initState() {
    configRouter();
    super.initState();
  }

  void configRouter() {
    var router = FluroRouter();
    HomeRouters.configureRoutes(router);
    Application.routerHome = router;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: Application.routerHome.generator,
        ),
        onWillPop: () async => _navigatorKey.currentState!.canPop());
  }
}
