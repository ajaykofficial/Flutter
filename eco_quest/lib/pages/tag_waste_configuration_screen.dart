import 'package:eco_quest/pages/assign_waste_screen.dart';
import 'package:flutter/material.dart';

class Tag {
  final int id;
  String name;

  Tag({required this.id, required this.name});
}

class Waste {
  final int id;
  String name;
  String category;

  Waste({required this.id, required this.name, required this.category});
}

class TagWasteConfigurationScreen extends StatefulWidget {
  @override
  _TagWasteConfigurationScreenState createState() =>
      _TagWasteConfigurationScreenState();
}

class _TagWasteConfigurationScreenState
    extends State<TagWasteConfigurationScreen> {
  List<Tag> tags =
      List.generate(6, (index) => Tag(id: index, name: 'Tag ${index + 1}'));
  List<Waste> wastes = [
    Waste(id: 1, name: 'Waste 1', category: 'Category A'),
    Waste(id: 2, name: 'Waste 2', category: 'Category A'),
    Waste(id: 3, name: 'Waste 3', category: 'Category B'),
    Waste(id: 4, name: 'Waste 4', category: 'Category B'),
    Waste(id: 5, name: 'Waste 5', category: 'Category C'),
    Waste(id: 6, name: 'Waste 6', category: 'Category C'),
  ];

  // Map to store tag-waste connections
  Map<Tag, Waste> tagWasteMap = {};

  // Define a list of colors to be used for tags
  List<Color> tagColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tag-Waste Configuration',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor:
            Colors.blue.shade600, // Set the appbar background color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF64B5F6),
              Color(0xFF1976D2),
            ],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: tags.map((tag) {
                // Check if the tag is already assigned to a waste
                String wasteName = tagWasteMap.containsKey(tag)
                    ? tagWasteMap[tag]!.name
                    : 'Not assigned';
                return GestureDetector(
                  onTap: () {
                    // Navigate to assign waste screen
                    _navigateToAssignWaste(tag);
                  },
                  child: TagWidget(
                    tagName: tag.name,
                    wasteName: wasteName,
                    tagColor: tagColors[tag.id % tagColors.length],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // Method to navigate to assign waste screen
  void _navigateToAssignWaste(Tag tag) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignWasteScreen(
          tag: tag,
          wastes: wastes,
          tagWasteMap: tagWasteMap,
          onAssignWaste: (Waste? waste) {
            // Assign or deselect the selected waste to/from the tag
            setState(() {
              if (waste != null) {
                tagWasteMap[tag] = waste;
              } else {
                tagWasteMap.remove(tag);
              }
            });
          },
        ),
      ),
    );
  }
}

// Custom widget for displaying tags
class TagWidget extends StatelessWidget {
  final String tagName;
  final String wasteName;
  final Color tagColor;

  TagWidget({
    required this.tagName,
    required this.wasteName,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Set a fixed width for the tag
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tagName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Waste: $wasteName',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
