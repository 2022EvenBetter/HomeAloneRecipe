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
        padding: EdgeInsets.only(left: 10.0, top: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:15,),
              child: Text(
                widget.categoryName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,),
              ),
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
