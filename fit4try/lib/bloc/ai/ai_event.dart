import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AiEvent extends Equatable {
  const AiEvent();

  @override
  List<Object> get props => [];
}

class ProcessUpperBody extends AiEvent {
  final String modelPath;
  final String clothePath;
  final BuildContext context;

  ProcessUpperBody(this.modelPath, this.clothePath, this.context);

  @override
  List<Object> get props => [modelPath, clothePath, context];
}

class ProcessLowerBody extends AiEvent {
  final String modelPath;
  final String clothePath;
  final BuildContext context;

  ProcessLowerBody(this.modelPath, this.clothePath, this.context);

  @override
  List<Object> get props => [modelPath, clothePath, context];
}

class ProcessDress extends AiEvent {
  final String modelPath;
  final String clothePath;
  final BuildContext context;

  ProcessDress(this.modelPath, this.clothePath, this.context);

  @override
  List<Object> get props => [modelPath, clothePath, context];
}
