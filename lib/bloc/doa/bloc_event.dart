part of 'bloc.dart';

abstract class DoaEvent extends Equatable{
  const DoaEvent();

  @override
  List<Object?> get props => [];
}

class DoaFetch extends DoaEvent {}