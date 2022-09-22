import 'package:flutter/cupertino.dart';
import '../../base/base_state.dart';

class LoginPage extends StatefulWidget {
  final int index;
  const LoginPage({Key? key, required this.index}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePopState<LoginPage> {

  @override
  Widget buildWidget(BuildContext context) {
    return Container();
  }

  @override
  int get tabIndex => widget.index;
}
