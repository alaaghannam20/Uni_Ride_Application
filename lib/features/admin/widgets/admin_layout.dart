import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'admin_sidebar.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  final String activeRoute;

  const AdminLayout({
    super.key,
    required this.child,
    required this.activeRoute,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      drawer: Responsive.isDesktop(context)
          ? null
          : AdminSidebar(activeRoute: activeRoute),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (Responsive.isDesktop(context))
            AdminSidebar(activeRoute: activeRoute),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
