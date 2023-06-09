// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcm23_03/features/home/cubit/home_cubit.dart';
import 'package:hcm23_03/features/home/widgets/home_drawer.dart';
import 'package:hcm23_03/features/task/pages/all_task_pages.dart';
import 'package:hcm23_03/features/task/pages/new_task_page.dart';

import '../../global/presentation/base_screen/base_screen.dart';
import '../../task/cubits/today_tasks/today_tasks_cubit.dart';

import 'package:hcm23_03/features/weather/pages/weather_page.dart';

import '../../task/pages/today_tasks_page.dart';
import '../widgets/home_bottom_bar.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void changePage(int? idx) {
    context.read<HomeCubit>().changePage(idx);
  }

  @override
  void initState() {
    super.initState();
  }

  void createNewTask(int index) async {
    await Navigator.of(context).pushNamed(NewTaskPage.routeName);
  }

  void searchWeatherByCity() {}

  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (context) {
      return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            drawer: const HomeDrawer(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (state.currentPage != 2) {
                  createNewTask(state.currentPage);
                } else {}
              },
              backgroundColor: const Color(0xFFB7ABFD),
              child: Icon(state.currentPage != 2 ? Icons.add : Icons.search),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: HomeBottomBar(
              hasNotch: true,
              fabLocation: BubbleBottomBarFabLocation.end,
              opacity: .2,
              currentIndex: state.currentPage,
              onTap: changePage,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              elevation: 8,
              tilesPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              items: const <BubbleBottomBarItem>[
                BubbleBottomBarItem(
                  showBadge: true,
                  // badge: Text("1"),
                  badgeColor: Colors.deepPurpleAccent,
                  backgroundColor: Colors.red,
                  icon: Icon(
                    Icons.dashboard,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.dashboard,
                    color: Colors.red,
                  ),
                  title: Text("All Tasks"),
                ),
                BubbleBottomBarItem(
                    backgroundColor: Colors.deepPurple,
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                    activeIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.deepPurple,
                    ),
                    title: Text("T Tasks")),
                BubbleBottomBarItem(
                    backgroundColor: Colors.deepPurple,
                    icon: Icon(
                      Icons.cloud,
                      color: Colors.black,
                    ),
                    activeIcon: Icon(
                      Icons.cloud,
                      color: Colors.deepPurple,
                    ),
                    title: Text("Weather")),
              ],
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: context.read<HomeCubit>().pageController,
              children: [
                const AllTasksPage(),
                BlocProvider(
                  create: (context) => TodayTasksCubit()..getTask(context),
                  child: const TodayTasksPage(),
                ),
                const Scaffold(
                  body: WeatherProvider(),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
