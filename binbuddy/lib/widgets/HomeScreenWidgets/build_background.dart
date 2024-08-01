import 'package:flutter/material.dart';

class BuildBackground extends StatelessWidget {
  const BuildBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/scbg.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
        Container(
          color: Colors.black.withOpacity(0.1),
        ),
      ],
    );
  }
}
