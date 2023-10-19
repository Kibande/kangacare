import 'package:flutter/material.dart';
import '../const/colors.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required String hintText,
    required TextEditingController textController,
    hideText = false,
    EdgeInsets padding = const EdgeInsets.only(left: 40),
  })  : _hintText = hintText,
        _padding = padding,
        _textController = textController,
        _hideText = hideText;

  final bool _hideText;
  final String _hintText;
  final EdgeInsets _padding;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: StadiumBorder(),
      ),
      child: TextField(
        controller: _textController,
        obscureText: _hideText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          contentPadding: _padding,
        ),
      ),
    );
  }
}
