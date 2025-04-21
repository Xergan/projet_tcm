part of 'sensor_alerts_cubit.dart';

@immutable
sealed class SensorAlertsState {}

/// État initial
final class SensorAlertsInitial extends SensorAlertsState {}

/// État de chargement
final class SensorAlertsLoading extends SensorAlertsState {}

/// État de succès avec la liste des données
final class SensorAlertsLoaded extends SensorAlertsState {
  final List alerts;

  SensorAlertsLoaded(this.alerts);
}

/// État si la liste est vide
final class SensorAlertsEmpty extends SensorAlertsState {}

/// État d'échec avec un message d'erreur
final class SensorAlertsError extends SensorAlertsState {
  final String errorMessage;

  SensorAlertsError(this.errorMessage);
}