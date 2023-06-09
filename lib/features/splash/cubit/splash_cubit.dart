// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hcm23_03/features/global/data/entities/hcm23_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/cubit/auth_cubit.dart';
import '../../login/cubit/login_cubit.dart';
import '../../login/pages/login_page.dart';
import '../../onboarding/pages/onboarding_page.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> checkNewUser(BuildContext ctx) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool? value = preferences.getBool(onboardingKey);

    if (value == false) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final jsonString = preferences.getString(
        rememberAccountKey,
      );
      if (jsonString != null) {
        final Hcm23User user = Hcm23User.fromJson(jsonString);
        ctx.read<AuthCubit>().loginWithUsernameAndPw(
            username: user.email ?? "",
            password: user.password ?? "",
            ctx: ctx);
      } else {
        Navigator.of(ctx)
            .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
      }
    } else {
      Navigator.of(ctx)
          .pushNamedAndRemoveUntil(OnboardingPage.routeName, (route) => false);
    }
  }
}
