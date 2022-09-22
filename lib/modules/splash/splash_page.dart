import 'package:base_bloc/modules/splash/splash_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../localizations/app_localazations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _bloc = SplashCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (c, s) {
        _bloc.openHomePage(context);
      },
      child: AppScaffold(
          body: Center(
        child: TextButton(
          child: AppText(AppLocalizations.of(context)!.appTitle),
          onPressed: () => _bloc.openHomePage(context),
        ),
      )),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
