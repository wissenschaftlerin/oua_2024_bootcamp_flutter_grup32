import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Localization Events
abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ToTurkish extends LocalizationEvent {}

class ToEnglish extends LocalizationEvent {}

// Localization States
class LocalizationState extends Equatable {
  final Locale locale;

  const LocalizationState(this.locale);

  @override
  List<Object> get props => [locale];
}

// LocalizationBloc
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState(Locale('en')));

  @override
  Stream<LocalizationState> mapEventToState(LocalizationEvent event) async* {
    if (event is ToTurkish) {
      yield LocalizationState(Locale('tr'));
    } else if (event is ToEnglish) {
      yield LocalizationState(Locale('en'));
    }
  }
}
