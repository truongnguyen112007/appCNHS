import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import '../../router/application.dart';

class RootAdd extends StatefulWidget {
  const RootAdd({Key? key}) : super(key: key);

  @override
  State<RootAdd> createState() => _RootAddState();
}

class _RootAddState extends State<RootAdd> {
  final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'HomeRoot');

  @override
  void initState() {
    configRouter();
    super.initState();
  }

  void configRouter() {
    var router = FluroRouter();
    AddRouters.configureRoutes(router);
    Application.routerAdd = router;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: Application.routerAdd.generator,
        ),
        onWillPop: () async => _navigatorKey.currentState!.canPop());
  }
}
