import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/driver_review_model.dart';
import 'package:uni_ride_application/core/provider/rating_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class CarpoolReviewsScreen extends StatefulWidget {
  const CarpoolReviewsScreen({super.key});

  @override
  State<CarpoolReviewsScreen> createState() => _CarpoolReviewsScreenState();
}

class _CarpoolReviewsScreenState extends State<CarpoolReviewsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RatingProvider>().fetchMyReviews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l         = AppLocalizations.of(context)!;
    final provider  = context.watch<RatingProvider>();
    final isLoading = provider.reviewsState == RatingState.loading;
    final isError   = provider.reviewsState == RatingState.error;
    final data      = provider.reviews;

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
            decoration: BoxDecoration(color: context.borderColor, shape: BoxShape.circle),
            child: Icon(Icons.arrow_back, color: context.textPrimary, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l.myReviews,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: context.textPrimary),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: context.borderColor, height: 1),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary))
          : isError
              ? Center(child: Text(provider.errorMessage, style: const TextStyle(color: AppColors.errorRed)))
              : data == null || data.reviews.isEmpty
                  ? _buildEmpty(context)
                  : Column(
                      children: [
                        _buildSummaryHeader(context, data),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: data.reviews.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 12),
                            itemBuilder: (_, i) => _ReviewCard(review: data.reviews[i]),
                          ),
                        ),
                      ],
                    ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_outline_rounded, size: 56, color: context.textHint),
          const SizedBox(height: 12),
          Text(AppLocalizations.of(context)!.noReviewsYet, style: TextStyle(color: context.textHint, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader(BuildContext context, DriverReviewsResponse data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: context.bgCard,
        border: Border(bottom: BorderSide(color: context.borderColor)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.orangeprimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  data.averageRating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.orangeprimary),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (i) => Icon(
                    i < data.averageRating.round() ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 14,
                    color: AppColors.orangeprimary,
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.reviewsCount(data.totalReviews),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: context.textPrimary),
                ),
                const SizedBox(height: 8),
                ...List.generate(5, (i) {
                  final star  = 5 - i;
                  final count = data.breakdown[star] ?? 0;
                  final pct   = data.totalReviews > 0 ? count / data.totalReviews : 0.0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Text('$star', style: TextStyle(fontSize: 11, color: context.textHint)),
                        const SizedBox(width: 4),
                        const Icon(Icons.star_rounded, size: 11, color: AppColors.orangeprimary),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: pct.toDouble(),
                              minHeight: 6,
                              backgroundColor: context.borderColor,
                              valueColor: const AlwaysStoppedAnimation(AppColors.orangeprimary),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('$count', style: TextStyle(fontSize: 11, color: context.textHint)),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final DriverReviewModel review;
  const _ReviewCard({required this.review});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours   < 24) return '${diff.inHours}h ago';
    if (diff.inDays    <  7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final initial  = review.studentName.isNotEmpty ? review.studentName[0].toUpperCase() : '?';
    final imageUrl = review.studentProfilePicture != null && review.studentProfilePicture!.isNotEmpty
        ? 'http://uniride.runasp.net/${review.studentProfilePicture}'
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.orangeprimary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        width: 40, height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Text(initial,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.orangeprimary)),
                      )
                    : Text(initial,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.orangeprimary)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.studentName,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary)),
                    const SizedBox(height: 2),
                    Row(
                      children: List.generate(5, (i) => Icon(
                        i < review.score ? Icons.star_rounded : Icons.star_outline_rounded,
                        size: 14,
                        color: AppColors.orangeprimary,
                      )),
                    ),
                  ],
                ),
              ),
              Text(_timeAgo(review.createdAt),
                style: TextStyle(fontSize: 11, color: context.textHint)),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text('"${review.comment}"',
              style: TextStyle(fontSize: 13, color: context.textSecondary, fontStyle: FontStyle.italic, height: 1.5)),
          ],
          if (review.tags.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: review.tags.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: context.isDark
                      ? AppColors.successDeepDark.withValues(alpha: 0.3)
                      : AppColors.successBGStart,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.isDark ? AppColors.successDarkGreen : AppColors.successBorder,
                  ),
                ),
                child: Text(tag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: context.isDark ? AppColors.successLightGreen : AppColors.successDarkText,
                  )),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
