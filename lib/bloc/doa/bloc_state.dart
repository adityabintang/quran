part of 'bloc.dart';

abstract class DoaState extends Equatable{
  const DoaState();

  @override
  List<Object?> get props => [];
}

class DoaLoading extends DoaState{}

class DoaLoaded extends DoaState{
  final List<DoaModel>? doa;

  const DoaLoaded({
    required this.doa,
  });

  DoaLoaded copyWith({
    List<DoaModel>? doa,
  }) {
    return DoaLoaded(
      doa: doa ?? this.doa,
    );
  }

  @override
  List<Object?> get props => [doa];

  @override
  String toString() =>
      'DoaLoaded { data: ${doa?.length}}';
}

class DoaFailure extends DoaState {
  final ErrorModel? dataError;

  const DoaFailure({this.dataError});

  @override
  List<Object?> get props => [dataError];

  @override
  String toString() => 'Failure { items: ${dataError?.message} }';
}