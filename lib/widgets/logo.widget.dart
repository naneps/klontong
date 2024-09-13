import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final int fontSize;
  const LogoWidget({
    super.key,
    this.fontSize = 34,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: 'Klon',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: fontSize.toDouble(),
              ),
          children: [
            TextSpan(
              text: 'Tong',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: fontSize.toDouble(),
                  ),
            ),
          ]),
    );
  }
}
