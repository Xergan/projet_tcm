import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:projet_tcm/services/sensor_service.dart';

part 'sensor_filling_state.dart';

class SensorFillingCubit extends Cubit<SensorFillingState> {
  final SensorService sensorService;

  SensorFillingCubit(this.sensorService) : super(SensorFillingInitial());

    Future<void> fetchFillingData(String idCapteur, DateTime dateTime) async {
    emit(SensorFillingLoading()); // État de chargement
    try {
      final fillings = await sensorService.getFillingData(idCapteur, dateTime);
      emit(SensorFillingLoaded(fillings));
    } catch (e) {
      emit(SensorFillingError('Erreur lors de la récupération des capteurs : $e'));
    }
  }
}
