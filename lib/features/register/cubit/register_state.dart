// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final bool hidePassword;
  const RegisterState({
    required this.hidePassword,
  });

  @override
  List<Object> get props => [hidePassword];

  RegisterState copyWith({
    bool? hidePassword,
  }) {
    return RegisterState(
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }
}
