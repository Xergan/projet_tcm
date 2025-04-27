import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projet_tcm/blocs/login/login_bloc.dart';
import 'package:projet_tcm/blocs/sensor/selected_sensor_cubit.dart';
import 'package:projet_tcm/blocs/sensor/sensor_alerts_cubit.dart';
import 'package:projet_tcm/blocs/sensor/sensor_cubit.dart';
import 'package:projet_tcm/blocs/sensor/sensor_filling_cubit.dart';
import 'package:projet_tcm/pages/main_page.dart';
import 'package:projet_tcm/pages/login_page.dart';
import 'package:projet_tcm/pages/select_page.dart';
import 'package:projet_tcm/services/auth_service.dart';
import 'package:projet_tcm/services/mqtt_service.dart';
import 'package:projet_tcm/services/notif_service.dart';
import 'package:projet_tcm/services/sensor_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  NotifService().initNotification();
  final mqttService = MqttService();

  // Initialisation et connexion MQTT
  await mqttService.initialize();
  bool connected = await mqttService.connect(
    username: dotenv.env['MQTT_USERNAME']!,
    password: dotenv.env['MQTT_PASSWORD']!,
  );
  if (connected) {
    mqttService.subscribe('alert/topic');
    mqttService.listenToUpdates();
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final sensorService = SensorService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(authService)),
        BlocProvider(create: (context) => SensorCubit(sensorService)),
        BlocProvider(create: (context) => SelectedSensorCubit()),
        BlocProvider(create: (context) => SensorFillingCubit(sensorService)),
        BlocProvider(create: (context) => SensorAlertsCubit(sensorService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/select': (context) => const SelectPage(),
          '/main': (context) => const MainPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.cyan,
            cardColor: Colors.grey.shade900,
            accentColor: Colors.cyanAccent,
            errorColor: Colors.red,
            brightness: Brightness.dark,
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.grey.shade200),
            bodyMedium: TextStyle(color: Colors.grey.shade200),
            bodySmall: TextStyle(color: Colors.grey.shade200),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade200,
            ),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
