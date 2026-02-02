import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';

class PickerTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final String icon;

  const PickerTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: AppTextWidget(
                text: value.isEmpty ? title : value,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
                color: value.isEmpty ? AppColors.midGrey : AppColors.black,
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
