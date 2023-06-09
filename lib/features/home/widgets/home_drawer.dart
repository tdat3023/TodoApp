import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcm23_03/features/change_password/pages/change_password_page.dart';
import 'package:hcm23_03/features/home/cubit/home_cubit.dart';
import 'package:hcm23_03/features/user/pages/user_profile_pages.dart';
import 'package:hcm23_03/shared/shared_ui/btn/btn_default/btn_default.dart';
import 'package:hcm23_03/shared/shared_ui/themes/text_styles.dart';

final List<Map<String, String>> menu = [
  {
    "Thông tin User": UserProfilePage.routeName,
  },
  {
    "Đổi mật khẩu": ChangePasswordPage.routeName,
  }
];

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  void logout() {
    context.read<HomeCubit>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xFFB7ABFD),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.green,
                child: CircleAvatar(
                  radius: 58,
                  backgroundImage: NetworkImage(
                    "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1049.jpg",
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Wang Yin",
                style: tStyle.display18().cTitle(),
              ),
              const SizedBox(
                width: 8,
              ),
              const Icon(
                Icons.check_rounded,
                color: Colors.green,
              )
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(menu[index].entries.first.value);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(menu[index].keys.first),
                          const Icon(
                            Icons.arrow_right,
                          )
                        ],
                      )));
            }),
            separatorBuilder: ((context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                ),
              );
            }),
            itemCount: menu.length,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: BtnDefault(
              onTap: logout,
              type: BtnDefaultType.secondary,
              title: "Đăng xuất",
            ),
          )
        ],
      ),
    );
  }
}
