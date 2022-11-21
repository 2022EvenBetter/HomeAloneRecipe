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
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  '카테고리를 선택하세요',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (v) {
            setState(() {
              print(v);
              selectedValue = v as String;
              if (v == "채소류") {
                widget.setVisible(1);
              } else if (v == "육류") {
                widget.setVisible(0);
              }
            });
          },
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
          buttonHeight: 30,
          buttonWidth: 200,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.yellow,
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 240,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    );
  }
}
