// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hcm23_03/features/home/pages/home_page.dart';
import 'package:hcm23_03/features/login/pages/login_page.dart';

import '../../cubit/auth_cubit.dart';

class BaseScreen extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  const BaseScreen({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
        }
        if (state is Authenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
        }
      },
      child: BaseScreenBuilder(
        builder: widget.builder,
      ),
    );
  }
}

class BaseScreenBuilder extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  const BaseScreenBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<BaseScreenBuilder> createState() => _BaseScreenBuilderState();
}

class _BaseScreenBuilderState extends State<BaseScreenBuilder> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Focus(
        focusNode: focusNode,
        child: widget.builder(context),
      ),
    );
  }
}
