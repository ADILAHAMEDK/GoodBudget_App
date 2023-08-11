import 'package:flutter/material.dart';
import 'package:money_manager/widgets/home_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _){
        return BottomNavigationBar(
          selectedItemColor: Colors.blue,
        currentIndex: updatedIndex,
        onTap: (newIndex) {
          HomeScreen.selectedIndexNotifier.value = newIndex;
          
        },
        items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Transactions'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          ),
      ]);
      },
    );
  }
}