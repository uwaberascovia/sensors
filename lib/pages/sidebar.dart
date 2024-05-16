import 'package:flutter/material.dart';
import 'package:sensors/pages/compass.dart';
import 'package:sensors/pages/step_counter.dart';
import 'package:sensors/pages/light2.dart';

class AppDisplayUser extends StatefulWidget {

  @override
  State<AppDisplayUser> createState() => _AppDisplayUserState();
}

int currentPage = 0;
int selectedDrawerIndex = 0;

class _AppDisplayUserState extends State<AppDisplayUser> {
  List<Widget> pages = [
    CompassPage(),
    StepCounter(),
    LightSensorPage(),
    
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Flutter',
          ),
        ),
      body: pages[currentPage],
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     debugPrint('Floating action pressed');
        //   },
        //   child: const Icon(Icons.add),
        // ),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.compass_calibration_rounded,
              ),
              label: 'Compass',
            ),
            NavigationDestination(
                icon: Icon(
                  Icons.nordic_walking,
                ),
                label: 'Steps'),
            NavigationDestination(
                icon: Icon(
                  Icons.light_rounded,
                ),
                label: 'Light'),
          
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
      ),
    );
  }
   ListTile buildDrawerItem(int index, String title, IconData icon) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () {
        // Navigate to the corresponding page and update the selected index
        Navigator.pop(context); // Close the drawer
        setState(() {
          currentPage = index;
          selectedDrawerIndex = index;
        });
      },
      selected: selectedDrawerIndex == index, // Highlight the selected item
    );
  }
}

