import 'package:flutter/material.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:nuca/utils/app_colors.dart';

class EmptyWidget extends StatefulWidget {
  final String message;
  final IconData icon;

  const EmptyWidget({
    super.key,
    this.message = "No data available",
    this.icon = Icons.inbox_outlined,
  });

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _translate;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _translate = Tween<double>(
      begin: -6,
      end: 6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _translate,
            builder: (_, child) {
              return Transform.translate(
                offset: Offset(0, _translate.value),
                child: child,
              );
            },
            child: Container(
              width: 14.w,
              height: 14.w,
              margin: EdgeInsets.symmetric(vertical: 2.5.h),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary,
              ),
              child: Icon(widget.icon, size: 7.w, color: AppColors.white),
            ),
          ),
          AppTextWidget(
            text: widget.message,
            textAlign: TextAlign.center,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.midGrey,
          ),
          SizedBox(height: 1.h),
          AppTextWidget(
            text: "Pull to refresh or try again",
            textAlign: TextAlign.center,
            fontSize: 14,
            color: AppColors.midGrey.withAlpha(200),
          ),
        ],
      ),
    );
  }
}
