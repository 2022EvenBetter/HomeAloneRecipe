import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CategoryDropdown extends StatefulWidget {
  final Function setVisible;

  const CategoryDropdown(this.setVisible, {super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final List<String> items = [
    '육류',
    '채소류',
    '해산물',
    '햄소시지',
    '가공유제품',
    '과일',
    '곡류',
    '면',
    '빵떡',
    '콩견과류',
    '조미료양념',
  ];

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryButton("육류", widget.setVisible, 0),
          CategoryButton("채소류", widget.setVisible, 1),
          CategoryButton("해산물", widget.setVisible, 2),
          CategoryButton("햄/소시지", widget.setVisible, 3),
          CategoryButton("가공/유제품", widget.setVisible, 4),
          CategoryButton("과일", widget.setVisible, 5),
          CategoryButton("곡류", widget.setVisible, 6),
          CategoryButton("면", widget.setVisible, 7),
          CategoryButton("빵/떡", widget.setVisible, 8),
          CategoryButton("콩/견과류", widget.setVisible, 9),
          CategoryButton("조미료/양념", widget.setVisible, 10),
        ],
      ),
    );
  }
}

class CategoryButton extends StatefulWidget {
  final String buttonName;
  final Function setVisible;
  final int index;
  const CategoryButton(this.buttonName, this.setVisible, this.index,
      {super.key});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
      child: OutlinedButton(
        onPressed: () {
          widget.setVisible(widget.index);
        },
        child: Text(widget.buttonName),
        style: OutlinedButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.black),
      ),
    );
  }
}
