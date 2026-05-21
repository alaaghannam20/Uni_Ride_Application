import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/provider/app_theme_provider.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  bool _autoApprove = false;
  bool _emailNotifications = true;
  bool _smsNotifications = true;
  late final TextEditingController _appFeeController;

  @override
  void initState() {
    super.initState();
    _appFeeController = TextEditingController(text: '${AppPrefs.getAppFee()}');
  }

  @override
  void dispose() {
    _appFeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale         = AppLocalizations.of(context)!;
    final isDesktop      = Responsive.isDesktop(context);
    final langProvider   = context.watch<AppLanguageProvider>();
    final themeProvider  = context.watch<AppThemeProvider>();
    final isArabic       = langProvider.isArabic;
    final isLightMode    = themeProvider.isLightMode;

    return AdminLayout(
      activeRoute: '/AdminSettings',
      child: Column(
        children: [
          AdminHeader(
            title: locale.systemSettings,
            showSearchAndFilter: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 25 : 12,
                vertical: 25,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isDesktop ? 1160 : double.infinity),
                  child: Column(
                    children: [
                      _SettingsSection(
                        title: locale.systemConfiguration,
                        children: [
                          _SwitchSettingRow(
                            title: locale.autoApproveDrivers,
                            description: locale.autoApproveDriversDesc,
                            value: _autoApprove,
                            onChanged: (val) => setState(() => _autoApprove = val),
                          ),
                          const Divider(height: 1, color: AppColors.adminDivider),
                          _SwitchSettingRow(
                            title: locale.emailNotifications,
                            description: locale.emailNotificationsDesc,
                            value: _emailNotifications,
                            onChanged: (val) => setState(() => _emailNotifications = val),
                          ),
                          const Divider(height: 1, color: AppColors.adminDivider),
                          _SwitchSettingRow(
                            title: locale.smsNotifications,
                            description: locale.smsNotificationsDesc,
                            value: _smsNotifications,
                            onChanged: (val) => setState(() => _smsNotifications = val),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _SettingsSection(
                        title: locale.preferences,
                        children: [
                          // Language
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(locale.languageLabel, style: AppStyle.adminSettingsItemTitle(context)),
                                      const SizedBox(height: 4),
                                      Text(isArabic ? locale.ar : locale.en, style: AppStyle.adminSettingsItemDesc(context)),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.adminBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () => langProvider.setLocale('en'),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: !isArabic ? AppColors.orangeprimary : Colors.transparent,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text('EN', style: TextStyle(color: !isArabic ? Colors.white : AppColors.greySecondary, fontWeight: FontWeight.w600, fontSize: 13)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => langProvider.setLocale('ar'),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: isArabic ? AppColors.orangeprimary : Colors.transparent,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text('AR', style: TextStyle(color: isArabic ? Colors.white : AppColors.greySecondary, fontWeight: FontWeight.w600, fontSize: 13)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1, color: AppColors.adminDivider),
                          // Theme
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(locale.theme, style: AppStyle.adminSettingsItemTitle(context)),
                                      const SizedBox(height: 4),
                                      Text(isLightMode ? locale.lightMode : locale.darkMode, style: AppStyle.adminSettingsItemDesc(context)),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: isLightMode,
                                  onChanged: (val) => themeProvider.setLightMode(val),
                                  activeThumbColor:   Colors.white,
                                  activeTrackColor:   AppColors.orangeprimary,
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: AppColors.adminDivider,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _SettingsSection(
                        title: locale.pricingConfiguration,
                        children: [
                          _InputSettingRow(
                            label: locale.appFeePerTrip,
                            description: locale.appFeePerTripDesc,
                            controller: _appFeeController,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () async {
                                final fee = int.tryParse(_appFeeController.text.trim()) ?? 3;
                                await AppPrefs.setAppFee(fee);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تم حفظ رسوم التطبيق بنجاح'),
                                    backgroundColor: AppColors.adminSecondary,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.adminSecondary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                locale.saveChanges,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyle.adminSettingsSectionTitle(context)),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }
}

class _SwitchSettingRow extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchSettingRow({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppStyle.adminSettingsItemTitle(context)),
                const SizedBox(height: 4),
                Text(description, style: AppStyle.adminSettingsItemDesc(context)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor:  AppColors.adminSecondary,
            inactiveThumbColor:  AppColors.adminSearchHint,
            inactiveTrackColor: AppColors.adminDivider,
            
          ),
        ],
      ),
    );
  }
}

class _InputSettingRow extends StatelessWidget {
  final String label;
  final String? description;
  final TextEditingController controller;

  const _InputSettingRow({required this.label, required this.controller, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.adminTextDark)),
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(description!, style: const TextStyle(fontSize: 12, color: AppColors.greySecondary)),
        ],
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor:  AppColors.adminBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderadmincolor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderadmincolor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.adminSecondary),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
