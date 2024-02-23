import 'package:flutter/material.dart';

class ReaderTagConfigurationScreen extends StatefulWidget {
  @override
  _ReaderTagConfigurationScreenState createState() =>
      _ReaderTagConfigurationScreenState();
}

class _ReaderTagConfigurationScreenState
    extends State<ReaderTagConfigurationScreen> {
  List<List<int>> assignedTags = List.generate(3, (index) => []);
  List<Color> readerColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reader-Tag Configuration',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 122, 235, 255),
              Color.fromARGB(255, 132, 255, 181),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  children: List.generate(
                    6,
                    (index) => TagCard(
                      tagNumber: index + 1,
                      onTap: () {
                        _toggleTagSelection(index + 1);
                      },
                      onDoubleTap: () {
                        _deselectTag(index + 1);
                      },
                      color: assignedTags
                              .any((tags) => tags.contains(index + 1))
                          ? readerColors[assignedTags
                              .indexWhere((tags) => tags.contains(index + 1))]
                          : Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                        children: List.generate(
                          3,
                          (index) => ReaderCard(
                            readerNumber: index + 1,
                            assignedTags: assignedTags[index],
                            onTap: () {
                              _removeAssignedTag(index);
                            },
                            color: readerColors[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleTagSelection(int tagNumber) {
    for (int i = 0; i < assignedTags.length; i++) {
      if (assignedTags[i].contains(tagNumber)) {
        _removeAssignedTagFromReader(tagNumber, i);
        return;
      }
    }
    _showTagSelectionBottomSheet(context, tagNumber);
  }

  void _deselectTag(int tagNumber) {
    for (int i = 0; i < assignedTags.length; i++) {
      if (assignedTags[i].contains(tagNumber)) {
        setState(() {
          assignedTags[i].remove(tagNumber);
        });
        return;
      }
    }
  }

  void _showTagSelectionBottomSheet(BuildContext context, int tagNumber) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Reader',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: assignedTags.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _assignTagToReader(tagNumber, index);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: readerColors[index],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reader ${index + 1}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: assignedTags[index].contains(tagNumber)
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _assignTagToReader(int tagNumber, int readerIndex) {
    for (int i = 0; i < assignedTags.length; i++) {
      if (i != readerIndex && assignedTags[i].contains(tagNumber)) {
        assignedTags[i].remove(tagNumber);
      }
    }
    setState(() {
      assignedTags[readerIndex].add(tagNumber);
    });
  }

  void _removeAssignedTag(int readerIndex) {
    setState(() {
      assignedTags[readerIndex].clear();
    });
  }

  void _removeAssignedTagFromReader(int tagNumber, int readerIndex) {
    setState(() {
      assignedTags[readerIndex].remove(tagNumber);
    });
  }
}

class TagCard extends StatelessWidget {
  final int tagNumber;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final Color color;

  const TagCard({
    required this.tagNumber,
    required this.onTap,
    required this.onDoubleTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Tag $tagNumber',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ReaderCard extends StatelessWidget {
  final int readerNumber;
  final List<int> assignedTags;
  final VoidCallback onTap;
  final Color color;

  const ReaderCard({
    required this.readerNumber,
    required this.assignedTags,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reader $readerNumber',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: IntrinsicHeight(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: assignedTags
                        .map((tag) => Chip(
                              backgroundColor: Colors.white,
                              label: Text(
                                'Tag $tag',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
