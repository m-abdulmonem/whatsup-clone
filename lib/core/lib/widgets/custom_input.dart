import '../services/themes/theme_services.dart';
import 'package:flutter/material.dart';
import '../util/constant.dart';

class CustomInput extends StatefulWidget {
  final String? hint, label;
  final Color? color, hintColor, labelColor, prefixIconColor;
  final bool? obscureText, autofocus;
  final TextStyle? labelStyle, hintStyle, style;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final void Function(String?)? onSave, onChange;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final double? radius;

  const CustomInput(
      {Key? key,
      this.hint,
      this.label,
      this.color,
      this.hintColor,
      this.labelColor,
      this.prefixIconColor,
      this.obscureText,
      this.autofocus,
      this.labelStyle,
      this.hintStyle,
      this.style,
      this.controller,
      this.textInputAction,
      this.inputType,
      this.onSave,
      this.validator,
      this.prefixIcon,
      this.radius,
      this.onChange})
      : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<CustomInput> {
  final focusColor = ThemeService().isDarkMode
      ? Colors.white
      : const Color(0xff000000).withOpacity(0.5);
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) =>
          setState(() => hasFocus ? focusColor : widget.color),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        textInputAction: widget.textInputAction ?? TextInputAction.none,
        keyboardType: widget.inputType ?? TextInputType.text,
        style: widget.style ?? const TextStyle(),
        obscureText: widget.obscureText ?? false,
        onSaved: widget.onSave,
        onChanged: widget.onChange,
        validator: widget.validator,
        autofocus: widget.autofocus ?? false,
        decoration: InputDecoration(
            focusColor: focusColor,
            focusedBorder: focusedBorder,
            border: inputBorder,
            enabledBorder: inputBorder,
            errorBorder: errorInputBorder,
            labelText: widget.label,
            errorStyle: const TextStyle(color: colorError, fontSize: 15),
            labelStyle: widget.labelStyle ??
                TextStyle(
                  fontSize: 18,
                  color: _focusNode!.hasFocus ? focusColor : widget.labelColor,
                ),
            hintText: widget.hint,
            hintStyle: widget.hintStyle ??
                TextStyle(
                    color:
                        _focusNode!.hasFocus ? focusColor : widget.hintColor)),
      ),
    );
  }

  FocusNode? _focusNode;

  late OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black12),
      borderRadius: BorderRadius.circular(50));

  late OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: colorPrimary),
      borderRadius: BorderRadius.circular(50));

  late OutlineInputBorder errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: const BorderSide(
      color: colorError,
      width: 2.0,
    ),
  );

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }
}
