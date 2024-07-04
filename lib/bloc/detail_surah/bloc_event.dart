part of 'bloc.dart';

abstract class DetailSurahEvent extends Equatable {
  const DetailSurahEvent();

  @override
  List<Object?> get props => [];
}

class DetailSurahFetch extends DetailSurahEvent {
  final int? numberSurah;

  const DetailSurahFetch({required this.numberSurah});

  @override
  List<Object?> get props => [numberSurah];

  @override
  String toString() => 'DetailSurahFetch { statusMode: $numberSurah }';
}
