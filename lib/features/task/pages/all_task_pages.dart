import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcm23_03/features/global/cubit/auth_cubit.dart';
import 'package:hcm23_03/shared/shared_ui/inputs/input_clear/input_clear.dart';

import '../widgets/all_task_body.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({super.key});

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  final List<String> image = [
    "assets/images/bandel_1.png",
    "assets/images/bandel_2.png",
    "assets/images/bandel_3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 100, right: 20),
            child: Row(
              children: [
                Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (context.read<AuthCubit>().state as Authenticated)
                                .user
                                .user
                                ?.displayName ??
                            "User",
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text("39 tasks today",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 55,
                  height: 55,
                  child: GestureDetector(
                    onTap: () {}, // Image tapped
                    child: SvgPicture.asset(
                      'assets/icons/ui_kit/bold/message.svg',
                      fit: BoxFit.fill,
                      width: 30.0,
                      height: 48.0, // Fixes border issues
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: InputClear(
                clearButton: SvgPicture.asset(
                  "assets/icons/ui_kit/bold/close_square.svg",
                  fit: BoxFit.scaleDown,
                ),
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    "assets/icons/ui_kit/bold/search.svg",
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //     prefixIcon: Container(
              //         width: 10.0,
              //         height: 10.0,
              //         margin: const EdgeInsets.all(7),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: const Color.fromARGB(255, 196, 199, 196),
              //             width: 2,
              //           ),
              //           shape: BoxShape.circle,
              //         ),
              //         child: const Icon(Icons.search)),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //         width: 1,
              //         color: Colors.black,
              //       ),
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //     hintText: 'Search task..',
              //   ),
              // ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              autoPlayCurve: Curves.easeInOut,
            ),
            items: image.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(image),
                  );
                },
              );
            }).toList(),
          ),
          const Expanded(child: AllTasksBody()),
        ],
      ),
    );
  }
}
