part of 'sensor_cubit.dart';

@immutable
sealed class SensorState {}

/// État initial
final class SensorInitial extends SensorState {}

/// État de chargement
final class SensorLoading extends SensorState {}

/// État de succès avec la liste des capteurs
final class SensorLoaded extends SensorState {
  final List sensors;

  SensorLoaded(this.sensors);
}

/// État si la liste est vide
final class SensorEmpty extends SensorState {}

/// État d'échec avec un message d'erreur
final class SensorError extends SensorState {
  final String errorMessage;

  SensorError(this.errorMessage);
}