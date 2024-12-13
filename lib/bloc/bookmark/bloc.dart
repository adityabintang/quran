import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/helper/db_helper.dart';
import 'package:quran_app/models/ayah_model.dart';
import 'package:quran_app/models/error_model.dart';

part 'bloc_event.dart';

part 'bloc_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  final DatabaseHelper _databaseHelper;
  List<AyahModel>? dataList = [];

  BookmarksBloc(this._databaseHelper) : super(BookmarksLoading()) {
    on<BookmarksFetch>((event, emit) async {
      emit(BookmarksLoading());
      final response = await _databaseHelper.getPerAyah();

      response.fold(
          (messageError) => emit(BookmarksFailure(dataError: messageError)),
          (result) {
        dataList = result;
        emit(BookmarksLoaded(ayat: dataList));
      });
    });
  }
}
