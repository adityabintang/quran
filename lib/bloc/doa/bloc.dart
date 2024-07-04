import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/bloc/doa/repository.dart';
import 'package:quran_app/models/doa_model.dart';
import 'package:quran_app/models/error_model.dart';

part 'bloc_state.dart';
part 'bloc_event.dart';

class DoaBloc extends Bloc<DoaEvent, DoaState>{
  final DoaRepository _repository;
  List<DoaModel>? dataList = [];
  DoaBloc(this._repository): super(DoaLoading()){
    on<DoaFetch>((event, emit) async {
      emit(DoaLoading());
      final response = await _repository.fetchDoa();

      response
          .fold((messageError) => emit(DoaFailure(dataError: messageError)),
              (result) {
            dataList = result;
            emit(DoaLoaded(doa: result));
          });
    });
  }

}