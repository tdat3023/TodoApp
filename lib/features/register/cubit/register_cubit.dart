// ignore_for_file: use_build_context_synchronously

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hcm23_03/features/global/data/entities/hcm23_user.dart';
import 'package:hcm23_03/features/global/data/repo/auth_repo.dart';

import '../../../shared/shared_ui/dialogs/hcm23_dialog.dart';
import '../../global/cubit/auth_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RegisterCubit()
      : super(const RegisterState(
          hidePassword: true,
        ));

  void registerWithUsernameAndPw(BuildContext ctx) async {
    EasyLoading.show();
    final Either<String, UserCredential> userCre =
        await AuthRepo.createUserWithEmailAndPassword(
      email: usernameController.text,
      password: passwordController.text,
    );
    if (userCre is Right<String, UserCredential>) {
      final DatabaseReference ref = ctx
          .read<AuthCubit>()
          .state
          .db
          .ref("users/${userCre.value.user?.uid}");
      ref.set(UserX.default$(
              uid: userCre.value.user?.uid ?? "",
              email: userCre.value.user?.email ?? "")
          .toMap());

      final DatabaseReference ref2 = ctx
          .read<AuthCubit>()
          .state
          .db
          .ref("tasks/${userCre.value.user?.uid}");
      ref2.set(json);

      ctx.read<AuthCubit>().loginWithUsernameAndPw(
            username: usernameController.text,
            password: passwordController.text,
            ctx: ctx,
            rememberAccount: true,
          );
    } else if (userCre is Left<String, UserCredential>) {
      showDialog(
        context: ctx,
        builder: (context) => HCM23Dialog(
          title: 'Error',
          content: userCre.value,
          backgroundColor: Colors.red.withOpacity(0.4),
          titleTextStyle: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
          actions: [
            CleanDialogActionButtons(
              actionTitle: 'OK',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    EasyLoading.dismiss();
  }

  void toogleHidePassword() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}

var json = [
  {
    "uid": "72dc991a-68e8-418a-9be2-da2db8e0d260",
    "title": "Jed Gordon",
    "description": "sauerkraut charge overheard plaster marketer azimuth ",
    "createdAt": 1684708859096,
    "modifiedAt": 1685130555085,
    "startTime": 1684985917573,
    "dueTime": 1685058671212,
    "teamMembers": [
      {
        "uid": "8479b32a-ffad-47f9-87d2-5c8f11b3ce3f",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "4c843c23-ecba-41bb-8d99-979f8ee14a32",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "02765dcf-0b8d-4ee6-94bb-104a1bee63e2",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "75265802-74c5-4210-81f4-75e1bd773baa",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "6a37ad77-e0ff-4d6b-9b4d-a1e5e6171c18",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "ced7f94a-695c-4f63-a218-c986e630f25a",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "f268ceda-21cd-4944-b684-ddc1a9cc6d35",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "c219bdb6-50e1-47c2-8b8f-232df2be787d",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "07e345d7-47db-4b3d-b722-93765aef30d7",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      }
    ],
    "taskStages": [
      {
        "uid": "1f02173a-681d-4cf5-8f91-fa1db11c990c",
        "isDone": true,
        "description": "cheer bikini ",
        "active": true
      },
      {
        "uid": "b3d6b58b-dc48-484c-9c99-b5461d17706b",
        "isDone": false,
        "description": "darkness administrator ",
        "active": true
      },
      {
        "uid": "6a334ae4-b35a-4e45-ad7c-d8916c2491ea",
        "isDone": false,
        "description": "bloodflow laundry ",
        "active": true
      }
    ],
    "active": false
  },
  {
    "uid": "83022bbb-27e0-4872-976b-b111825f095f",
    "title": "Pamala Hardin",
    "description": "dolphin pike commercial plough dozen draw ",
    "createdAt": 1684802380884,
    "modifiedAt": 1685329359017,
    "startTime": 1684895992261,
    "dueTime": 1685205328060,
    "teamMembers": [
      {
        "uid": "1d4c4c20-978b-4da7-9a36-e47e9ba9fb5d",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "b2c45cd5-d259-4536-ab75-e9fe145c3686",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "7b7822f5-5cae-4130-9b9c-d9d4ca4e9a0f",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "1a2f03ef-95fe-4b58-836e-04ac1924b604",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "1382dd23-e089-47fd-8d80-b198d7d321d0",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "adfa20e4-3d78-4990-9f02-d817b60d6526",
        "isDone": true,
        "description": "boon height ",
        "active": true
      },
      {
        "uid": "aeea5c5a-a618-435c-8f0a-b90327d06ef2",
        "isDone": true,
        "description": "ornament halloween ",
        "active": false
      },
      {
        "uid": "57caf5be-20fa-4e26-b760-e91b4e6ec694",
        "isDone": true,
        "description": "seaweed blue ",
        "active": false
      }
    ],
    "active": false
  },
  {
    "uid": "14c35fc0-1ada-4f47-a0c9-8fc9f340bb67",
    "title": "China Serrano",
    "description":
        "overnighter bathroom codling following counselling version ",
    "createdAt": 1685415981483,
    "modifiedAt": 1685156166420,
    "startTime": 1685265683996,
    "dueTime": 1684864534652,
    "teamMembers": [
      {
        "uid": "851e4712-361f-46e8-be9f-85504e37219f",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "892685a1-2f39-4bf3-802f-a315af470f6f",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "8e6a3cb5-f715-475c-9bd4-5855087b566a",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "fcdb3797-40eb-4d09-9cf9-a7b57954c70e",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "dff82cd0-161b-4a9f-9605-ee44de4faa5c",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "cbd0e75b-6f0e-4792-8681-0d3279adf9b4",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      }
    ],
    "taskStages": [
      {
        "uid": "75011093-35f6-4bcd-ad9a-cf5ba2df458c",
        "isDone": true,
        "description": "trombone plumber ",
        "active": true
      },
      {
        "uid": "71d79312-8f04-4a48-a645-212dbb6b5497",
        "isDone": false,
        "description": "inconvenience underpants ",
        "active": false
      },
      {
        "uid": "c1fd6e6e-52db-427e-898f-785ee360d461",
        "isDone": true,
        "description": "ukulele fruit ",
        "active": false
      },
      {
        "uid": "abe50062-d2b4-4b13-9f7e-3bcee7ef8fd9",
        "isDone": true,
        "description": "romaine milepost ",
        "active": true
      },
      {
        "uid": "f27b417f-be35-4843-a1df-0658473f2324",
        "isDone": true,
        "description": "crewmate transcript ",
        "active": true
      }
    ],
    "active": false
  },
  {
    "uid": "666d8b7a-9c46-4466-9e46-9e4695698b47",
    "title": "Maud Deleon",
    "description": "border milk carbohydrate governor scrip poppy ",
    "createdAt": 1684783154240,
    "modifiedAt": 1684754772070,
    "startTime": 1685029163526,
    "dueTime": 1685325007789,
    "teamMembers": [
      {
        "uid": "e86ca1fd-2536-4029-8d91-5223d2a2e476",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "d831c2d0-1978-4358-aabd-6243c9e10dc2",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "6723b619-78a4-4046-9eb4-984aaec2c29d",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "6d515269-30c6-4e2d-b4cb-0d1713be5e22",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "58cc5c87-2171-479d-96b3-a44a86c1f6bc",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "c33ed4ff-8558-46c6-a3f3-77de22da79f8",
        "isDone": true,
        "description": "dandelion bathrobe ",
        "active": false
      },
      {
        "uid": "a36f752e-5070-4051-b127-ae31bc86af51",
        "isDone": false,
        "description": "deer perennial ",
        "active": false
      },
      {
        "uid": "e3b9d939-ca90-4ce9-9f8e-2110c03533e9",
        "isDone": false,
        "description": "meteorology herb ",
        "active": false
      },
      {
        "uid": "930d4201-1526-4787-94be-a5c2ebd4f4d4",
        "isDone": true,
        "description": "arcade cleat ",
        "active": true
      }
    ],
    "active": true
  },
  {
    "uid": "2df7df52-b824-42d9-aba3-9fa8a9c4f28f",
    "title": "Bernetta Sexton",
    "description": "comptroller outrigger recipe insurance curtailment game ",
    "createdAt": 1685091840321,
    "modifiedAt": 1685335139922,
    "startTime": 1684940496698,
    "dueTime": 1685389004659,
    "teamMembers": [
      {
        "uid": "ac7e5609-a91e-47ea-99d6-49f55cb775ba",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "ceb1fabc-5e7c-4bad-94b2-259aff3df0c5",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "6bac8755-3cc1-4ed6-bb57-38ae59c1b541",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "531b02be-5b6b-4a74-b10a-79520d9006e7",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "9cf715fc-0257-4b87-9b99-bdb59588f666",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "d034f1f7-4484-45cc-bcf1-5a3e5176aaca",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "06f634dd-2b8f-4ca8-b957-ed236dcfe409",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "1ae379d5-5570-4f95-8d96-950ebb440bc7",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "a5bcbf00-0054-40b1-ac7d-af7850173da3",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "c0d9904f-ca94-4c6e-baf6-7d2ef77548da",
        "isDone": false,
        "description": "mast mayonnaise ",
        "active": false
      },
      {
        "uid": "576a44c8-6eb1-4af7-a69f-b7c12007eaaa",
        "isDone": false,
        "description": "sprinkles anime ",
        "active": true
      }
    ],
    "active": true
  },
  {
    "uid": "ae2d4377-29f5-4f2d-a4d4-12992845436d",
    "title": "Hong Woodard",
    "description": "current flair mop keystone tadpole opium ",
    "createdAt": 1685080841089,
    "modifiedAt": 1685426864019,
    "startTime": 1684715401949,
    "dueTime": 1684972360356,
    "teamMembers": [
      {
        "uid": "7abe30a7-e717-4bca-b1f8-7148b979c023",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "3ece2b54-e0ce-43eb-b6ec-86f3103e9108",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "b42f04b6-213a-4424-9ffc-f1ceca0a7fa9",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "35aa2d8d-aa5d-42cc-bc19-4020081ab097",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "4ac7269c-0c4b-41e9-9113-935db1d30c8c",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "01b1d8f2-710a-473c-ba11-314181fe4dcb",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "0ba05d21-5e29-408c-a89c-d0fe0b89120f",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "2b86b6dd-8b6c-4979-8d54-bef02b85e98d",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "8bfbc6ad-b7d6-427d-9c68-46d367bfb3b8",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "80bfc64d-280f-4a23-ab88-215b86a36370",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      }
    ],
    "taskStages": [
      {
        "uid": "23e07180-f63e-4fcd-8502-f63ca4d78a8f",
        "isDone": true,
        "description": "step sleep ",
        "active": false
      },
      {
        "uid": "0a60f35f-c242-4392-892c-9139fd58f9d2",
        "isDone": false,
        "description": "draw host ",
        "active": false
      },
      {
        "uid": "fa5895ea-1d9b-440f-ab37-0d5a4a7b2ece",
        "isDone": true,
        "description": "seeder castle ",
        "active": true
      },
      {
        "uid": "88b15ee9-2cc1-4a92-bb3e-285fece3c28f",
        "isDone": false,
        "description": "power daikon ",
        "active": true
      },
      {
        "uid": "c8203441-6f11-491a-9630-5cdcfecdd163",
        "isDone": false,
        "description": "saint neuropsychiatry ",
        "active": true
      },
      {
        "uid": "6348f370-224f-495b-a036-b3b2574e0f5b",
        "isDone": false,
        "description": "chops goat ",
        "active": true
      }
    ],
    "active": false
  },
  {
    "uid": "5edc0e2e-2988-450d-9d1f-49b096d890af",
    "title": "Herta Clemons",
    "description": "importance terminal word catamaran agent absence ",
    "createdAt": 1684958077254,
    "modifiedAt": 1685354469299,
    "startTime": 1685012829935,
    "dueTime": 1685165099987,
    "teamMembers": [
      {
        "uid": "4f7d7942-5cd7-49d2-9260-23c90397d9e5",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "0b4a599e-71b4-41db-924e-d7301ab0005e",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "b860f49a-8a16-4fbf-88f2-4691f4681d02",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "5f057aeb-993f-4318-a074-037f5e92334c",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "15a73ea6-bcf3-4942-8f19-0c7f0c7f5018",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "cf9a5e23-c783-441d-b4d5-42481fb03a7b",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      }
    ],
    "taskStages": [
      {
        "uid": "5a269895-51d2-456d-baff-5bf1ef04e8db",
        "isDone": false,
        "description": "misnomer comics ",
        "active": false
      },
      {
        "uid": "b0081280-8009-4a94-af71-6a8def584419",
        "isDone": false,
        "description": "marimba sultan ",
        "active": true
      },
      {
        "uid": "9c49c553-7f73-4e32-bf01-3c7b8b583f5e",
        "isDone": true,
        "description": "inbox mile ",
        "active": true
      },
      {
        "uid": "2b2367ef-1465-4892-a587-69597c79f496",
        "isDone": false,
        "description": "reform alphabet ",
        "active": false
      },
      {
        "uid": "29b2ffa0-9241-427e-b45d-a719c2c2ea4d",
        "isDone": false,
        "description": "gear concern ",
        "active": false
      },
      {
        "uid": "ebe49754-9b8b-4d24-95c1-ab7f3a83ab9d",
        "isDone": false,
        "description": "sprinter onset ",
        "active": true
      },
      {
        "uid": "dae06f99-1a00-4e68-a9b9-5faec41725bb",
        "isDone": false,
        "description": "banjo produce ",
        "active": false
      },
      {
        "uid": "6af818ac-c6d5-4233-abff-4f22f8719f88",
        "isDone": false,
        "description": "doubter entrance ",
        "active": false
      },
      {
        "uid": "94e95599-019a-439d-860d-3825e0b22f5e",
        "isDone": true,
        "description": "battle stall ",
        "active": false
      }
    ],
    "active": true
  },
  {
    "uid": "a96d3417-4257-4001-a74b-5a27c50313b3",
    "title": "Harrison Wilson",
    "description": "trench louse transition reserve woodchuck insight ",
    "createdAt": 1685444705180,
    "modifiedAt": 1685103558032,
    "startTime": 1685215253994,
    "dueTime": 1685225702549,
    "teamMembers": [
      {
        "uid": "bbd2b854-a17c-4b90-a14b-02fa3be29be1",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "5343d079-de97-4e79-86cb-09960b1447e6",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "242465e1-99f9-447d-ac0b-875fce5a9ce7",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "98b590d3-f4d8-4bb7-8129-ba17ebc981b0",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      }
    ],
    "taskStages": [
      {
        "uid": "e820ef25-e0c7-4ec3-b3fb-ee2b044aa4b6",
        "isDone": true,
        "description": "eyelid input ",
        "active": true
      },
      {
        "uid": "675a3fcf-3dd5-4835-8e24-6a85552dc0ba",
        "isDone": false,
        "description": "casino wall ",
        "active": true
      },
      {
        "uid": "ab3c5146-26a3-466e-b937-7c213b9f13ac",
        "isDone": true,
        "description": "infancy downturn ",
        "active": true
      },
      {
        "uid": "87f5603a-ae4c-42df-9447-b1513bc1ca97",
        "isDone": true,
        "description": "orient physiology ",
        "active": true
      },
      {
        "uid": "5a49df42-f016-4845-b033-ad1800e96410",
        "isDone": false,
        "description": "extinction decade ",
        "active": true
      },
      {
        "uid": "1bd3575d-a878-4631-80de-1875cd2aad9f",
        "isDone": true,
        "description": "feeding suspenders ",
        "active": false
      },
      {
        "uid": "321356c3-6cd2-469c-bc67-812094a98e59",
        "isDone": false,
        "description": "palate gherkin ",
        "active": false
      },
      {
        "uid": "484be5a5-14ae-4558-abcf-678d9f118643",
        "isDone": true,
        "description": "decency headphones ",
        "active": false
      },
      {
        "uid": "9be05465-614b-4aef-b4cf-3b01e883bdc0",
        "isDone": true,
        "description": "julienne riverbed ",
        "active": false
      }
    ],
    "active": true
  },
  {
    "uid": "b0258324-c340-4997-89bb-f215ae853d11",
    "title": "Lita Ortiz",
    "description": "task antigen recipient finisher plum socialist ",
    "createdAt": 1684864224925,
    "modifiedAt": 1684966183521,
    "startTime": 1685094456812,
    "dueTime": 1685388843672,
    "teamMembers": [
      {
        "uid": "1746abfd-e1a5-4854-ae4a-696ef5654fa3",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "6c81759b-7116-4080-aeac-a944cd336a86",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "87e4fa98-8169-4890-a9f7-663ec055ef7e",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "a4d8b1c8-11ea-48d6-98e0-1991aee94eff",
        "isDone": false,
        "description": "sunrise male ",
        "active": false
      },
      {
        "uid": "5d54b550-1b1f-448d-9bb7-5a8d8863f981",
        "isDone": true,
        "description": "unibody abbreviation ",
        "active": false
      },
      {
        "uid": "be6145b2-bc36-464c-8f8f-413e347403ec",
        "isDone": true,
        "description": "area die ",
        "active": false
      },
      {
        "uid": "fa599458-8fad-4c8e-a17b-e79b5950396c",
        "isDone": true,
        "description": "food anthropology ",
        "active": true
      },
      {
        "uid": "d0bf03b3-b01a-4e1a-a4d1-4ab262d4d2cd",
        "isDone": true,
        "description": "slave village ",
        "active": false
      },
      {
        "uid": "9027c0e7-36ac-41c8-be79-95ed0b23358c",
        "isDone": true,
        "description": "teaching engineer ",
        "active": false
      },
      {
        "uid": "58219daf-17e2-4759-be42-04c4c38800c7",
        "isDone": true,
        "description": "grip course ",
        "active": true
      },
      {
        "uid": "2ae62d06-4bdc-44a4-9cfb-c3739893f367",
        "isDone": true,
        "description": "pinworm oxygen ",
        "active": true
      },
      {
        "uid": "bca77f4c-d34d-4442-816b-db43bd726fd0",
        "isDone": false,
        "description": "exhaust short ",
        "active": false
      },
      {
        "uid": "2842b940-4c5b-4d87-baec-97c7a2057732",
        "isDone": false,
        "description": "arm tub ",
        "active": true
      }
    ],
    "active": true
  },
  {
    "uid": "ac67e990-ea98-4fb9-8965-46b0810a88ed",
    "title": "Wan Fowler",
    "description": "robot clone leeway goddess carboxyl stag ",
    "createdAt": 1685097133204,
    "modifiedAt": 1685177566906,
    "startTime": 1685044601488,
    "dueTime": 1685137850112,
    "teamMembers": [
      {
        "uid": "92e347de-219f-4ed5-8fa8-a48caf30c678",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "a21a99ac-5ee3-4e9a-aca7-0548724c6550",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "2c718028-7ca5-4de3-be89-a55f14f527fd",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "ac6db2dc-59b8-4e32-a910-0e22f043c9a2",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "da2747d1-5bf5-4192-ad90-010295b6e4de",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "3d196d7f-b70a-40d5-a0eb-3bf6e410bf3b",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "ae560359-a19b-4420-8a64-05766a3b8c2b",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "e8190001-de76-4896-9d50-faa6ccdba7e9",
        "isDone": false,
        "description": "flexibility algorithm ",
        "active": false
      },
      {
        "uid": "eea7c2ab-15f4-4acb-828e-42971c1b5c22",
        "isDone": true,
        "description": "heroine immigration ",
        "active": false
      },
      {
        "uid": "7f5b7223-e2ce-469e-a65b-dff49b6eb56b",
        "isDone": false,
        "description": "goldfish berry ",
        "active": false
      },
      {
        "uid": "844184c1-981c-421c-bab0-37ec496b0a71",
        "isDone": false,
        "description": "chateau pattern ",
        "active": true
      },
      {
        "uid": "84e632c6-e62d-49ac-9b42-4e0956552835",
        "isDone": true,
        "description": "foam tripod ",
        "active": true
      },
      {
        "uid": "0a9fde27-f11c-421d-a815-ce4428d10dc6",
        "isDone": false,
        "description": "cocktail photo ",
        "active": false
      },
      {
        "uid": "acaeb35f-858b-4319-a6bb-16325380f432",
        "isDone": false,
        "description": "driveway id ",
        "active": true
      }
    ],
    "active": true
  },
  {
    "uid": "63745a33-7147-4b18-9b01-a1c00a27d3b3",
    "title": "Jesse Parks",
    "description": "threshold economy clove pasture porter artist ",
    "createdAt": 1684994968415,
    "modifiedAt": 1684743205712,
    "startTime": 1685295104923,
    "dueTime": 1684886943407,
    "teamMembers": [
      {
        "uid": "7755cdf5-9288-4c36-8a01-fb7f1720acf6",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "4396e51f-22cf-46fd-85e3-979832b1246d",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "554d35f7-f6fb-4491-8fd2-3e34772bb99b",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "44cd8b36-fa10-428e-b985-ca2ce938e3a0",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "a57ea6fa-fed2-4720-af39-b90057df7bdf",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "83134738-5e0e-4715-a22e-5473976cc0da",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "a7165f2b-6862-481b-a3a2-778b5e80ee0a",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "027311fd-7cec-42f7-ab6f-5ab3524741c9",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      }
    ],
    "taskStages": [
      {
        "uid": "c301bb48-d785-40ff-ae8d-5b9378414a5c",
        "isDone": false,
        "description": "advancement crocodile ",
        "active": true
      },
      {
        "uid": "202b763c-74d3-412f-836a-b8b35b14d21b",
        "isDone": true,
        "description": "star chef ",
        "active": true
      }
    ],
    "active": true
  },
  {
    "uid": "60652951-57ae-4f36-b687-6746a556172e",
    "title": "Kasandra Bentley",
    "description": "drain table grove seat ephemeris wall ",
    "createdAt": 1685108659119,
    "modifiedAt": 1684690605872,
    "startTime": 1685438410917,
    "dueTime": 1684878670102,
    "teamMembers": [
      {
        "uid": "1f30aa9a-3025-417c-96a4-ab483e42fd17",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "3e1e4566-913c-4b04-925c-13ffec1e627a",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "b2e0b6c5-27d0-4eb0-b63a-82799bc42a8f",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "3a5aec8e-7e84-4e22-8ec3-ebb1604fdfac",
        "isDone": false,
        "description": "doggie professional ",
        "active": true
      },
      {
        "uid": "847f24a3-a593-4a05-9001-9d4b3887bdab",
        "isDone": false,
        "description": "courage perfume ",
        "active": false
      },
      {
        "uid": "ae783871-46ba-4d66-81f4-a8d9457c0ab5",
        "isDone": true,
        "description": "local deed ",
        "active": true
      },
      {
        "uid": "48704feb-8203-4b2e-ac64-f2f21478d7e2",
        "isDone": false,
        "description": "barge enzyme ",
        "active": false
      },
      {
        "uid": "78754511-f87e-4cd1-92df-77bb7bd0233f",
        "isDone": false,
        "description": "glance hull ",
        "active": false
      }
    ],
    "active": false
  },
  {
    "uid": "776f3cb9-63a3-49fa-97d5-c26a12a46415",
    "title": "Blanca Bradley",
    "description": "barley cannibal bread ship lycra yard ",
    "createdAt": 1685422178103,
    "modifiedAt": 1684845872112,
    "startTime": 1685249734816,
    "dueTime": 1684929804968,
    "teamMembers": [
      {
        "uid": "1fe17c41-d4d5-4550-96b4-7b6872a89dd9",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "1ee089de-b6ed-4262-b68f-0cb4bf0621bd",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "2d2343e9-816f-48bb-8313-dda72145067d",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "8b234ace-4b3f-4c25-8e97-02d3c5258538",
        "isDone": true,
        "description": "embryo bumper ",
        "active": true
      },
      {
        "uid": "d8e15e77-49f1-4077-aec2-c7236a017e78",
        "isDone": false,
        "description": "trinket freedom ",
        "active": false
      },
      {
        "uid": "71a9d5a3-1f81-409f-9826-e71faefe8235",
        "isDone": true,
        "description": "helmet pottery ",
        "active": false
      },
      {
        "uid": "eb776fed-a13a-4fca-9cff-957bc04a034f",
        "isDone": false,
        "description": "hurricane abrogation ",
        "active": false
      },
      {
        "uid": "ea276404-6ba3-47e5-a4e4-7aef2f71b4a4",
        "isDone": false,
        "description": "pumpernickel ladder ",
        "active": false
      },
      {
        "uid": "ca0db9b2-49ec-486a-8e31-889d9183fc6f",
        "isDone": false,
        "description": "dromedary drizzle ",
        "active": false
      },
      {
        "uid": "f95b42f6-cce7-4f98-85b0-5438740b6d4e",
        "isDone": false,
        "description": "tremor hassock ",
        "active": false
      },
      {
        "uid": "d92cf9fa-1a38-4704-a529-238a7907402b",
        "isDone": false,
        "description": "upper gym ",
        "active": true
      }
    ],
    "active": false
  },
  {
    "uid": "86ee7534-002f-4762-a1d0-e21c2b646f9c",
    "title": "Audra Adams",
    "description": "heart-throb passing sty shopping cloves starboard ",
    "createdAt": 1684860848334,
    "modifiedAt": 1684828286159,
    "startTime": 1684806610721,
    "dueTime": 1685236879587,
    "teamMembers": [
      {
        "uid": "aa5e370d-7c2e-40c0-874d-3aa828d795a3",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "3275fa64-85e8-4764-bcb8-3474190fcb2b",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "c18cbb4d-5c2e-404c-9e5b-9a5a93bf19bb",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "c6533440-5dff-4ae7-9dbc-557b13e6d05b",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "578c41c2-1eb7-4f21-926b-f6560f20615d",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "fc83f01c-745c-462c-8952-81710ede92f8",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "32069d4b-6a15-492a-8e5d-d818989fb71c",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "4acbcf94-7c6c-483c-a9fd-97471467c304",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "6f000c91-a15f-48aa-b9b2-4c98136aba24",
        "isDone": true,
        "description": "payoff word ",
        "active": true
      },
      {
        "uid": "f8d17001-7e61-4edb-a2f7-73cfd6bebcd3",
        "isDone": true,
        "description": "fortnight goat ",
        "active": false
      },
      {
        "uid": "4f88d3f6-48b5-4863-ac9a-4edd785e726f",
        "isDone": false,
        "description": "washtub reach ",
        "active": true
      },
      {
        "uid": "02f19f54-b9fc-4244-8a8e-1b807067543f",
        "isDone": true,
        "description": "evolution vegetation ",
        "active": false
      },
      {
        "uid": "fa830986-f3e7-4925-a150-c818800b4e40",
        "isDone": false,
        "description": "kamikaze crisp ",
        "active": true
      },
      {
        "uid": "16d92643-cbe1-4b56-80d2-6daf63608dcf",
        "isDone": true,
        "description": "protest quality ",
        "active": false
      },
      {
        "uid": "4ab94aee-1680-4479-b0a9-ed094a44bb5d",
        "isDone": true,
        "description": "sloth extension ",
        "active": false
      },
      {
        "uid": "5331af69-3160-47ad-b9b4-25cc196bfd65",
        "isDone": false,
        "description": "principle wire ",
        "active": true
      }
    ],
    "active": true
  },
  {
    "uid": "440e332b-d707-436e-a353-b46db84592e3",
    "title": "Carroll Sanchez",
    "description": "game stop sponsorship liberty rack markup ",
    "createdAt": 1685185612686,
    "modifiedAt": 1685403531329,
    "startTime": 1684701486133,
    "dueTime": 1685014969769,
    "teamMembers": [
      {
        "uid": "e70af238-270b-45b8-95f7-6ead24efb5e5",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "3521ed7b-a920-4382-8816-1ddce11cb4ae",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "3c530658-aad5-41c8-a861-add0d0935cf8",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "1bd23727-e913-4267-9e61-a58353d9baf2",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "b41b1af6-40b7-4a4e-9a8a-3440e48efe03",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "c9f414f0-acf1-459f-909d-2a2c3d3ae6f4",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "1bf1f55d-ebb4-486a-98d3-a9bb185f4a30",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "f4e9bd5f-7574-4252-8f26-f1635d6541f5",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "4f399f1c-2a2b-4c60-99f7-cade571fa55d",
        "isDone": false,
        "description": "sofa limestone ",
        "active": false
      },
      {
        "uid": "2b930f03-031b-48fe-a662-301d411f8e9c",
        "isDone": false,
        "description": "breakdown crewmember ",
        "active": false
      },
      {
        "uid": "3bb9d94a-471a-4da9-be25-2c9efe0f38c6",
        "isDone": true,
        "description": "gelding peak ",
        "active": true
      }
    ],
    "active": true
  },
  {
    "uid": "6a5e9fbb-cef8-4006-ab0c-e2c3201cf173",
    "title": "Ludivina Clay",
    "description": "sewer eaglet fatigues muscat eyelid stepson ",
    "createdAt": 1685055524172,
    "modifiedAt": 1684886306607,
    "startTime": 1684862030477,
    "dueTime": 1685050520177,
    "teamMembers": [
      {
        "uid": "bed415dc-dddb-4d49-9b21-f45e67d95867",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "36373541-d3ce-4bd3-b4f9-904d4e057551",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "e970e98a-2617-4e80-9814-f6cd0a2f66d2",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "f1c2aae6-48e5-4486-b16e-15419f3ee64a",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "7736a465-f582-4f1f-b662-fa9aa6984e44",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "57c60122-5257-4337-aa50-6664f3aa5b5d",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "e0a7ebff-7ad1-4e25-b8b2-97dd1a01cab6",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "a7a568cf-ff26-4ca5-82b7-62649d129b89",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "b1e0e18c-2049-4f8b-a17d-f383d5644b07",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "5e388624-1e69-4565-b94d-c3ce59d093f4",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "ab5d779a-af4e-4f77-b602-d18d15ddcf15",
        "isDone": true,
        "description": "craw microwave ",
        "active": true
      },
      {
        "uid": "3590876e-8738-4ee0-aa82-ea617a322cea",
        "isDone": true,
        "description": "moon coverage ",
        "active": false
      },
      {
        "uid": "56bee5b8-a838-450a-9995-c7906830e83c",
        "isDone": false,
        "description": "contest boss ",
        "active": false
      },
      {
        "uid": "64aff682-2d7e-4d36-9543-2e49ae68a19b",
        "isDone": true,
        "description": "pack exaggeration ",
        "active": false
      },
      {
        "uid": "6b7f777e-4928-4a7c-8fe3-768c35e61ae4",
        "isDone": false,
        "description": "participation hovel ",
        "active": false
      },
      {
        "uid": "599e8ecf-4d6f-431a-853f-82df103ca1f2",
        "isDone": true,
        "description": "treaty metro ",
        "active": false
      }
    ],
    "active": true
  },
  {
    "uid": "04b9787f-546e-4432-9c41-8236d585a81a",
    "title": "Yvone Sweeney",
    "description": "use noise lettuce accountant indigence pound ",
    "createdAt": 1685130941872,
    "modifiedAt": 1684849813252,
    "startTime": 1684709575114,
    "dueTime": 1685153760681,
    "teamMembers": [
      {
        "uid": "5a8ee4df-9dac-43b9-a575-8170d55f3fd4",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "c5152912-eabf-4b64-a59b-8af726b02e64",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "6ab33436-a50d-4872-ab39-c1ef0b936274",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "af0dbd42-0d54-4554-ab48-fbfa7be208ab",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "ca751ccd-898a-44ce-95d5-debf4feef6b8",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "802eaef9-4933-43f8-bd07-f4eb906a8e30",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "3c048ad5-60e3-410d-b9a8-a2ca6e3f9b23",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "fdd2c428-d9d2-4f3e-bf76-dafa6d3d17ff",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "83663673-0a90-4a00-9dd2-04643c251cea",
        "isDone": true,
        "description": "timeline session ",
        "active": true
      },
      {
        "uid": "ad33ff4f-aa3c-4440-8a2e-7d48a9471e11",
        "isDone": false,
        "description": "carotene kit ",
        "active": true
      },
      {
        "uid": "fe635dc5-1f51-4944-bd64-233efd98761a",
        "isDone": true,
        "description": "transfer precedent ",
        "active": false
      },
      {
        "uid": "fe80d5b7-90a6-4dcb-9941-f381e1ae9206",
        "isDone": true,
        "description": "time benefit ",
        "active": false
      },
      {
        "uid": "2a90858a-2f21-42de-a89d-ff619c8cbdd3",
        "isDone": true,
        "description": "ziggurat gallon ",
        "active": true
      },
      {
        "uid": "21eabd26-b15d-453f-93b9-666c5f623267",
        "isDone": false,
        "description": "smog bar ",
        "active": false
      },
      {
        "uid": "80197935-bc20-4a0e-a767-940743e2ec8b",
        "isDone": false,
        "description": "calculation chocolate ",
        "active": false
      },
      {
        "uid": "9f027b33-a6d2-4d30-8d6c-49ac23b0045d",
        "isDone": false,
        "description": "feng valance ",
        "active": false
      }
    ],
    "active": true
  },
  {
    "uid": "563463bd-042f-40a6-bfae-b76056b3bafa",
    "title": "Elvie Carlson",
    "description": "urn assistance icy rainstorm examiner spike ",
    "createdAt": 1685220632794,
    "modifiedAt": 1684850715477,
    "startTime": 1684742028598,
    "dueTime": 1684893842186,
    "teamMembers": [
      {
        "uid": "9b0fff76-9de8-4309-aa97-2369ec9abaf1",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "b929acba-79db-4e92-9cb0-67c3a5964ecf",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "00edd59b-c511-4b5c-9833-02867aab1a97",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "9e99d949-5a21-40c6-80a5-0fd2c5dffcc2",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      },
      {
        "uid": "36b6c212-071a-4866-a685-8c9c05e87679",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      },
      {
        "uid": "34d9867d-313e-4c8d-9187-c90b348e85ae",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": false
      }
    ],
    "taskStages": [
      {
        "uid": "8fa6ff9c-13d2-490e-bfc3-3575e5d589fd",
        "isDone": false,
        "description": "ruler sequence ",
        "active": true
      },
      {
        "uid": "957ed549-0961-4e9d-8468-ee2bd535b842",
        "isDone": true,
        "description": "jazz bottle ",
        "active": true
      },
      {
        "uid": "e81e9ce5-e1d8-4926-b820-46a5acb75871",
        "isDone": false,
        "description": "bit codon ",
        "active": false
      },
      {
        "uid": "af4607cc-57a6-4789-acc7-506fe7096005",
        "isDone": false,
        "description": "flair import ",
        "active": false
      },
      {
        "uid": "daab2abe-528c-4646-8408-3e6ee20e4195",
        "isDone": false,
        "description": "jaguar clergyman ",
        "active": false
      },
      {
        "uid": "14e729bc-a555-4d62-9947-2d1a9bb45057",
        "isDone": false,
        "description": "spelt digging ",
        "active": true
      }
    ],
    "active": false
  },
  {
    "uid": "467087cb-cfb6-4b00-9928-9482ce1eaca5",
    "title": "Glenda Sanford",
    "description": "photodiode gravitas effective skiing consumption litter ",
    "createdAt": 1684711758699,
    "modifiedAt": 1684824662205,
    "startTime": 1684963966108,
    "dueTime": 1685454149603,
    "teamMembers": [
      {
        "uid": "4384b087-ea9d-4307-b0f5-31fd0bf3eafe",
        "avatarUrl":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
        "active": true
      }
    ],
    "taskStages": [
      {
        "uid": "23c8c87b-01f0-42e6-a2cc-0f9a61c92225",
        "isDone": false,
        "description": "astrolabe oldie ",
        "active": true
      },
      {
        "uid": "74e18a0a-0d39-4631-92ef-e074e46fce17",
        "isDone": false,
        "description": "drainage enemy ",
        "active": true
      },
      {
        "uid": "f1db42f7-c3bf-4e8c-8c51-6df33e160880",
        "isDone": true,
        "description": "controller icebreaker ",
        "active": false
      },
      {
        "uid": "97f48e69-70cb-4306-b770-f519ffc3abb2",
        "isDone": true,
        "description": "baboon envy ",
        "active": true
      }
    ],
    "active": false
  }
];
