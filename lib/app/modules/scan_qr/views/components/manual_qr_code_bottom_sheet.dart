import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:nuca/app/utils/app_utils.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

class ManualQrCodeBottomSheet {
  final TextEditingController manualCodeController;
  final VoidCallback? onSubmit;

  ManualQrCodeBottomSheet({
    Key? key,
    required this.manualCodeController,
    this.onSubmit,
  });

  void show() {
    manualCodeController.clear();

    Get.bottomSheet(
      Padding(
        padding: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
          top: 3.h,
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 3.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Drag handle
            Center(
              child: Container(
                width: 12.w,
                height: 0.6.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            const AppTextWidget(
              text: 'Enter Barcode',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: manualCodeController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Enter code manually',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const AppTextWidget(
                      text: 'Cancel',
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _submitManualCode(),
                    child: const AppTextWidget(
                      text: 'Submit',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

  void _submitManualCode() {
    final code = manualCodeController.text.trim();

    if (code.isEmpty) {
      AppUtils.showMessage(
        'Please enter a valid barcode',
        isError: true,
        context: Get.context!,
      );
      return;
    }

    Get.back();
    onSubmit?.call();
    Get.toNamed(Routes.PRODUCT_DETAIL, arguments: {'code': code});
  }
}
