part of 'bloc.dart';

abstract class BookmarksEvent extends Equatable{
  const BookmarksEvent();

  @override
  List<Object?> get props => [];
}

class BookmarksFetch extends BookmarksEvent {}