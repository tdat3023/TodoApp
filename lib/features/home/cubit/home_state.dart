// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState {
  final int currentPage;

  const HomeState({
    required this.currentPage,
  });

  HomeState copyWith({
    int? currentPage,
    List<Task>? tasks,
  }) {
    return HomeState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
