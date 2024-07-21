import 'package:equatable/equatable.dart';
import 'dart:typed_data';

abstract class AiState extends Equatable {
  const AiState();

  @override
  List<Object> get props => [];
}

class AiInitial extends AiState {}

class AiLoading extends AiState {}

class AiLoaded extends AiState {
  final Uint8List imageData;

  AiLoaded(this.imageData);

  @override
  List<Object> get props => [imageData];
}

class AiError extends AiState {
  final String message;

  AiError(this.message);

  @override
  List<Object> get props => [message];
}
