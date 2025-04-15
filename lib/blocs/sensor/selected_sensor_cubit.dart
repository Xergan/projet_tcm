import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedSensorCubit extends Cubit<Map<String, dynamic>?> {
  SelectedSensorCubit() : super(null);

  /// Sélectionne un capteur
  void selectSensor(Map<String, dynamic> sensor) {
    emit(sensor);
  }

  /// Réinitialise la sélection
  void clearSelection() {
    emit(null);
  }
}