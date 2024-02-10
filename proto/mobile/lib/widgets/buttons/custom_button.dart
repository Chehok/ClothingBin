import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? textColor;
  final Color? buttonColor;
  final Widget? buttonImage;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  CustomButton({
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
      child: Row( // 이미지와 텍스트를 가로로 배치하기 위해 Row 위젯 사용
        children: [
          buttonImage ?? Container(),
          SizedBox(width: 10), // 이미지와 텍스트 사이의 간격 조정
          Text(
            buttonText,
            style: TextStyle(
              color: textColor,
              fontSize: 30,
            ),
          ),
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
