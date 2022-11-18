import 'package:flutter/material.dart';

class CategoryContainer extends StatefulWidget {
  final Function() isVisible;
  final bool visibility;
  final String categoryName;
  const CategoryContainer(this.categoryName, this.isVisible, this.visibility,
      {super.key});

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Text(
              widget.categoryName,
              style: TextStyle(fontSize: 20.0),
            ),
            IconButton(
                onPressed: () {
                  widget.isVisible();
                },
                icon: widget.visibility
                    ? Icon(Icons.arrow_upward)
                    : Icon(Icons.arrow_downward)),
          ],
        ));
  }
}
