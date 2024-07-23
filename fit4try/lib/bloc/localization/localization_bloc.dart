import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum LocalizationEvent { toTurkish, toEnglish }

class LocalizationBloc extends Bloc<LocalizationEvent, Locale> {
  LocalizationBloc() : super(const Locale('en')) {
    on<LocalizationEvent>((event, emit) {
      switch (event) {
        case LocalizationEvent.toTurkish:
          emit(const Locale('tr'));
          break;
        case LocalizationEvent.toEnglish:
          emit(const Locale('en'));
          break;
      }
    });
  }
}
