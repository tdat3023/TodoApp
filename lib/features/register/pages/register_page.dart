// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hcm23_03/features/login/pages/login_page.dart';
import 'package:hcm23_03/features/global/presentation/base_screen/base_screen.dart';

import '../../../shared/shared_ui/btn/btn_default/btn_default.dart';
import '../../../shared/shared_ui/inputs/input_clear/input_clear.dart';
import '../../../shared/shared_ui/inputs/input_normal/input_normal_layout_mixin.dart';
import '../../../shared/shared_ui/themes/colors.dart';
import '../../../shared/shared_ui/themes/text_styles.dart';
import '../cubit/register_cubit.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/RegisterPage';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FeedbackType passwordFeedbackType = FeedbackType.none;
  String? feedbackMessage;

  void register() {
    context.read<RegisterCubit>().registerWithUsernameAndPw(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (context) {
      return BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Đăng ký"),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Image.asset("assets/images/image_login.png"),
                    ),
                    Text(
                      "Xin chào Người dùng!",
                      style: tStyle.paragraph18().w500().copyWith(
                            color: Hcm23Colors.colorTextTitle,
                          ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Vui lòng điền thông tin tài khoản để đăng ký!",
                      style: tStyle
                          .paragraph14()
                          .w400()
                          .copyWith(color: Hcm23Colors.colorTextPhude),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputClear(
                      controller:
                          context.read<RegisterCubit>().usernameController,
                      placeholderText: "Tài khoản",
                      clearButton: SvgPicture.asset(
                        "assets/icons/ui_kit/bold/close_square.svg",
                        fit: BoxFit.scaleDown,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/ui_kit/normal/user.svg",
                          color: const Color(0XFFA2AEBD),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    InputClear(
                      controller:
                          context.read<RegisterCubit>().passwordController,
                      placeholderText: "Mật khẩu",
                      obscureText: state.hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/ui_kit/bold/lock.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        suffixIcon: InkWell(
                          onTap:
                              context.read<RegisterCubit>().toogleHidePassword,
                          child: SvgPicture.asset(
                            state.hidePassword
                                ? "assets/icons/ui_kit/bold/hide.svg"
                                : "assets/icons/ui_kit/bold/show.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      clearButton: SvgPicture.asset(
                        "assets/icons/ui_kit/bold/close_square.svg",
                        fit: BoxFit.scaleDown,
                      ),
                      feedBackType: passwordFeedbackType,
                      feedbackMessage: feedbackMessage,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    BtnDefault(
                      title: "Đăng ký",
                      onTap: register,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Hoặc",
                      style: tStyle
                          .paragraph14()
                          .w400()
                          .copyWith(color: Hcm23Colors.colorTextPhude),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    BtnDefault(
                      type: BtnDefaultType.secondary,
                      title: "Đăng nhập",
                      onTap: () {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName(LoginPage.routeName));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
