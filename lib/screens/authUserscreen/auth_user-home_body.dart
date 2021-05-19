import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.3,
          child: Stack(
            children: [
              Container(
                height: size.height * 20 - 27,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Welcome to ViziLog',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
