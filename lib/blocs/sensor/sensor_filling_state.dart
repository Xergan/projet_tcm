part of 'sensor_filling_cubit.dart';

@immutable
sealed class SensorFillingState {}

/// État initial
final class SensorFillingInitial extends SensorFillingState {}

/// État de chargement
final class SensorFillingLoading extends SensorFillingState {}

/// État de succès avec la liste des données
final class SensorFillingLoaded extends SensorFillingState {
  final List fillings;

  SensorFillingLoaded(this.fillings);
}

/// État si la liste est vide
final class SensorFillingEmpty extends SensorFillingState {}

/// État d'échec avec un message d'erreur
final class SensorFillingError extends SensorFillingState {
  final String errorMessage;

  SensorFillingError(this.errorMessage);
}