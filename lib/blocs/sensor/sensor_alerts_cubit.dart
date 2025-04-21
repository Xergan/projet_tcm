import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:projet_tcm/services/sensor_service.dart';

part 'sensor_alerts_state.dart';

class SensorAlertsCubit extends Cubit<SensorAlertsState> {
  final SensorService sensorService;

  SensorAlertsCubit(this.sensorService) : super(SensorAlertsInitial());

    Future<void> fetchAlerts(String idCapteur) async {
    emit(SensorAlertsLoading()); // État de chargement
    try {
      final alerts = await sensorService.getAlerts(idCapteur);
      emit(SensorAlertsLoaded(alerts));
    } catch (e) {
      emit(SensorAlertsError('Erreur lors de la récupération des capteurs : $e'));
    }
  }
}
