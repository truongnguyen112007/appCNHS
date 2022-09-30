import 'package:base_bloc/modules/splash/splash_cubit.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/app_scalford.dart';
import '../../gen/assets.gen.dart';

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
        fullStatusBar: true,
        body: InkWell(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  colorPrimaryOrange,
                  colorPrimaryOrange,
                ],
                    begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.png.laws.path,width: 150,),
                SizedBox(height: 10.h,),
                Image.asset(Assets.png.cnhs.path,width: 170,)
              ],
            ),
          ),
          onTap: () => _bloc.openHomePage(context),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
