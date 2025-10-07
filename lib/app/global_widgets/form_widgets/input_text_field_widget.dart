import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../shared/ui_helpers.dart';


class InputTextFieldWidget extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String keyName;
  final TextInputType? textInputType;
  final bool isNumeric;
  final bool isUrl;
  final bool enabled;
  final bool isEmail,isIdNumber;
  final bool isRequired;
  final bool isFill;
  final Function(String)? onChange;
  final int? maxLength;
  final int? minLength;
  final int? minLine;
  final int? maxLines;
  final bool? autoFocus;
  final bool? obscureText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;
  final Color? fillColor;

  final BorderSide? borderSide;
  final bool enableInteractiveSelection,showTitle;
  final FormFieldValidator? validator;

  const InputTextFieldWidget({
    Key? key,
    this.hintText,
    this.labelText,
    this.enabled = true,
    required this.keyName,this.showTitle=false,
    this.textInputType,
    this.initialValue = '',
    this.isEmail = false,this.isIdNumber=false,
    this.isNumeric = false,
    this.isRequired = true,
    this.isUrl = false,
    this.minLine,
    this.autoFocus = false,
    this.prefixIcon,
    this.style,
    this.onChange,
    this.inputBorder,
    this.suffixIcon,
    this.maxLength,
    this.inputFormatters,
    this.maxLines,
    this.fillColor,
    this.isFill = true,
    this.contentPadding = const EdgeInsets.all(16),
    this.borderSide,
    this.obscureText = false,
    this.minLength,
    this.validator,
    this.enableInteractiveSelection = true,
  }) : super(key: key);

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  late String text;
  bool isRTL = false;

  @override
  void initState() {
    super.initState();
    text = widget.hintText ?? widget.labelText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.showTitle)
        Text(widget.labelText.toString().capitalize ??'' ,style: AppStyles.primaryStyle(color: AppColors.primaryColorGreen),),
        UiHelper.verticalSpaceTiny,
        FormBuilderTextField(
          name: widget.keyName,
          style: widget.style ?? TextStyle(),
          minLines: widget.minLine,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          obscureText: widget.obscureText!,
          initialValue: widget.initialValue,




          autofocus: widget.autoFocus!,
          textAlignVertical: TextAlignVertical.center,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          decoration: InputDecoration(
            contentPadding: widget.contentPadding,
            hintText: widget.hintText,
            labelText: widget.hintText,

            hintMaxLines: 2,
            hintStyle:TextStyle(),
            alignLabelWithHint: false,
            fillColor: widget.fillColor,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            errorStyle: AppStyles.primaryStyle(fontSize: 11,color: AppColors.red),
            filled: widget.isFill,
            isDense: true,
            border: widget.inputBorder,
            enabledBorder: widget.inputBorder,
            focusedBorder: widget.inputBorder,
          ),
          inputFormatters: widget.inputFormatters ?? getEmailInputFormatter(),
          onReset: () {
            setState(() {
              text = widget.labelText ?? widget.hintText ?? '';
            });
          },
          validator: FormBuilderValidators.compose([
            if (widget.isRequired) FormBuilderValidators.required(),
            if (widget.isEmail) FormBuilderValidators.email(),
            if (widget.isEmail) FormBuilderValidators.password(),
            // if (widget.isIdNumber) FormBuilderValidators.match(r'^[12][0-9]*$'),
            if (widget.isNumeric) FormBuilderValidators.numeric(),
            if (widget.isUrl) FormBuilderValidators.url(),
            if (widget.minLength != null)
              FormBuilderValidators.minLength(
                widget.minLength!,
              ),
            if (widget.validator != null) widget.validator!,
          ]),
          keyboardType: getKeyboardType(),

          onChanged: (str) {
            if (!mounted) return;
            setState(() {
              text = str!;
            });
            if (widget.onChange != null) {
              widget.onChange!.call(str!);
            }
          },
        ),
      ],
    );
  }

  TextInputType? getKeyboardType() {
    if (widget.textInputType != null) {
      return widget.textInputType;
    } else if (widget.isNumeric) {
      return TextInputType.number;
    } else {
      return (widget.minLine != null && widget.minLine! >= 7)
          ? TextInputType.multiline
          : TextInputType.text;
    }
  }

  List<TextInputFormatter>? getEmailInputFormatter() {
    return widget.isEmail
        ? [
            FilteringTextInputFormatter.deny(
              RegExp('[ ]'),
            )
          ]
        : null;
  }
}

// class ForFieldImagePicker extends StatelessWidget {
//   final String? hintText;
//   final String? labelText;
//   final String keyName;
//   final bool isRequired;
//   final bool isFill;
//   final Function(List<dynamic>?)? onChange;
//   final int? maxLength;
//   final int? minLength;
//
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final Color? fillColor;
//   final TextStyle? style;
//   final EdgeInsetsGeometry? contentPadding;
//   final InputBorder? inputBorder;
//   final BorderSide? borderSide;
//
//   const ForFieldImagePicker({
//     Key? key,
//     this.hintText,
//     this.labelText,
//     required this.keyName,
//     this.isRequired = true,
//     this.prefixIcon,
//     this.style,
//     this.onChange,
//     this.inputBorder,
//     this.suffixIcon,
//     this.maxLength,
//     this.fillColor,
//     this.isFill = AppInputDecorationStyle.isFill,
//     this.contentPadding = AppInputDecorationStyle.inputFromWidgetPadding,
//     this.borderSide,
//     this.minLength = 3,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderImagePicker(
//       name: keyName,
//       onChanged: onChange,
//       decoration: InputDecoration(
//         // labelText: widget.labelText,
//         contentPadding: contentPadding,
//         hintText: hintText,
//         hintStyle: AppInputDecorationStyle.hintStyle,
//         alignLabelWithHint: true,
//         fillColor: fillColor,
//         filled: isFill,
//         suffixIcon: suffixIcon,
//         prefixIcon: prefixIcon,
//         isDense: true,
//         border: inputBorder,
//       ),
//       validator: FormBuilderValidators.compose([
//         if (isRequired) FormBuilderValidators.required(),
//         if (minLength != null)
//           FormBuilderValidators.minLength(
//             minLength!,
//           ),
//       ]),
//       iconColor: Theme.of(context).colorScheme.primary,
//       displayCustomType: (file) {
//         return Card(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Icon(Icons.image),
//           ),
//         );
//
//         // return Image.file(
//         //   file,
//         //   fit: BoxFit.cover,
//         // );
//       },
//       maxImages: maxLength,
//       // displayCustomType: ,
//     );
//   }
// }
