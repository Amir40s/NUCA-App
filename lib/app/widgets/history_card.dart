import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../features/history/history_model.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class HistoryCard extends StatelessWidget {
  final HistoryModel item;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback? onPlayTap;

  const HistoryCard({
    super.key,
    required this.item,
    this.isPlaying = false,
    this.isLoading = false,
    this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    final isVoiceType = item.type == HistoryType.textToVoice;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.black.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Type Icon and Time
          Row(
            children: [
              Icon(
                _getTypeIcon(item.type),
                size: 16,
                color: AppColors.grey,
              ),
              const SizedBox(width: 8),
              AppTextWidget(
                text: _getTypeLabel(item.type),
                color: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
              ),
              const Spacer(),
              AppTextWidget(
                text: item.time,
                color: AppColors.grey,
                fontSize: 12,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Content
          AppTextWidget(
            text: item.content,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            color: AppColors.black.withValues(alpha: 0.8),
            fontSize: 14,
            height: 1.5,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          // Action Area
          if (isVoiceType)
            _buildPlayer()
          else
            _buildActionButtons(),

          // Footer info (Voice Name for TTS)
          if (isVoiceType && item.voiceName.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.record_voice_over, size: 14, color: AppColors.grey),
                const SizedBox(width: 4),
                Flexible(
                  child: AppTextWidget(
                    text: item.voiceName,
                    color: AppColors.grey,
                    fontSize: 12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayer() {
    return GestureDetector(
      onTap: onPlayTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 24,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: isLoading
                        ? "Loading..."
                        : isPlaying
                            ? "Playing..."
                            : "Play Audio",
                    color: AppColors.black.withValues(alpha: 0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  if (isPlaying || isLoading) ...[
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: isLoading ? null : 0.5, // Dummy progress
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.secondary,
                        ),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: item.content));
            Get.snackbar("Success", "Copied to clipboard", snackPosition: SnackPosition.BOTTOM);
          },
          icon: const Icon(Icons.copy, size: 16),
          label: AppTextWidget(text: "Copy Text", fontSize: 14, textAlign: TextAlign.center),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.secondary,
            side: const BorderSide(color: AppColors.secondary),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  IconData _getTypeIcon(HistoryType type) {
    switch (type) {
      case HistoryType.textToVoice:
        return Icons.record_voice_over;
      case HistoryType.speechToText:
        return Icons.mic;
      case HistoryType.ocr:
        return Icons.camera_alt;
      case HistoryType.uploadFiles:
        return Icons.upload_file;
    }
  }

  String _getTypeLabel(HistoryType type) {
    switch (type) {
      case HistoryType.textToVoice:
        return "Text to Voice";
      case HistoryType.speechToText:
        return "Speech to Text";
      case HistoryType.ocr:
        return "OCR";
      case HistoryType.uploadFiles:
        return "File Upload";
    }
  }
}
