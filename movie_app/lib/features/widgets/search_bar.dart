import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function()? onClear;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Film ara...',
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[400]
                      : Colors.grey[600],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey[600],
              ),
              onPressed: onClear,
            ),
        ],
      ),
    );
  }
}
