import 'package:flutter/material.dart';
import '../data/header_items.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key, required this.onSectionSelected})
      : super(key: key);
  final Future<void> Function(int index) onSectionSelected;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
          child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    headerItems[index].title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    final targetIndex = headerItems[index].index;
                    Navigator.of(context).pop();
                    await Future<void>.delayed(
                      const Duration(milliseconds: 250),
                    );
                    await onSectionSelected(targetIndex);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: headerItems.length)),
    );
  }
}
