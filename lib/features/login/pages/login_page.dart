import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hcm23_03/features/register/pages/register_page.dart';
import 'package:hcm23_03/features/global/presentation/base_screen/base_screen.dart';

import '../../../shared/shared_ui/btn/btn_default/btn_default.dart';
import '../../../shared/shared_ui/inputs/input_clear/input_clear.dart';
import '../../../shared/shared_ui/inputs/input_normal/input_normal_layout_mixin.dart';
import '../../../shared/shared_ui/themes/colors.dart';
import '../../../shared/shared_ui/themes/text_styles.dart';
import '../../forget_password/pages/forget_password_page.dart';
import '../cubit/login_cubit.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginPage extends StatefulWidget {
  static const String routeName = "/LoginPage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void login() {
    context.read<LoginCubit>().loginWithUsernameAndPw(context);
  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("Hello HCM23 03"),
      ],
    ),
  );

  // _showBuilderToast() {
  //   fToast.showToast(
  //       child: toast,
  //       gravity: ToastGravity.BOTTOM,
  //       toastDuration: const Duration(seconds: 2),
  //       positionedToastBuilder: (context, child) {
  //         return Positioned(
  //           top: 16.0,
  //           left: 16.0,
  //           child: child,
  //         );
  //       });
  // }

  FeedbackType feedbackType = FeedbackType.none;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  String? feedbackMessage;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (context) {
      return BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image and title
                    Image.asset("assets/images/image_login.png"),
                    Text(
                      "Xin chào",
                      style: tStyle.paragraph18().w500().copyWith(
                            color: Hcm23Colors.colorTextTitle,
                          ),
                    ),
                    Text(
                      "Vui lòng đăng nhập để sử dụng ứng dụng",
                      style: tStyle
                          .paragraph14()
                          .w400()
                          .copyWith(color: Hcm23Colors.colorTextPhude),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //input username
                    InputClear(
                      controller: context.read<LoginCubit>().usernameController,
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
                      controller: context.read<LoginCubit>().passwordController,
                      placeholderText: "Mật khẩu",
                      obscureText: state.hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/ui_kit/bold/lock.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        suffixIcon: InkWell(
                          onTap: context.read<LoginCubit>().toogleHidePassword,
                          child: SvgPicture.asset(
                            (state.hidePassword)
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
                      feedBackType: feedbackType,
                      feedbackMessage: feedbackMessage,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(ForgetPasswordPage.routeName);
                            },
                            child: Text(
                              "Quên mật khẩu?",
                              style: tStyle
                                  .display14()
                                  .w500()
                                  .copyWith(color: Hcm23Colors.color2),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: state.rememberAccount,
                              onChanged: context
                                  .read<LoginCubit>()
                                  .changeRememberAccount,
                            ),
                            Text(
                              "Ghi nhớ tài khoản.",
                              style: tStyle
                                  .display14()
                                  .w500()
                                  .copyWith(color: Hcm23Colors.color2),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    BtnDefault(
                      onTap: login,
                      title: "Đăng nhập",
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    RichText(
                        text: TextSpan(
                      text: "Chưa có tài khoản? ",
                      style: tStyle
                          .paragraph14()
                          .w400()
                          .copyWith(color: Hcm23Colors.colorTextPhude),
                      children: [
                        TextSpan(
                            text: "Đăng ký",
                            style: tStyle
                                .display14()
                                .w500()
                                .copyWith(color: Hcm23Colors.color2),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed(RegisterPage.routeName);
                              }),
                      ],
                    )),

                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          onTapCancel: () {},
                          child: Ink(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: Hcm23Colors.color3.withOpacity(0.1),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/fingerprint.svg",
                              fit: BoxFit.scaleDown,
                              color: Hcm23Colors.color3,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        //face id
                        GestureDetector(
                          onTap: () {},
                          onTapCancel: () {},
                          child: Ink(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: Hcm23Colors.color3.withOpacity(0.1),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/face_id.svg",
                              fit: BoxFit.scaleDown,
                              color: Hcm23Colors.color3,
                            ),
                          ),
                        ),
                      ],
                    )
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
