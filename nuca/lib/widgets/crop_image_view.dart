import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';
import 'custom_appbar.dart';
import 'custom_button.dart';

class CropImageView extends StatefulWidget {
  final File imageFile;

  const CropImageView({super.key, required this.imageFile});

  @override
  State<CropImageView> createState() => _CropImageViewState();
}

class _CropImageViewState extends State<CropImageView> {
  final CropController _cropController = CropController();
  Uint8List? _originalBytes;
  Uint8List? _imageBytes;
  Uint8List? _croppedPreview;
  bool _isCropping = false;
  bool _isTransforming = false;
  bool _shouldReturnResult = false;
  double? _aspectRatio;
  int _rotationTurns = 0;
  bool _flipX = false;
  bool _flipY = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final bytes = await widget.imageFile.readAsBytes();
    setState(() {
      _originalBytes = bytes;
      _imageBytes = bytes;
    });
  }

  Future<void> _updateTransformedImage() async {
    if (_originalBytes == null || _isTransforming) return;

    setState(() {
      _isTransforming = true;
    });

    final decoded = img.decodeImage(_originalBytes!);
    if (decoded == null) {
      setState(() {
        _isTransforming = false;
      });
      return;
    }

    img.Image current = decoded;

    if (_rotationTurns != 0) {
      final angle = (_rotationTurns % 4) * 90;
      if (angle != 0) {
        current = img.copyRotate(current, angle: angle);
      }
    }

    if (_flipX) {
      current = img.flipHorizontal(current);
    }
    if (_flipY) {
      current = img.flipVertical(current);
    }

    final updatedBytes = Uint8List.fromList(img.encodePng(current));

    setState(() {
      _imageBytes = updatedBytes;
      _isTransforming = false;
      _croppedPreview = null;
    });
  }

  void _setAspectRatio(double? ratio) {
    _cropController.aspectRatio = ratio;
    setState(() {
      _aspectRatio = ratio;
      _croppedPreview = null;
    });
  }

  void _rotateLeft() {
    _rotationTurns = (_rotationTurns - 1) % 4;
    if (_rotationTurns < 0) {
      _rotationTurns += 4;
    }
    _updateTransformedImage();
  }

  void _rotateRight() {
    _rotationTurns = (_rotationTurns + 1) % 4;
    _updateTransformedImage();
  }

  void _toggleFlipX() {
    setState(() {
      _flipX = !_flipX;
    });
    _updateTransformedImage();
  }

  void _toggleFlipY() {
    setState(() {
      _flipY = !_flipY;
    });
    _updateTransformedImage();
  }

  void _startCropping() {
    if (_imageBytes == null || _isCropping || _isTransforming) return;
    _showLoadingDialog();
    setState(() {
      _isCropping = true;
    });
    _cropController.crop();
  }

  void _showLoadingDialog() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _onPreviewPressed() {
    _shouldReturnResult = false;
    _startCropping();
  }

  void _onUsePressed() {
    _shouldReturnResult = true;
    _startCropping();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Crop Image'),
      body: _imageBytes == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      _buildAspectRatioSelector(),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Crop(
                            controller: _cropController,
                            image: _imageBytes!,
                            interactive: true,
                            aspectRatio: _aspectRatio,
                            radius: 16,
                            maskColor: Colors.black.withOpacity(0.4),
                            baseColor: Colors.black,
                            progressIndicator: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                            onCropped: (croppedImage) {
                              if (_isCropping) {
                                Get.back(); // Dismiss loading dialog
                              }
                              setState(() {
                                _isCropping = false;
                                _croppedPreview = croppedImage;
                              });
                              if (_shouldReturnResult) {
                                Get.back<Uint8List>(result: croppedImage);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_croppedPreview != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ).copyWith(bottom: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Preview',
                          type: AppTextType.heading2,
                          color: AppColors.white,
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          height: 20.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.w),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.memory(
                            _croppedPreview!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppElevatedButton(
                          button: AppButtonWidget(
                            text: 'Preview',
                            height: 6.h,
                            width: 100.w,
                            radius: 10.w,
                            onPressed: _isCropping || _isTransforming
                                ? null
                                : _onPreviewPressed,
                            buttonColor: AppColors.primary,
                            textColor: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: AppElevatedButton(
                          button: AppButtonWidget(
                            text: 'Done',
                            height: 6.h,
                            width: 100.w,
                            radius: 10.w,
                            onPressed: _isCropping || _isTransforming
                                ? null
                                : _onUsePressed,
                            buttonColor: AppColors.primary,
                            textColor: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildAspectRatioSelector() {
    final ratios = <String, double?>{
      'Free': null,
      '1:1': 1,
      '4:3': 4 / 3,
      '16:9': 16 / 9,
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ratios.entries.map((entry) {
          final isSelected = _aspectRatio == entry.value;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: GestureDetector(
                onTap: _isTransforming || _isCropping
                    ? null
                    : () => _setAspectRatio(entry.value),
                child: Container(
                  height: 4.5.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.borderColor,
                    ),
                  ),
                  child: AppText(
                    entry.key,
                    type: AppTextType.caption,
                    color: isSelected ? Colors.white : AppColors.black,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransformControls() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTransformButton(
            icon: Icons.rotate_left,
            label: 'Rotate Left',
            onTap: _isTransforming || _isCropping ? null : _rotateLeft,
          ),
          _buildTransformButton(
            icon: Icons.rotate_right,
            label: 'Rotate Right',
            onTap: _isTransforming || _isCropping ? null : _rotateRight,
          ),
          _buildTransformButton(
            icon: Icons.flip,
            label: 'Flip H',
            isActive: _flipX,
            onTap: _isTransforming || _isCropping ? null : _toggleFlipX,
          ),
          _buildTransformButton(
            icon: Icons.flip,
            label: 'Flip V',
            isActive: _flipY,
            onTap: _isTransforming || _isCropping ? null : _toggleFlipY,
          ),
        ],
      ),
    );
  }

  Widget _buildTransformButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool isActive = false,
  }) {
    final enabled = onTap != null;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            height: 4.5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: isActive ? AppColors.primary : Colors.transparent,
              border: Border.all(
                color: enabled ? AppColors.borderColor : Colors.grey,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: isActive ? Colors.white : AppColors.white,
                ),
                SizedBox(width: 1.w),
                Flexible(
                  child: AppText(
                    label,
                    type: AppTextType.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: isActive ? Colors.white : AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
