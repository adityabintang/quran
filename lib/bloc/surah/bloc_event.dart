part of 'bloc.dart';

abstract class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object?> get props => [];
}

class SurahFetch extends SurahEvent {}
