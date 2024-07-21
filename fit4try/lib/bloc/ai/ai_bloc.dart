import 'package:bloc/bloc.dart';
import 'package:fit4try/services/dressing.dart';
import 'ai_event.dart';
import 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  final Dressing _dressing = Dressing();

  AiBloc() : super(AiInitial()) {
    on<ProcessUpperBody>(_onProcessUpperBody);
    on<ProcessLowerBody>(_onProcessLowerBody);
    on<ProcessDress>(_onProcessDress);
  }

  Future<void> _onProcessUpperBody(
      ProcessUpperBody event, Emitter<AiState> emit) async {
    emit(AiLoading());
    try {
      final imageData = await _dressing.clothe_upper_body(
          event.modelPath, event.clothePath, event.context);
      if (imageData != null) {
        emit(AiLoaded(imageData));
      } else {
        emit(AiError("Failed to process upper body image."));
      }
    } catch (e) {
      emit(AiError("Error: $e"));
    }
  }

  Future<void> _onProcessLowerBody(
      ProcessLowerBody event, Emitter<AiState> emit) async {
    emit(AiLoading());
    try {
      final imageData = await _dressing.clothe_lower_body(
          event.modelPath, event.clothePath, event.context);
      if (imageData != null) {
        emit(AiLoaded(imageData));
      } else {
        emit(AiError("Failed to process lower body image."));
      }
    } catch (e) {
      emit(AiError("Error: $e"));
    }
  }

  Future<void> _onProcessDress(
      ProcessDress event, Emitter<AiState> emit) async {
    emit(AiLoading());
    try {
      final imageData = await _dressing.clothe_dress(
          event.modelPath, event.clothePath, event.context);
      if (imageData != null) {
        emit(AiLoaded(imageData));
      } else {
        emit(AiError("Failed to process dress image."));
      }
    } catch (e) {
      emit(AiError("Error: $e"));
    }
  }
}
