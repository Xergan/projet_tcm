import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projet_tcm/bloc/login/login_bloc.dart';
import 'package:projet_tcm/bloc/sensor/sensor_bloc.dart';
import 'package:projet_tcm/pages/login_page.dart';
import 'package:projet_tcm/pages/select_page.dart';
import 'package:projet_tcm/services/auth_service.dart';
import 'package:projet_tcm/services/sensor_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
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
        BlocProvider(create: (context) => SensorBloc(sensorService)), // Fournit SensorBloc globalement
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/select': (context) => const SelectPage(),
        },
      ),
    );
  }
}