import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;

  const InputTextField({Key key, this.labelText, this.controller})
      : super(key: key);
  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: TextFormField(
        keyboardType: widget.labelText == "Pincode"
            ? TextInputType.numberWithOptions()
            : widget.labelText == "Address"
                ? TextInputType.multiline
                : TextInputType.text,
        obscureText: widget.labelText == "Password" ? isObsecure : false,
        validator: widget.labelText == "Email"
            ? (val) => val.isEmpty ? 'Enter an email' : null
            : (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
        decoration: InputDecoration(
          suffixIcon: widget.labelText == "Password"
              ? IconButton(
                  icon: isObsecure
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isObsecure = !isObsecure;
                    });
                  },
                )
              : SizedBox(),
          fillColor: Colors.grey,
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(16),
            borderSide: new BorderSide(),
          ),
        ),
        controller: widget.controller,
      ),
    );
  }
}
