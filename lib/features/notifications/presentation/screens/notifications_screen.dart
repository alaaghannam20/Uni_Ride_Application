import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/notification_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/features/notifications/data/models/notification_model.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().fetchNotifications();
    });
  }


  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.bgCard,
      appBar: AppBar(
        backgroundColor: context.bgCard,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: context.borderColor, shape: BoxShape.circle),
            child: Icon(Icons.arrow_back, color: context.textPrimary, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          l.notifications,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: context.textPrimary),
        ),
        actions: [
          Consumer<NotificationProvider>(
            builder: (_, provider, _) {
              if (provider.unreadCount == 0) return const SizedBox.shrink();
              return Tooltip(
                message: l.markAllRead,
                child: IconButton(
                  onPressed: provider.markAllRead,
                  icon: const Icon(Icons.done_all_rounded, color: AppColors.orangeprimary),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: context.borderColor, height: 1),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          if (provider.state == NotificationLoadState.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.orangeprimary),
            );
          }

          if (provider.state == NotificationLoadState.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wifi_off_rounded, size: 48, color: context.textHint),
                  const SizedBox(height: 12),
                  Text(provider.errorMessage,
                      style: TextStyle(color: context.textSecondary),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: provider.fetchNotifications,
                    child: Text(l.retry,
                        style: const TextStyle(color: AppColors.orangeprimary)),
                  ),
                ],
              ),
            );
          }

          if (provider.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_none_rounded, size: 64, color: context.textHint),
                  const SizedBox(height: 16),
                  Text(l.noNotifications,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: context.textSecondary,
                      )),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: provider.notifications.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final notif = provider.notifications[index];
              return _NotificationCard(
                notification: notif,
                onTap: () => _onTap(context, notif),
              );
            },
          );
        },
      ),
    );
  }

  void _onTap(BuildContext context, NotificationModel notif) {
    // Mark as read if not already
    if (!notif.isRead) {
      context.read<NotificationProvider>().markOneRead(notif.notificationId);
    }

    final referenceId = int.tryParse(notif.referenceId ?? '');
    switch (notif.type.toLowerCase()) {
      case 'trip':
        if (referenceId != null) {
          Navigator.pushNamed(context, Routes.tripDetails, arguments: referenceId);
        }
        break;
      case 'booking':
        Navigator.pushNamedAndRemoveUntil(
          context, Routes.home, (route) => false,
          arguments: {'tabIndex': 1},
        );
        break;
      default:
        break;
    }
  }
}

// ── Card ──────────────────────────────────────────────────────────────────────

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationCard({required this.notification, required this.onTap});

  String _timeAgo(BuildContext context, DateTime dt) {
    final l    = AppLocalizations.of(context)!;
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1)   return l.timeJustNow;
    if (diff.inMinutes < 60)  return l.timeMinutesAgo(diff.inMinutes);
    if (diff.inHours   < 24)  return l.timeHoursAgo(diff.inHours);
    if (diff.inDays    < 30)  return l.timeDaysAgo(diff.inDays);
    if (diff.inDays    < 365) return l.timeWeeksAgo(diff.inDays);
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  String _typeLabel(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    switch (notification.type.toLowerCase()) {
      case 'trip':    return l.notifTypeTrip;
      case 'booking': return l.notifTypeBooking;
      case 'admin':   return l.notifTypeAdmin;
      case 'wallet':  return l.notifTypeWallet;
      default:        return l.notifTypeGeneral;
    }
  }

  _TypeMeta _typeMeta() {
    switch (notification.type.toLowerCase()) {
      case 'trip':
        return _TypeMeta(Icons.directions_car_rounded, const Color(0xFF3B82F6), const Color(0xFFEFF6FF));
      case 'booking':
        return _TypeMeta(Icons.bookmark_rounded, AppColors.orangeprimary, const Color(0xFFFFF7ED));
      case 'admin':
      case 'notification':
        return _TypeMeta(Icons.verified_rounded, const Color(0xFF059669), const Color(0xFFECFDF5));
      case 'wallet':
        return _TypeMeta(Icons.account_balance_wallet_rounded, const Color(0xFF059669), const Color(0xFFECFDF5));
      default:
        return _TypeMeta(Icons.notifications_rounded, const Color(0xFF8B5CF6), const Color(0xFFF5F3FF));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;
    final meta     = _typeMeta();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.isDark
              ? meta.color.withValues(alpha: 0.08)
              : meta.bg.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.isDark ? context.borderColor : meta.color.withValues(alpha: 0.15),
          ),
          boxShadow: [
            BoxShadow(
              color: meta.color.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left accent bar for unread
            Container(
              width: 4,
              color: isUnread ? meta.color : Colors.transparent,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Icon ────────────────────────────────────────────
                    Container(
                      width: 46, height: 46,
                      decoration: BoxDecoration(
                        color: meta.color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: meta.color.withValues(alpha: 0.25), width: 1),
                      ),
                      alignment: Alignment.center,
                      child: Icon(meta.icon, size: 22, color: meta.color),
                    ),
                    const SizedBox(width: 12),
                    // ── Content ─────────────────────────────────────────
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  notification.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                                    color: context.textPrimary,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _timeAgo(context, notification.createdAt),
                                style: TextStyle(fontSize: 11, color: context.textHint),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            notification.message,
                            style: TextStyle(
                              fontSize: 13,
                              color: context.textSecondary,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                            decoration: BoxDecoration(
                              color: meta.bg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _typeLabel(context),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: meta.color,
                              ),
                            ),
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
      ),
    );
  }
}

class _TypeMeta {
  final IconData icon;
  final Color color;
  final Color bg;
  const _TypeMeta(this.icon, this.color, this.bg);
}
