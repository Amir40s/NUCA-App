import 'package:flutter/material.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';

class OnBoardingWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 280, fit: BoxFit.contain),
          const SizedBox(height: 32),
          AppTextWidget(
            text: title,
            textAlign: TextAlign.center,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 12),
          AppTextWidget(
            text: subtitle,
            textAlign: TextAlign.center,
            fontSize: 14,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
