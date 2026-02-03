import 'package:flutter/material.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class ScanOverlay extends StatelessWidget {
  const ScanOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final double squareSize = 70.w;
    final double cornerLength = 40;
    final double cornerWidth = 4;
    final double sideLineHeight = squareSize * 0.4;
    final double sideLineWidth = 4;
    return Center(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(120),
              BlendMode.srcOut,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: squareSize,
                    height: squareSize,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: squareSize,
                height: squareSize,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: cornerLength,
                        height: cornerWidth,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: cornerWidth,
                        height: cornerLength,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: cornerLength,
                        height: cornerWidth,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: cornerWidth,
                        height: cornerLength,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: cornerLength,
                        height: cornerWidth,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: cornerWidth,
                        height: cornerLength,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: cornerLength,
                        height: cornerWidth,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: cornerWidth,
                        height: cornerLength,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: (squareSize - sideLineHeight) / 2,
                      child: Container(
                        width: sideLineWidth,
                        height: sideLineHeight,
                        color: AppColors.white,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: (squareSize - sideLineHeight) / 2,
                      child: Container(
                        width: sideLineWidth,
                        height: sideLineHeight,
                        color: AppColors.white,
                      ),
                    ),
                    _AnimatedScanLine(squareSize: squareSize),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedScanLine extends StatefulWidget {
  final double squareSize;
  const _AnimatedScanLine({required this.squareSize});

  @override
  State<_AnimatedScanLine> createState() => _AnimatedScanLineState();
}

class _AnimatedScanLineState extends State<_AnimatedScanLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: widget.squareSize,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Positioned(
          top: _animation.value,
          left: 0,
          right: 0,
          child: Container(height: 2, color: AppColors.secondary),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
