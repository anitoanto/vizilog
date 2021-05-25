import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;

  const CustomButton({Key key, this.onPressed, this.child}) : super(key: key);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  
  Color buttonColor = Color(0xff233975);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 16,
      width: width,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: widget.child,
        style: ElevatedButton.styleFrom(primary: buttonColor),
      ),
    );
  }
}
