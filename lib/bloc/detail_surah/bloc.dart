import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/bloc/detail_surah/repository.dart';
import 'package:quran_app/models/detail_surah_model.dart';

import '../../models/error_model.dart';

part 'bloc_state.dart';

part 'bloc_event.dart';

class DetailSurahBloc extends Bloc<DetailSurahEvent, DetailSurahState> {
  final DetailSurahRepository _repository;
  DetailSurahModel? surah;

  DetailSurahBloc(this._repository) : super(DetailSurahLoading()) {
    on<DetailSurahFetch>((event, emit) async {
      emit(DetailSurahLoading());
      final response = await _repository.getDetailSurah(event.numberSurah);

      response.fold(
          (messageError) => emit(DetailSurahFailure(dataError: messageError)),
          (result) {
        surah = result;
        emit(DetailSurahLoaded(surah: surah));
      });
    });
  }
}
