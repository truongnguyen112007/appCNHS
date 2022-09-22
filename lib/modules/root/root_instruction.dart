import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import '../../router/application.dart';

class RootInstruction extends StatefulWidget {
  const RootInstruction({Key? key}) : super(key: key);

  @override
  State<RootInstruction> createState() => _RootInstructionState();
}

class _RootInstructionState extends State<RootInstruction> {
  final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'InstructionRoot');

  @override
  void initState() {
    configRouter();
    super.initState();
  }

  void configRouter() {
    var router = FluroRouter();
    InstructionRouters.configureRoutes(router);
    Application.routerInstruction = router;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: Application.routerInstruction.generator,
        ),
        onWillPop: () async => _navigatorKey.currentState!.canPop());
  }
}
