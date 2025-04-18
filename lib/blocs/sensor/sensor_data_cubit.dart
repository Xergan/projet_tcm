import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:projet_tcm/services/sensor_service.dart';

part 'sensor_data_state.dart';

class SensorDataCubit extends Cubit<SensorDataState> {
   final SensorService sensorService;

  SensorDataCubit(this.sensorService) : super(SensorDataInitial());

    Future<void> fetchDatas(String idCapteur, DateTime dateTime) async {
    emit(SensorDataLoading()); // État de chargement
    try {
      final datas = await sensorService.getDatas(idCapteur, dateTime);
      emit(SensorDataLoaded(datas));
    } catch (e) {
      emit(SensorDataError('Erreur lors de la récupération des capteurs : $e'));
    }
  }
}
