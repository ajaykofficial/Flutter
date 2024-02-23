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
      appBar: AppBar(
        title: const Text(
          'Avatar Customization',
          style: TextStyle(
            fontFamily: 'Norican-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/avatar-customization_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 70,
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
                height: 300,
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
