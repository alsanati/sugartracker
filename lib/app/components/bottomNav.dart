import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/ui/auth/account_page.dart';
import 'package:sugar_tracker/app/ui/chart_views/chart.dart';
import 'package:sugar_tracker/app/ui/dashboard/homepage.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_box_rounded),
            icon: Icon(Icons.account_box_rounded),
            label: 'Account',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: const Homepage(),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Chart(),
        ),
        Container(
          alignment: Alignment.center,
          child: const AccountPage(),
        ),
      ][currentPageIndex],
    );
  }
}
