import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    this.onTap,
    this.label,
    this.style,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.labelText,
    this.showCursor,
    this.suffixIcon,
    this.maxLines = 1,
    this.textInputAction,
    required this.hintText,
    required this.readOnly,
    required this.boxWidth,
    required this.textAlign,
    required this.textColor,
    this.obscureText = false,
    required this.textEditingController,
    this.keyboardType = TextInputType.name,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
  });
  int maxLines;
  bool readOnly;
  Widget? label;
  Widget? prefix;
  Widget? suffix;
  int? maxLength;
  TextStyle? style;
  String? labelText;
  bool? obscureText;
  Widget? suffixIcon;
  FocusNode? focusNode;
  final String hintText;
  final double boxWidth;
  final Color textColor;
  void Function()? onTap;
  bool? showCursor = true;
  EdgeInsets? scrollPadding;
  Function(String)? onChanged;
  final TextInputType keyboardType;
  TextInputAction? textInputAction;
  TextAlign textAlign = TextAlign.left;
  String? Function(String?)? validator;
  TextCapitalization textCapitalization;
  final TextEditingController textEditingController;
  Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: TextFormField(
        autofocus: true,
        onFieldSubmitted: onFieldSubmitted,
        cursorHeight: 20,
        onTap: onTap,
        readOnly: readOnly,
        cursorColor: 
        KColors().kBlack,
        maxLength: maxLength,
        textAlign: textAlign,
        validator: validator,
        onChanged: onChanged,
        showCursor: showCursor,
        obscuringCharacter: '*',
        obscureText: obscureText!,
        keyboardType: keyboardType,
        scrollPadding: scrollPadding!,
        textInputAction: textInputAction,
        controller: textEditingController,
        enableInteractiveSelection: true,
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        style: GoogleFonts.manrope(
            fontSize: 16.sp, color: textColor, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          prefix: prefix,
          focusColor: KColors().kBlack,
          hintText: hintText,
          labelText: labelText,
          suffix: suffix,
          suffixIcon: suffixIcon,
          border:  OutlineInputBorder(
              borderSide: BorderSide(color: KColors().kGrey)),
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: KColors().kGrey)),
          focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color:  KColors().kGrey)),
          hintStyle: GoogleFonts.manrope(
              color: KColors().kGrey, fontSize: 14.sp, fontWeight: FontWeight.w400),
          labelStyle: GoogleFonts.manrope(
              color: KColors().kBlack, fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
