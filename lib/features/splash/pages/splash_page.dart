import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcm23_03/features/splash/cubit/splash_cubit.dart';
import 'package:hcm23_03/features/global/presentation/base_screen/base_screen.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SplashCubit>().checkNewUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (context) {
      return const Scaffold();
    });
  }
}
