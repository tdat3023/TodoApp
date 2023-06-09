// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool rememberAccount;
  final bool hidePassword;
  const LoginState({
    required this.rememberAccount,
    required this.hidePassword,
  });

  @override
  List<Object> get props => [
        rememberAccount,
        hidePassword,
      ];

  LoginState copyWith({
    bool? rememberAccount,
    bool? hidePassword,
  }) {
    return LoginState(
      rememberAccount: rememberAccount ?? this.rememberAccount,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }
}
