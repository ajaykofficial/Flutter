import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback onTap;

  const PlayerTile({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.7),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueGrey.withOpacity(0.6),
          backgroundImage: AssetImage(imagePath),
        ),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
