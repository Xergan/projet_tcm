import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tcm/blocs/sensor/selected_sensor_cubit.dart';
import 'package:projet_tcm/pages/subpages/home_page.dart';
import 'package:projet_tcm/pages/subpages/data_page.dart';
import 'package:projet_tcm/pages/subpages/alert_page.dart';
import 'package:projet_tcm/widgets/my_navbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedSensor = context.watch<SelectedSensorCubit>().state;

    if (selectedSensor == null) {
      Navigator.pushNamed(context, '/select');
      return const Center(
        child: CircularProgressIndicator(), // Affiche un indicateur de chargement temporaire
      );
    }


    final List<Widget> pages = [
      HomePage(selectedSensor: selectedSensor),
      DataPage(selectedSensor: selectedSensor),
      AlertPage(selectedSensor: selectedSensor),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedSensor["Id_capteur"],
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: MyNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
