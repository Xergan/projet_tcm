part of 'sensor_data_cubit.dart';

@immutable
sealed class SensorDataState {}

/// État initial
final class SensorDataInitial extends SensorDataState {}

/// État de chargement
final class SensorDataLoading extends SensorDataState {}

/// État de succès avec la liste des données
final class SensorDataLoaded extends SensorDataState {
  final List datas;

  SensorDataLoaded(this.datas);
}

/// État d'échec avec un message d'erreur
final class SensorDataError extends SensorDataState {
  final String errorMessage;

  SensorDataError(this.errorMessage);
}