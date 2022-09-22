import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import '../../router/application.dart';

class RootCriminalLaw extends StatefulWidget {
  const RootCriminalLaw({Key? key}) : super(key: key);

  @override
  State<RootCriminalLaw> createState() => _RootCriminalLawState();
}

class _RootCriminalLawState extends State<RootCriminalLaw> {
  final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'CriminalLawRoot');

  @override
  void initState() {
    configRouter();
    super.initState();
  }

  void configRouter() {
    var router = FluroRouter();
    CriminalLawRouters.configureRoutes(router);
    Application.routerCriminalLaw = router;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: Application.routerCriminalLaw.generator,
        ),
        onWillPop: () async => _navigatorKey.currentState!.canPop());
  }
}
