import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map && args['tabIndex'] is int) {
        setState(() => _activeTabIndex = args['tabIndex'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgWhite,
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
