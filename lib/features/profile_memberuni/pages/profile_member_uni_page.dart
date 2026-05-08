import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
            decoration: BoxDecoration(
              color: context.bgSubtle,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back,
              color: context.textPrimary,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.profile, style: AppStyle.ratingTitle(context)),
            Text(l10n.manageAccount, style: AppStyle.ratingSubtitle(context)),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: context.borderColor, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header Background transitioning to grey body
            Container(color: context.bgCard, height: 16),

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
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.orangeprimary.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar Section
                        GestureDetector(
                          onTap: () => _pickAndUploadImage(context),
                          child: Consumer<ProfileProvider>(
                            builder: (context, provider, _) {
                              final imgPath = provider.memberProfile?.profilePicturePath;
                              final name    = provider.memberProfile?.fullName ?? '';
                              final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 72,
                                    height: 72,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: context.bgWhite,
                                      shape: BoxShape.circle,
                                    ),
                                    child: provider.uploadingImage
                                        ? const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary, strokeWidth: 2))
                                        : imgPath != null
                                            ? Image.network(
                                                'http://uniride.runasp.net/$imgPath',
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, _, _) => Center(child: Text(initial, style: const TextStyle(color: AppColors.orangeprimary, fontWeight: FontWeight.bold, fontSize: 28))),
                                              )
                                            : Center(child: Text(initial, style: const TextStyle(color: AppColors.orangeprimary, fontWeight: FontWeight.bold, fontSize: 28))),
                                  ),
                                  Positioned(
                                    bottom: -4,
                                    right: -4,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: context.bgWhite,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.camera_alt_outlined, color: AppColors.orangeprimary, size: 14),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
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
                                      _buildStatChip(context, '${profile?.totalTrips ?? 0} ${l10n.tripsCount}'),
                                      const SizedBox(width: 8),
                                      _buildStatChip(context, '★ ${profile?.rewardPoints ?? 0} pts'),
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
                    style: AppStyle.profileSectionTitle(context),
                  ),

                  const SizedBox(height: 12),
                  Consumer<ProfileProvider>(
                    builder: (context, provider, _) {
                      final profile = provider.memberProfile;
                      return Container(
                        decoration: BoxDecoration(
                          color: context.bgCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: context.borderColor),
                        ),
                        child: Column(
                          children: [
                            _buildInfoTile(
                              context: context,
                              iconData: Icons.email_outlined,
                              iconColor: AppColors.adminInfoText,
                              iconBgColor: AppColors.adminInfoBG,
                              label: l10n.email,
                              value: profile?.email ?? '...',
                              showChevron: true,
                            ),
                            Divider(height: 1, color: context.borderColor),
                            _buildInfoTile(
                              context: context,
                              iconData: Icons.phone_outlined,
                              iconColor: AppColors.emeraldGreen,
                              iconBgColor: AppColors.emeraldGreenBg,
                              label: l10n.phone,
                              value: profile?.phoneNumber ?? '...',
                              showChevron: true,
                              onTap: () => _showEditPhoneDialog(context, profile?.phoneNumber ?? ''),
                            ),
                            Divider(height: 1, color: context.borderColor),
                            _buildInfoTile(
                              context: context,
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
                    style: AppStyle.profileSectionTitle(context),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: context.bgCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.borderColor),
                    ),
                    child: Column(
                      children: [
                        _buildPreferenceTile(
                          context: context,
                          iconData: Icons.language,
                          iconColor: AppColors.purpleAccent,
                          iconBgColor: AppColors.purpleAccentBg,
                          label: l10n.languageLabel,
                          value: isArabic ? l10n.ar : l10n.en,
                          trailing: _buildLanguageToggle(context, isArabic),
                        ),
                        Divider(
                          height: 1,
                          color: context.borderColor,
                        ),
                        _buildPreferenceTile(
                          context: context,
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
                            inactiveTrackColor: context.borderColor,
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: context.borderColor,
                        ),
                        _buildPreferenceTile(
                          context: context,
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
                            inactiveTrackColor: context.borderColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Security & Support
                  Text(
                    'Security & Support',
                    style: AppStyle.profileSectionTitle(context),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: context.bgCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.borderColor),
                    ),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          context: context,
                          iconData: Icons.security_outlined,
                          iconColor: AppColors.adminErrorText,
                          iconBgColor: AppColors.adminErrorBG,
                          label: l10n.privacySecurity,
                          value: l10n.managePrivacySettings,
                          showChevron: true,
                        ),
                        Divider(
                          height: 1,
                          color: context.borderColor,
                        ),
                        _buildInfoTile(
                          context: context,
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
                        backgroundColor: context.bgCard,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: BorderSide(color: context.borderColor),
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
                          Text(l10n.logOut, style: AppStyle.profileLogout(context)),
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

  Widget _buildStatChip(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: AppStyle.profileStatStyle),
    );
  }

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null || !context.mounted) return;
    final success = await context.read<ProfileProvider>().uploadMemberProfileImage(File(picked.path));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? 'Profile picture updated!' : context.read<ProfileProvider>().errorMessage),
      backgroundColor: success ? AppColors.emeraldGreen : AppColors.errorRed,
    ));
  }

  void _showEditPhoneDialog(BuildContext context, String current) {
    final controller = TextEditingController(text: current);
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: context.bgCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.editPhoneNumber, style: TextStyle(fontWeight: FontWeight.bold, color: context.textPrimary)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          autofocus: true,
          style: TextStyle(color: context.textPrimary),
          decoration: InputDecoration(
            hintText: '059XXXXXXX',
            hintStyle: TextStyle(color: context.textHint),
            prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.emeraldGreen),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.orangeprimary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel, style: TextStyle(color: context.textSecondary)),
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
    required BuildContext context,
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
                  Text(label, style: AppStyle.profileItemLabel(context)),
                  const SizedBox(height: 2),
                  Text(value, style: AppStyle.profileItemValue(context)),
                ],
              ),
            ),
            if (showChevron)
              Icon(
                onTap != null ? Icons.edit_outlined : Icons.chevron_right,
                color: onTap != null ? AppColors.orangeprimary : context.textHint,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceTile({
    required BuildContext context,
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
                  style: AppStyle.profileItemValue(context),
                ),
                const SizedBox(height: 2),
                Text(value, style: AppStyle.profileItemLabel(context)),
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
        color: context.bgSubtle,
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
                  color: !isArabic ? Colors.white : context.textSecondary,
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
                  color: isArabic ? Colors.white : context.textSecondary,
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
