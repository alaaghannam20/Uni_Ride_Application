import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';

class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      activeRoute: '/AdminOverview',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AdminHeader(
            title: 'Dashboard Overview',
            showSearchAndFilter: false,
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.people_outline,
                          iconColor: Colors.blue,
                          iconBgColor: Colors.blue.withOpacity(0.1),
                          value: '1245',
                          label: 'Total Users',
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.directions_car_outlined,
                          iconColor: Colors.green,
                          iconBgColor: Colors.green.withOpacity(0.1),
                          value: '89',
                          label: 'Active Drivers',
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.trending_up,
                          iconColor:  AppColors.orangeprimary,
                          iconBgColor:  AppColors.orangeprimary.withOpacity(0.1),
                          value: '3567',
                          label: 'Total Trips',
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.error_outline,
                          iconColor: AppColors.redColor,
                          iconBgColor: AppColors.redColor.withOpacity(0.1),
                          value: '12',
                          label: 'Pending Approvals',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32), 

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [AppColors.orangeprimary, AppColors.adminGradientEnd],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.attach_money, color: Colors.white, size: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    "Today's Revenue",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                '₪4520',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Icons.arrow_upward, color: Colors.white, size: 14),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '12% from yesterday',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color:  AppColors.borderadmincolor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.access_time, color: Colors.purple, size: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    "Active Trips Now",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xFF101828),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                '23',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36,
                                  color: Color(0xFF101828),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Real-time monitoring',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF6A7282),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color:  AppColors.borderadmincolor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text(
                            'Recent Trips',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFF101828),
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.borderadmincolor),
                        _buildTripItem(
                          passenger: 'Laila H.',
                          driver: 'Sara K.',
                          from: 'PTUK University',
                          to: 'City Center',
                          price: '₪8',
                          status: 'completed',
                          time: '10 min ago',
                        ),
                        const Divider(height: 1, indent: 24, endIndent: 24, color: AppColors.borderadmincolor),
                        _buildTripItem(
                          passenger: 'Omar S.',
                          driver: 'Ahmed M.',
                          from: 'Main Square',
                          to: 'PTUK University',
                          price: '₪10',
                          status: 'ongoing',
                          time: 'Now',
                        ),
                        const Divider(height: 1, indent: 24, endIndent: 24, color: AppColors.borderadmincolor),
                        _buildTripItem(
                          passenger: 'Fatima Q.',
                          driver: 'Mohammed A.',
                          from: 'City Center',
                          to: 'PTUK University',
                          price: '₪7',
                          status: 'completed',
                          time: '25 min ago',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String value,
    required String label,
  }) {
    return Container(
      height: 187,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color:  AppColors.borderadmincolor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 28,
              color: Color(0xFF101828),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF6A7282),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripItem({
    required String passenger,
    required String driver,
    required String from,
    required String to,
    required String price,
    required String status,
    required String time,
  }) {
    final isCompleted = status == 'completed';
    final statusColor = isCompleted ? Colors.green : Colors.blue;
    final statusBgColor = isCompleted ? Colors.green.withOpacity(0.1) : Colors.blue.withOpacity(0.1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.adminBackground,
            child: Icon(Icons.person_outline, color: Color(0xFF6A7282)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(passenger, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF101828))),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.arrow_forward, size: 14, color: Color(0xFF6A7282)),
                    ),
                    Text(driver, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF101828))),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(from, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6A7282))),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(Icons.arrow_forward, size: 10, color: Color(0xFF6A7282)),
                    ),
                    Text(to, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6A7282))),
                  ],
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.orangeprimary),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 12, color: statusColor),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 80,
            child: Text(
              time,
              textAlign: TextAlign.right,
              style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6A7282)),
            ),
          ),
        ],
      ),
    );
  }
}
