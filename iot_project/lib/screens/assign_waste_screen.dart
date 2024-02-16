import 'package:flutter/material.dart';
import 'package:iot_project/screens/tag_waste_configuration_screen.dart';

class AssignWasteScreen extends StatefulWidget {
  final Tag tag;
  final List<Waste> wastes;
  final Map<Tag, Waste> tagWasteMap;
  final Function(Waste?) onAssignWaste; // Allow null to deselect waste

  AssignWasteScreen({
    required this.tag,
    required this.wastes,
    required this.tagWasteMap,
    required this.onAssignWaste,
  });

  @override
  _AssignWasteScreenState createState() => _AssignWasteScreenState();
}

class _AssignWasteScreenState extends State<AssignWasteScreen> {
  Waste? selectedWaste;
  List<Color> tagColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();
    // Check if the waste is already assigned to the current tag
    selectedWaste = widget.tagWasteMap[widget.tag];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Waste to ${widget.tag.name}'),
      ),
      body: ListView.builder(
        itemCount: widget.wastes.length,
        itemBuilder: (context, index) {
          final waste = widget.wastes[index];
          // Check if the current waste is already assigned to another tag
          final isAssignedToOtherTag = widget.tagWasteMap.values
              .any((assignedWaste) => assignedWaste == waste);
          final isSelected = selectedWaste == waste;
          final tagColor = tagColors[widget.tag.id % tagColors.length];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isAssignedToOtherTag) {
                    // Show a dialog or a toast indicating that the waste is already assigned to another tag
                    return;
                  }
                  // Update the selected waste only if it's different from the current one
                  if (selectedWaste != waste) {
                    selectedWaste = waste;
                  }
                });
              },
              onDoubleTap: () {
                setState(() {
                  selectedWaste = null; // Deselect on double tap
                });
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: isSelected ? tagColor : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            waste.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: isSelected ? Colors.white : null,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            waste.category,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.onAssignWaste(selectedWaste);
          Navigator.pop(context);
        },
        label: Text('Confirm'),
        icon: Icon(Icons.done),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
