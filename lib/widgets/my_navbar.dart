import 'package:flutter/material.dart';

class MyNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped; // Callback pour gérer l'index sélectionné

  const MyNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      onTap: onItemTapped, // Appelle la fonction de mise à jour
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Accueil"),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart_rounded), label: "Données"),
        BottomNavigationBarItem(icon: Icon(Icons.notification_important_rounded), label: "Alertes"),
      ],
    );
  }
}