import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../configs/themes/colors.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.textController,
    this.suffix,
    this.onChanged,
    this.textInputType,
    this.textInputAction,
    this.textInputFormatters,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
  });

  final String title;
  final String hint;
  final String icon;
  final TextEditingController textController;

  final bool obscureText;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? textInputFormatters;

  final Widget? suffix;
  final ValueChanged<String>? onChanged;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.textController.addListener(_onTextChange);
    _hasText = widget.textController.text.isNotEmpty;
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  void _onTextChange() {
    final hasText = widget.textController.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.textController.removeListener(_onTextChange);
    _focusNode.dispose();
    super.dispose();
  }

  bool get _isActive => _isFocused || _hasText;

  Gradient get _iconGradient => _isActive
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: GradientRotation(134.57 * 3.14159 / 180),
          colors: [Color(0xFF5AB0FF), Color(0xFF0079FF)],
          stops: [-0.0076, 1.0],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: GradientRotation(134.57 * 3.14159 / 180),
          colors: [Color(0xFFF1F1F1), Color(0xFF797979)],
          stops: [-0.0076, 1.0],
        );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBorder),
          borderRadius: BorderRadius.circular(60),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                height: 22,
                width: 22,
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return _iconGradient.createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: SvgPicture.asset(widget.icon, fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 24),
              Container(width: 1, color: AppColors.greyBorder),
              SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 12,
                        color: AppColors.greyThinTitle,
                      ),
                    ),
                    TextFormField(
                      obscureText: widget.obscureText,
                      controller: widget.textController,
                      focusNode: _focusNode,
                      keyboardType: widget.textInputType,
                      textInputAction: widget.textInputAction,
                      inputFormatters: widget.textInputFormatters,
                      textCapitalization: widget.textCapitalization,
                      onChanged: widget.onChanged,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 12,
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: false,
                        hint: Text(
                          widget.hint,
                          style: textTheme.titleMedium?.copyWith(
                            fontSize: 12,
                            color: AppColors.greyThinSubTitle,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        prefixIconConstraints: BoxConstraints(),
                        suffixIconConstraints: BoxConstraints(),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.suffix != null) ...[
                SizedBox(width: 24),
                widget.suffix ?? SizedBox(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
