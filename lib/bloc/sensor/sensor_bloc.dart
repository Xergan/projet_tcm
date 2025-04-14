import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  SensorBloc() : super(SensorInitial()) {
    on<SensorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
