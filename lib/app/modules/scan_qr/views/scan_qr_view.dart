import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nuca/app/modules/scan_qr/views/components/scan_overlay.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:nuca/app/utils/app_utils.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

import '../controllers/scan_qr_controller.dart';

class ScanQrView extends GetView<ScanQrController> {
  const ScanQrView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.scannerController,
            onDetect: (barcodeCapture) {
              final String? code = barcodeCapture.barcodes.first.rawValue;
              if (code != null) {
                controller.onBarcodeDetected(code);
              }
            },
          ),
          ScanOverlay(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppUtils.HorizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: 'Scan QR Code',
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          Gap(0.5.h),
                          AppTextWidget(
                            text: 'Point your camera at a QR code',
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.all(1.2.h),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => _circleButton(
                          icon: controller.isFlashOn.value
                              ? Icons.flash_off
                              : Icons.flash_on,
                          image: Assets.icons.light,
                          onTap: controller.toggleTorch,
                        ),
                      ),
                      _circleButton(
                        icon: Icons.flip_camera_ios,
                        image: Assets.icons.cameraSwitch,
                        onTap: controller.switchCamera,
                      ),
                    ],
                  ),
                  Gap(3.h),
                  Center(
                    child: GestureDetector(
                      onTap: controller.showManualEntry,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.midGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.icons.keyboard),
                            Gap(2.w),
                            AppTextWidget(
                              text: 'Enter Barcode Manually',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    IconData? icon,
    String? image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 6.h,
        height: 6.h,
        decoration: BoxDecoration(
          color: AppColors.midGrey,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: image != null && image.isNotEmpty
              ? SvgPicture.asset(
                  image,
                  width: 3.h,
                  height: 3.h,
                  fit: BoxFit.contain,
                )
              : Icon(icon, size: 3.h),
        ),
      ),
    );
  }
}
