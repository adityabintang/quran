import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/bloc/surah/repository.dart';
import 'package:quran_app/models/error_model.dart';

import '../../models/detail_surah_model.dart';

part 'bloc_state.dart';

part 'bloc_event.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final SurahRepository _repository;
  List<Surah>? dataList = [];

  SurahBloc(this._repository) : super(SurahLoading()) {
    on<SurahFetch>((event, emit) async {
      emit(SurahLoading());
      final response = await _repository.getSurah();

      response
          .fold((messageError) => emit(SurahFailure(dataError: messageError)),
              (result) {
        dataList = result.data;
        emit(SurahLoaded(dataList: result.data));
      });
    });
  }
}
