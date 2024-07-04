part of 'bloc.dart';

abstract class BookmarksState extends Equatable{
  const BookmarksState();

  @override
  List<Object?> get props => [];
}

class BookmarksLoading extends BookmarksState{}
class BookmarksLoaded extends BookmarksState{
  final List<AyahModel>? ayat;

  const BookmarksLoaded({
    required this.ayat,
  });

  BookmarksLoaded copyWith({
    List<AyahModel>? ayat,
  }) {
    return BookmarksLoaded(
      ayat: ayat ?? this.ayat,
    );
  }

  @override
  List<Object?> get props => [ayat];

  @override
  String toString() => 'BookmarksLoaded { data: $ayat}';
}

class BookmarksFailure extends BookmarksState {
  final ErrorModel? dataError;

  const BookmarksFailure({this.dataError});

  @override
  List<Object?> get props => [dataError];

  @override
  String toString() => 'Failure { items: ${dataError?.message} }';
}