import 'package:flutter/material.dart';
import 'package:hcm23_03/features/login/pages/login_page.dart';
import 'package:hcm23_03/features/onboarding/widgets/onboarding_floatting_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String onboardingKey = "onboardingK";

class OnboardingPage extends StatefulWidget {
  static const String routeName = "/OnboardingPage";
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();
  int currentStep = 1;
  @override
  void initState() {
    super.initState();
  }

  void handleFloatingActionButton() async {
    setState(() {
      if (currentStep < 2 && currentStep >= 0) {
        pageController.animateToPage(currentStep,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        saveOnboardingKey();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
      }
    });
  }

  void saveOnboardingKey() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(onboardingKey, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: YinFloatingActionButton(
        args: YinFloatingActionButtonArgs(
          size: 58,
          scaffoldBackgroundColor: const Color(0xFFB7ABFD),
          currentStep: currentStep,
          stepCount: 2,
          onTap: handleFloatingActionButton,
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                currentStep = (value + 1);
              });
            },
            physics: const ClampingScrollPhysics(),
            children: [
              _buildOnboardingStep(
                title: "ONBOARDING TITLE",
                content:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                imageUrl: "assets/images/onboarding_img_1.png",
                bgColor: const Color(0xFFB7ABFD),
              ),
              _buildOnboardingStep(
                title: "ONBOARDING TITLE",
                content:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                imageUrl: "assets/images/onboarding_img_2.png",
                bgColor: const Color(0XFF95B6FF),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 8,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      itemBuilder: (context, idx) {
                        if (idx == currentStep - 1) {
                          return Container(
                            width: 24,
                            height: 8,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              color: const Color(0XFFFFFFFF).withOpacity(0.5),
                            ),
                          );
                        }
                      }),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildOnboardingStep({
    String title = "",
    String content = "",
    String imageUrl = "",
    required Color bgColor,
  }) {
    return Container(
      color: bgColor,
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              content,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 18,
                  height: 24 / 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Expanded(
              child: Image.asset(imageUrl),
            ),
          ],
        ),
      ),
    );
  }
}
