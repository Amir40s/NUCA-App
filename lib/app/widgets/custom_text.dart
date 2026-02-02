// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import '../utils/export.dart';

// class CustomText extends StatelessWidget {
//   final String text;
//   final TextAlign? textAlign;
//   final int? maxLines;
//   final TextOverflow? overflow;
//   final Color? color;
//   final double? fontSize;
//   final FontWeight? fontWeight;

//   const CustomText({
//     super.key,
//     required this.text,
//     this.textAlign,
//     this.maxLines,
//     this.overflow,
//     this.color,
//     this.fontSize,
//     this.fontWeight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: GoogleFonts.poppins(
//         color: color ?? AppColors.textPrimary,
//         fontSize: (fontSize ?? 18),
//         fontWeight: fontWeight ?? FontWeight.w400,
//       ),
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//     );
//   }
// }

// class AppTextWidget extends StatelessWidget {
//   final String text;
//   final double? fontSize;
//   final EdgeInsetsGeometry? padding;
//   final int? maxLines;
//   final FontWeight fontWeight;
//   final TextOverflow overflow;
//   final TextAlign textAlign;
//   final bool softWrap;
//   final Color? color;
//   final double height;
//   final Color? underLineColor;
//   final TextDecoration textDecoration;
//   final List<Shadow>? shadows;

//   const AppTextWidget({
//     super.key,
//     required this.text,
//     this.fontWeight = FontWeight.normal,
//     this.color,
//     this.textAlign = TextAlign.center,
//     this.textDecoration = TextDecoration.none,
//     this.fontSize,
//     this.softWrap = true,
//     this.maxLines,
//     this.underLineColor,
//     this.overflow = TextOverflow.clip,
//     this.shadows,
//     this.padding,
//     this.height = 1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding ?? EdgeInsets.zero,
//       child: Text(
//         text,
//         textAlign: textAlign,
//         softWrap: softWrap,
//         maxLines: maxLines,
//         overflow: overflow,
//         style: TextStyle(
//           shadows: shadows,
//           decoration: textDecoration,
//           decorationColor: underLineColor ?? AppColors.black,
//           fontWeight: fontWeight,
//           height: height,
//           fontSize: fontSize?.sp ?? 16.sp,
//           color: color ?? AppColors.black,
//         ),
//       ),
//     );
//   }
// }
