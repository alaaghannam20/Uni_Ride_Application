import 'package:flutter/material.dart';
import 'tabs/find_trips_tab.dart';
import 'tabs/my_trips_tab.dart';
import 'tabs/carpool_tab.dart';
import 'tabs/rewards_tab.dart';
import '../widgets/home_header.dart';
import '../widgets/home_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeTabIndex = 0;

  final List<Widget> _tabs = const [
    FindTripsTab(),
    MyTripsTab(),
    CarpoolTab(),
    RewardsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),
            HomeNavigation(
              activeIndex: _activeTabIndex,
              onTabChanged: (index) => setState(() => _activeTabIndex = index),
            ),
            Expanded(
              child: IndexedStack(
                index: _activeTabIndex,
                children: _tabs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}