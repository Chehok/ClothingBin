import 'package:flutter/material.dart';

class AroundButton extends StatelessWidget {
  final String buttonText;
  final Color? textColor;
  final Color? buttonColor;
  final Widget? buttonImage;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  AroundButton({
    required this.buttonText,
    this.textColor,
    this.buttonColor,
    this.buttonImage,
    this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: TextStyle(color: textColor, fontSize: 30),
          ),
          SizedBox(
            width: 80,
          ),
          buttonImage ?? Container(),
          SizedBox(width: 10),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          buttonColor ?? Theme.of(context).accentColor,
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(width ?? 88.0, height ?? 36.0),
        ),
      ),
    );
  }
}
