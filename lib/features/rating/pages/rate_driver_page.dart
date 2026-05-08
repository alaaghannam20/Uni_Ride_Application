import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/rating_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

class RateDriverPage extends StatefulWidget {
  final int bookingId;
  final String driverName;

  const RateDriverPage({
    Key? key,
    required this.bookingId,
    this.driverName = 'Ali M.',
  }) : super(key: key);

  @override
  State<RateDriverPage> createState() => _RateDriverPageState();
}

class _RateDriverPageState extends State<RateDriverPage> {
  int _rating = 4; // Default to 4 as per image
  final TextEditingController _commentController = TextEditingController();
  final Set<String> _selectedFeedback = {'Friendly', 'On Time', 'Safe Driver', 'Clean Car'};

  final List<String> _feedbackOptions = [
    'Friendly',
    'On Time',
    'Safe Driver',
    'Clean Car'
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String getRatingText() {
    switch (_rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }

  Widget _buildChip(String option) {
    final isSelected = _selectedFeedback.contains(option);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedFeedback.remove(option);
          } else {
            _selectedFeedback.add(option);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? (context.isDark ? const Color(0xFF064E3B).withValues(alpha: 0.3) : AppColors.successBGStart) : context.bgCard,
          border: Border.all(
            color: isSelected
                ? (context.isDark ? const Color(0xFF059669) : AppColors.successBorder)
                : context.borderColor,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            option,
            style: isSelected
                ? TextStyle(color: context.isDark ? const Color(0xFF34D399) : Colors.green, fontWeight: FontWeight.bold)
                : TextStyle(color: context.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ratingProvider = context.watch<RatingProvider>();
    final isLoading = ratingProvider.state == RatingState.loading;

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
              'Rate Your Driver',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: context.textPrimary),
            ),
            Text(
              'How was your experience?',
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver Info
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: AppColors.orangeprimary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 28,
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
                      'Driver',
                      style: TextStyle(color: context.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Rating Stars
            Text(
              'Rating',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.textPrimary),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: context.bgSubtle,
                borderRadius: BorderRadius.circular(16),
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
                    getRatingText(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.orangeprimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Additional Comments
            Text(
              'Additional Comments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              'Share more details about your experience (optional)',
              style: TextStyle(color: context.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: context.bgSubtle,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _commentController,
                maxLines: 4,
                maxLength: 500,
                style: TextStyle(color: context.textPrimary),
                decoration: InputDecoration(
                  hintText: 'What did you like or dislike about this trip?',
                  hintStyle: TextStyle(color: context.textHint),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  counterText: '',
                ),
                onChanged: (text) => setState(() {}),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_commentController.text.length}/500 characters',
              style: TextStyle(color: context.textHint, fontSize: 11),
            ),
            const SizedBox(height: 32),

            // Quick Feedback (Note: The API doesn't currently support these tags, so they are UI-only)
            Text(
              'Quick Feedback',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.textPrimary),
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildChip(_feedbackOptions[0])),
                    const SizedBox(width: 8),
                    Expanded(child: _buildChip(_feedbackOptions[1])),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildChip(_feedbackOptions[2])),
                    const SizedBox(width: 8),
                    Expanded(child: _buildChip(_feedbackOptions[3])),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 48),

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
                  );
                  if (!mounted) return;
                  if (success) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rating submitted successfully!'), backgroundColor: Colors.green),
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Submit Rating',
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
                  'Powered by PTUK Engineering',
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
