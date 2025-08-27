part of 'home_cubit.dart';

class HomeState extends Equatable {
  final String? selectedName;
  final int currentIndex;

  const HomeState({this.selectedName, this.currentIndex = 0});

  HomeState copyWith({String? selectedName, int? currentIndex}) {
    return HomeState(
      selectedName: selectedName ?? this.selectedName,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [selectedName, currentIndex];
}
