import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/rating_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class RateDriverPage extends StatefulWidget {
  final int bookingId;
  final String driverName;
  final String driverType;
  final String? profilePicturePath;

  const RateDriverPage({
    Key? key,
    required this.bookingId,
    this.driverName = 'Ali M.',
    this.driverType = 'Driver',
    this.profilePicturePath,
  }) : super(key: key);

  @override
  State<RateDriverPage> createState() => _RateDriverPageState();
}

class _RateDriverPageState extends State<RateDriverPage> {
  int _rating = 4; // Default to 4 as per image
  final TextEditingController _commentController = TextEditingController();
  final Set<String> _selectedFeedback = {};
  final List<String> _feedbackKeys = ['Friendly', 'On Time', 'Safe Driver', 'Clean Car'];

  Map<String, String> _feedbackLabels(AppLocalizations l) => {
    'Friendly': l.friendly,
    'On Time': l.onTime,
    'Safe Driver': l.safeDriver,
    'Clean Car': l.cleanCar,
  };


  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String _getRatingText(AppLocalizations l) {
    switch (_rating) {
      case 1: return l.ratingPoor;
      case 2: return l.ratingFair;
      case 3: return l.ratingGood;
      case 4: return l.ratingVeryGood;
      case 5: return l.ratingExcellent;
      default: return '';
    }
  }

  Widget _buildChip(String key, String label) {
    final isSelected = _selectedFeedback.contains(key);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedFeedback.remove(key);
          } else {
            _selectedFeedback.add(key);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orangeprimary : context.bgCard,
          border: Border.all(
            color: isSelected ? AppColors.orangeprimary : context.borderColor,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            label,
            style: isSelected
                ? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                : TextStyle(color: context.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final ratingProvider = context.watch<RatingProvider>();
    final isLoading = ratingProvider.state == RatingState.loading;
    final labels = _feedbackLabels(l);

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
              color: context.borderColor,
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
            Text(
              l.rateYourDriver,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: context.textPrimary),
            ),
            Text(
              l.howWasExperience,
              style: TextStyle(color: context.textSecondary, fontSize: 14),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: context.borderColor,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver Info
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.orangeprimary,
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.orangeprimary, AppColors.primaryGradientEnd],
                    ),
                  ),
                  child: widget.profilePicturePath != null && widget.profilePicturePath!.isNotEmpty
                      ? Image.network(
                          'http://uniride.runasp.net/${widget.profilePicturePath}',
                          fit: BoxFit.cover,
                          width: 56,
                          height: 56,
                          errorBuilder: (_, _, _) => Center(
                            child: Text(
                              widget.driverName.isNotEmpty ? widget.driverName[0].toUpperCase() : '?',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            widget.driverName.isNotEmpty ? widget.driverName[0].toUpperCase() : '?',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.driverName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.driverType,
                      style: TextStyle(color: context.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Rating Stars
            Text(
              l.rating,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.textPrimary),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: context.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.borderColor, width: 0.62),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      final isSelected = starIndex <= _rating;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = starIndex;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            isSelected
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: isSelected
                                ? AppColors.orangeprimary
                                : context.textHint.withValues(alpha: 0.5),
                            size: 48,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getRatingText(l),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.orangeprimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ── Additional Comments Container ──────────────────────────
            Container(
              decoration: BoxDecoration(
                color: context.bgCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: context.borderColor, width: 0.62),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.orangeprimary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit_note_rounded, size: 20, color: AppColors.orangeprimary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l.additionalComments,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: context.textPrimary)),
                            const SizedBox(height: 2),
                            Text(l.shareMoreDetails,
                              style: TextStyle(color: context.textSecondary, fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: context.bgSubtle,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _commentController.text.isNotEmpty
                            ? AppColors.orangeprimary.withValues(alpha: 0.6)
                            : context.borderColor,
                        width: 1.2,
                      ),
                    ),
                    child: TextField(
                      controller: _commentController,
                      maxLines: 5,
                      maxLength: 500,
                      style: TextStyle(color: context.textPrimary, fontSize: 14, height: 1.6),
                      decoration: InputDecoration(
                        hintText: l.commentHint,
                        hintStyle: TextStyle(color: context.textHint, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(14),
                        counterText: '',
                      ),
                      onChanged: (text) => setState(() {}),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${_commentController.text.length}/500',
                      style: TextStyle(color: context.textHint, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Quick Feedback Container ───────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: context.bgCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: context.borderColor, width: 0.62),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.orangeprimary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.thumb_up_alt_outlined, size: 18, color: AppColors.orangeprimary),
                      ),
                      const SizedBox(width: 12),
                      Text(l.quickFeedback,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: context.textPrimary)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildChip(_feedbackKeys[0], labels[_feedbackKeys[0]]!)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildChip(_feedbackKeys[1], labels[_feedbackKeys[1]]!)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildChip(_feedbackKeys[2], labels[_feedbackKeys[2]]!)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildChip(_feedbackKeys[3], labels[_feedbackKeys[3]]!)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : () async {
                  final ratingProvider = context.read<RatingProvider>();
                  final success = await ratingProvider.submitRating(
                    bookingId: widget.bookingId,
                    score: _rating,
                    comment: _commentController.text.trim(),
                    tags: _selectedFeedback.toList(),
                  );
                  if (!mounted) return;
                  if (success) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.ratingSubmittedSuccess), backgroundColor: Colors.green),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(ratingProvider.errorMessage), backgroundColor: Colors.red),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orangeprimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      l.submitRating,
                      style: AppStyle.custombuttonstyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 24),

            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.orangeprimary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
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
                SizedBox(width: 6),
                Text(
                  '${l.poweredBy}${l.ptukEngineering}',
                  style: TextStyle(color: context.textSecondary, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
