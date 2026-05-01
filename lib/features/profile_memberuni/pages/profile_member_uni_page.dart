import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/provider/app_theme_provider.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _pushNotifications = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchMemberProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<AppLanguageProvider>();
    final isArabic = languageProvider.isArabic;
    final themeProvider = context.watch<AppThemeProvider>();
    final isLightMode = themeProvider.isLightMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.appBarBg,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.greyLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.greyDark,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.profile, style: AppStyle.ratingTitleStyle),
            Text(l10n.manageAccount, style: AppStyle.ratingSubtitleStyle),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.greyLight, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top White Header Background transitioning to grey body
            Container(color: Colors.white, height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Orange Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.orangeprimary,
                          AppColors.primaryGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33CF8307),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar Section
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.person_outline,
                                  color: AppColors.orangeprimary,
                                  size: 36,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.orangeprimary,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),

                        // Details Section
                        Expanded(
                          child: Consumer<ProfileProvider>(
                            builder: (context, provider, _) {
                              final profile = provider.memberProfile;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile?.fullName ?? '...',
                                    style: AppStyle.profileNameStyle,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${l10n.memberSince} ${profile?.memberSince ?? ''}',
                                    style: AppStyle.profileMemberSinceStyle,
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      _buildStatChip('${profile?.totalTrips ?? 0} ${l10n.tripsCount}'),
                                      const SizedBox(width: 8),
                                      _buildStatChip('★ ${profile?.rewardPoints ?? 0} pts'),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Personal Information
                  Text(
                    l10n.personalInformation,
                    style: AppStyle.profileSectionTitleStyle,
                  ),

                  const SizedBox(height: 12),
                  Consumer<ProfileProvider>(
                    builder: (context, provider, _) {
                      final profile = provider.memberProfile;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            _buildInfoTile(
                              iconData: Icons.email_outlined,
                              iconColor: AppColors.adminInfoText,
                              iconBgColor: AppColors.adminInfoBG,
                              label: l10n.email,
                              value: profile?.email ?? '...',
                              showChevron: true,
                            ),
                            const Divider(height: 1, color: AppColors.borderadmincolor),
                            _buildInfoTile(
                              iconData: Icons.phone_outlined,
                              iconColor: AppColors.emeraldGreen,
                              iconBgColor: AppColors.emeraldGreenBg,
                              label: l10n.phone,
                              value: profile?.phoneNumber ?? '...',
                              showChevron: true,
                              onTap: () => _showEditPhoneDialog(context, profile?.phoneNumber ?? ''),
                            ),
                            const Divider(height: 1, color: AppColors.borderadmincolor),
                            _buildInfoTile(
                              iconData: Icons.school_outlined,
                              iconColor: AppColors.adminPrice,
                              iconBgColor: AppColors.amberWarningBg,
                              label: l10n.universityMember,
                              value: profile?.memberType ?? '...',
                              showChevron: true,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Preferences
                  Text(
                    l10n.preferences,
                    style: AppStyle.profileSectionTitleStyle,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildPreferenceTile(
                          iconData: Icons.language,
                          iconColor: AppColors.purpleAccent,
                          iconBgColor: AppColors.purpleAccentBg,
                          label: l10n.languageLabel,
                          value: isArabic ? l10n.ar : l10n.en,
                          trailing: _buildLanguageToggle(context, isArabic),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.borderadmincolor,
                        ),
                        _buildPreferenceTile(
                          iconData: isLightMode
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          iconColor: AppColors.adminInfoText,
                          iconBgColor: AppColors.adminInfoBG,
                          label: l10n.theme,
                          value: isLightMode ? l10n.lightMode : l10n.darkMode,
                          trailing: Switch(
                            value: isLightMode,
                            onChanged: (val) => themeProvider.setLightMode(val),
                            activeThumbColor: Colors.white,
                            activeTrackColor: AppColors.orangeprimary,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: AppColors.borderadmincolor,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.borderadmincolor,
                        ),
                        _buildPreferenceTile(
                          iconData: Icons.notifications_none_outlined,
                          iconColor: AppColors.adminPrice,
                          iconBgColor: AppColors.amberWarningBg,
                          label: l10n.notifications,
                          value: l10n.pushNotifications,
                          trailing: Switch(
                            value: _pushNotifications,
                            onChanged: (val) {
                              setState(() {
                                _pushNotifications = val;
                              });
                            },
                            activeThumbColor: Colors.white,
                            activeTrackColor: AppColors.orangeprimary,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: AppColors.borderadmincolor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Security & Support
                  Text(
                    'Security & Support',
                    style: AppStyle.profileSectionTitleStyle,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          iconData: Icons.security_outlined,
                          iconColor: AppColors.adminErrorText,
                          iconBgColor: AppColors.adminErrorBG,
                          label: l10n.privacySecurity,
                          value: l10n.managePrivacySettings,
                          showChevron: true,
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.borderadmincolor,
                        ),
                        _buildInfoTile(
                          iconData: Icons.help_outline,
                          iconColor: AppColors.adminInfoText,
                          iconBgColor: AppColors.adminInfoBG,
                          label: l10n.helpSupport,
                          value: l10n.getHelpOrContact,
                          showChevron: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Log Out Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logout logic
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: AppColors.redColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(l10n.logOut, style: AppStyle.profileLogoutStyle),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: AppColors.orangeprimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'P',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${l10n.poweredBy}${l10n.ptukEngineering}',
                        style: AppStyle.ratingFooterTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: AppStyle.profileStatStyle),
    );
  }

  void _showEditPhoneDialog(BuildContext context, String current) {
    final controller = TextEditingController(text: current);
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.editPhoneNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          autofocus: true,
          decoration: InputDecoration(
            hintText: '059XXXXXXX',
            prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.emeraldGreen),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.orangeprimary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel, style: const TextStyle(color: AppColors.greyHint)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orangeprimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              final phone = controller.text.trim();
              if (phone.isEmpty) return;
              Navigator.pop(context);
              final success = await context.read<ProfileProvider>().updateProfile(phoneNumber: phone);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(success ? l10n.profileUpdatedSuccess : context.read<ProfileProvider>().errorMessage),
                backgroundColor: success ? AppColors.emeraldGreen : AppColors.errorRed,
              ));
            },
            child: Text(l10n.save, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData iconData,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
    bool showChevron = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
              child: Icon(iconData, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppStyle.profileItemLabelStyle),
                  const SizedBox(height: 2),
                  Text(value, style: AppStyle.profileItemValueStyle),
                ],
              ),
            ),
            if (showChevron)
              Icon(
                onTap != null ? Icons.edit_outlined : Icons.chevron_right,
                color: onTap != null ? AppColors.orangeprimary : AppColors.greyHint,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceTile({
    required IconData iconData,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
    required Widget trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyle
                      .profileItemValueStyle, // For preference, label is the title
                ),
                const SizedBox(height: 2),
                Text(value, style: AppStyle.profileItemLabelStyle),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildLanguageToggle(BuildContext context, bool isArabic) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => context.read<AppLanguageProvider>().setLocale('en'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: !isArabic ? AppColors.orangeprimary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'EN',
                style: TextStyle(
                  color: !isArabic ? Colors.white : AppColors.greySecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.read<AppLanguageProvider>().setLocale('ar'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isArabic ? AppColors.orangeprimary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'AR',
                style: TextStyle(
                  color: isArabic ? Colors.white : AppColors.greySecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
