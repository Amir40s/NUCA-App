import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:nuca/utils/export.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

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
          SvgPicture.asset(image, height: 280.px),
          Gap(3.2.px),
          AppTextWidget(
            text: title,
            textAlign: TextAlign.center,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          Gap(6.px),
          AppTextWidget(
            softWrap: true,
            text: subtitle,
            textAlign: TextAlign.center,
            fontSize: 18,
            color: AppColors.midGrey,
          ),
        ],
      ),
    );
  }
}
