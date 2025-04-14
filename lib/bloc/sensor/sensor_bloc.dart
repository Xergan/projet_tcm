import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:projet_tcm/services/sensor_service.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final SensorService sensorService;

  SensorBloc(this.sensorService) : super(SensorInitial()) {
    on<FetchSensors>((event, emit) async {
      emit(SensorLoading()); // État de chargement

      try {
        final sensors = await sensorService.getSensors();
        emit(SensorLoaded(sensors)); // État de succès avec les capteurs
      } catch (e) {
        emit(SensorError('Erreur lors de la récupération des capteurs : $e')); // État d'échec
      }
    });
  }
}