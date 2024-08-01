import 'package:flutter/material.dart';

class BuildBackgroundImage extends StatelessWidget {
  const BuildBackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/scbg.jpg',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
