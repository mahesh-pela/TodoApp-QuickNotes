import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todoscreen extends StatefulWidget {
  @override
  State<Todoscreen> createState() => _TodoscreenState();
}

class _TodoscreenState extends State<Todoscreen> {
  var current_date_time = DateTime.now();
  OverlayEntry? _popupMenuOverlay;

  void _onMenuItemSelected(String value) {
    switch (value) {
      case 'save':
      // Handle save action
        break;
      case 'reminder':
      // Handle reminder action
        break;
      case 'delete':
      // Handle delete action
        break;
    }
    _popupMenuOverlay?.remove();
  }

  void _showPopupMenu(BuildContext context) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    _popupMenuOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dim the background
          GestureDetector(
            onTap: () {
              _popupMenuOverlay?.remove();
            },
            //dim main screen
            child: Container(
              color: Colors.black54,
            ),
          ),
          // Popup menu
          Positioned(
            right: 20,
            top: AppBar().preferredSize.height + 30,
            child: Material(
              color: Colors.transparent, // Make the Material widget transparent
              child: Container(
                width: 150,
                padding: EdgeInsets.all(8.0), // Add padding here
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white, // Background color for the container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _onMenuItemSelected('reminder'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Reminder', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onMenuItemSelected('save'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onMenuItemSelected('delete'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Delete', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_popupMenuOverlay!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showPopupMenu(context),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // Title
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '${current_date_time.day}/${current_date_time.month}/${current_date_time.year} ${current_date_time.hour}:${current_date_time.minute}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
