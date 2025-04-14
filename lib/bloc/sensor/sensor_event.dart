part of 'sensor_bloc.dart';

@immutable
sealed class SensorEvent {}

final class FetchSensors extends SensorEvent {}