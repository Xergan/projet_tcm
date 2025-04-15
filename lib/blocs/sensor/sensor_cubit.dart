import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:projet_tcm/services/sensor_service.dart';

part 'sensor_state.dart';

class SensorCubit extends Cubit<SensorState> {
  final SensorService sensorService;

  SensorCubit(this.sensorService) : super(SensorInitial());

  Future<void> fetchSensors() async {
    emit(SensorLoading()); // État de chargement
    try {
      final sensors = await sensorService.getSensors();
      emit(SensorLoaded(sensors));
    } catch (e) {
      emit(SensorError('Erreur lors de la récupération des capteurs : $e'));
    }
  }
}