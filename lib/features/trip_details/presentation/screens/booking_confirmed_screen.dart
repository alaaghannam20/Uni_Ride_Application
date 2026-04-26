import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.bgWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.adminSuccessBG,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline, color: AppColors.adminSuccessText, size: 40),
            ),
            const SizedBox(height: 20),
            
            // Titles
            Text(
              l.booking_confirmed,
              style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 24, color: AppColors.greyDark),
            ),
            const SizedBox(height: 8),
            Text(
              l.booking_confirmed_sub,
              style: const TextStyle(color: AppColors.greySecondary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Booking ID Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.walletCardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.amberWarningBg, width: 1.5),
              ),
              child: Column(
                children: [
                  Text(l.booking_id, style: const TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                  const SizedBox(height: 6),
                  const Text('BK-2024-00142', style: TextStyle(color: AppColors.orangeprimary, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Trip Details Card
            _CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.tripDetails, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.greyDark)),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: AppColors.amberWarningBg, shape: BoxShape.circle),
                        child: const Icon(Icons.location_on_outlined, color: AppColors.orangeprimary, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l.route, style: const TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                            const SizedBox(height: 2),
                            const Text('PTUK University → City Center', style: TextStyle(color: AppColors.greyDark, fontSize: 14, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 2),
                            const Text('Pickup: PTUK Main Gate', style: TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: AppColors.amberWarningBg, shape: BoxShape.circle),
                        child: const Icon(Icons.calendar_today_outlined, color: AppColors.orangeprimary, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l.dateTime, style: const TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                            const SizedBox(height: 2),
                            const Text('Today, March 2', style: TextStyle(color: AppColors.greyDark, fontSize: 14, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 2),
                            const Text('Departure at 2:30 PM', style: TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Driver Details Card
            _CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.driver_details, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.greyDark)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(color: AppColors.orangeprimary, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('M', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mohammed K.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.greyDark)),
                            const SizedBox(height: 4),
                            Row(
                              children: const [
                                Icon(Icons.star, color: AppColors.adminPrice, size: 14),
                                SizedBox(width: 4),
                                Text('4.8', style: TextStyle(color: AppColors.greySecondary, fontSize: 13)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.greyBackground, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.directions_car_outlined, color: AppColors.greySecondary, size: 18),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Hyundai i10 - White', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.greyDark)),
                            SizedBox(height: 4),
                            Text('Plate Number: AB 1234', style: TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(color: AppColors.adminInfoBG, borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: const Text('Contact: +972-59-xxx-xxxx', style: TextStyle(color: AppColors.infoBlue, fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Payment Status Card
            _CardContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.payment_status, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.greyDark)),
                      const SizedBox(height: 4),
                      const Text('Paid successfully', style: TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                    ],
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: '₪ ', style: TextStyle(color: AppColors.orangeprimary, fontSize: 14, fontWeight: FontWeight.bold)),
                        TextSpan(text: '8', style: TextStyle(color: AppColors.orangeprimary, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Download & Share Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.file_download_outlined, size: 18, color: AppColors.grey344),
                    label: Text(l.download, style: const TextStyle(color: AppColors.grey344, fontSize: 14, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyBackground,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined, size: 18, color: AppColors.grey344),
                    label: Text(l.share, style: const TextStyle(color: AppColors.grey344, fontSize: 14, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyBackground,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Important Reminder Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.walletCardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.access_time, color: AppColors.primaryGradientEnd, size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Important Reminder', style: TextStyle(color: AppColors.warningTextDark, fontSize: 12, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(l.pickup_reminder, style: const TextStyle(color: AppColors.orangeprimary, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/HomeScreen');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orangeprimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text(l.back_to_home, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;

  const _CardContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyLight, width: 1.5),
      ),
      child: child,
    );
  }
}
