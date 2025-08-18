import 'package:flutter/cupertino.dart';

class WidgetButtom extends StatelessWidget{
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? size;
  dynamic? FontWeight;
  WidgetButtom({
    Key? key,
    this.FontWeight,
    required this.title,
    required this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.height, this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],  
      ),
      child: CupertinoButton(
        color: color ?? CupertinoColors.activeBlue,
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? CupertinoColors.white,
            fontSize: size ?? 16.0,
            fontWeight: FontWeight,
          ),
        ),
      ),
    );
  }
}