import 'package:flutter/material.dart';

class CountdownCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final String imagePath;

  const CountdownCard({
    super.key,
    required this.title,
    required this.description,
    this.onEdit,
    this.onDelete,
    this.imagePath = 'assets/imgs/retirement.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // properties
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      clipBehavior: Clip.antiAlias,
      // CONTENT 
      child: Stack(
        children: [
          // background image
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          Container(
            // text position
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // countdown 
                Center(
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // ACTION BUTTONS
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              children: [
                // [ edit ]
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: onEdit,
                  ),
                // [ delete ]
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: onDelete,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
