part of 'bloc.dart';

abstract class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object?> get props => [];
}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final List<Surah>? dataList;

  const SurahLoaded({
    required this.dataList,
  });

  SurahLoaded copyWith({
    List<Surah>? dataList,
  }) {
    return SurahLoaded(
      dataList: dataList ?? this.dataList,
    );
  }

  @override
  List<Object?> get props => [dataList];

  @override
  String toString() =>
      'SurahLoaded { data: ${dataList?.length}}';
}

class SurahFailure extends SurahState {
  final ErrorModel? dataError;

  const SurahFailure({this.dataError});

  @override
  List<Object?> get props => [dataError];

  @override
  String toString() => 'Failure { items: ${dataError?.message} }';
}