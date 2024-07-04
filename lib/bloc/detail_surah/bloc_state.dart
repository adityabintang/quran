part of 'bloc.dart';

abstract class DetailSurahState extends Equatable {
  const DetailSurahState();

  @override
  List<Object?> get props => [];
}

class DetailSurahLoading extends DetailSurahState {}

class DetailSurahLoaded extends DetailSurahState {
  final DetailSurahModel? surah;

  const DetailSurahLoaded({
    required this.surah,
  });

  DetailSurahLoaded copyWith({
    DetailSurahModel? surah,
  }) {
    return DetailSurahLoaded(
      surah: surah ?? this.surah,
    );
  }

  @override
  List<Object?> get props => [surah];

  @override
  String toString() => 'DetailSurahLoaded { data: $surah}';
}

class DetailSurahFailure extends DetailSurahState {
  final ErrorModel? dataError;

  const DetailSurahFailure({this.dataError});

  @override
  List<Object?> get props => [dataError];

  @override
  String toString() => 'Failure { items: ${dataError?.message} }';
}
