import 'package:flutter/material.dart';

class AvatarCustomization extends StatefulWidget {
  const AvatarCustomization({Key? key}) : super(key: key);

  @override
  State<AvatarCustomization> createState() => _AvatarCustomizationState();
}

class _AvatarCustomizationState extends State<AvatarCustomization> {
  String selectedAvatar = 'assets/images/avatar-image1.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/avatar-customization_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFE5F5FC), Color(0xFFF0FAF9)],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Avatar Customization',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Norican-Regular',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 75,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.asset(
                    selectedAvatar,
                    width: 200,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 350,
              ),
              Center(
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Avatar rows
                      // You can extract this part into a separate widget for better readability and reusability
                      avatarRow([
                        'assets/images/avatar-image1.png',
                        'assets/images/avatar-image2.png',
                        'assets/images/avatar-image3.png',
                      ]),
                      avatarRow([
                        'assets/images/avatar-image4.png',
                        'assets/images/avatar-image5.png',
                        'assets/images/avatar-image6.png',
                      ]),
                      avatarRow([
                        'assets/images/avatar-image7.png',
                        'assets/images/avatar-image8.png',
                        'assets/images/avatar-image9.png',
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Widget for a row of avatars
  Widget avatarRow(List<String> avatars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: avatars.map((avatar) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedAvatar = avatar;
              });
            },
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orangeAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.asset(
                    avatar,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
