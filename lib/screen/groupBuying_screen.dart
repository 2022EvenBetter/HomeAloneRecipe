import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/widget/bottomBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:home_alone_recipe/models/post.dart';
import 'package:intl/intl.dart';

//TODO: 1. 상위 카테고리 DB에서 불러와서 보여주기
//TODO: 2. 상위 카테고리에 따른 하위 카테고리 고를 수 있도록 하기
//TODO: 3. 사용자가 입력한 form을 DB에 보내기
//TODO: 4. TextField 위젯에서 Controller의 역할 체크

class GroupBuying extends StatefulWidget {
  const GroupBuying({Key? key}) : super(key: key);

  @override
  State<GroupBuying> createState() => _GroupBuyingState();
}

class _GroupBuyingState extends State<GroupBuying> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final List<String> upperCategoryList = ['육류', '야채류', '곡류', '소스류', '유제품'];
  String selectedUpper = '육류';
  final List<String> lowerCategoryList = [
    '돼지고기',
    '닭고기',
    '쌀',
    '우유',
    '양상추',
    '굴소스'
  ];
  String selectedLower = '돼지고기';
  String? inputTitle = '';
  int _participantsCounter = 0;
  String? yearMonthDay; // 사용자가 입력한 날짜를 저장하기 위한 변수
  String? meetingTime; // 사용자가 입력한 시각을 저장하기 위한 변수
  TextEditingController ymdController =
      TextEditingController(); // 날짜 입력을 위한 Controller
  TextEditingController timeController =
      TextEditingController(); // 시간 입력을 위한 Controller

  // showDatePicker 위젯을 실행하는 함수
  yearMonthDayPicker() async {
    final year = DateTime.now().year;

    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year),
      lastDate: DateTime(year + 10),
    );
    if (dateTime != null) {
      ymdController.text = dateTime.toString().split(' ')[0];
    }
  }

  // showTimePicker 위젯을 실행하는 함수
  timePicker() async {
    String hour, min;
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: const TimeOfDay(hour: 0, minute: 0));
    if (pickedTime != null) {
      hour = pickedTime.hour.toString();
      min = pickedTime.minute.toString();

      timeController.text = '$hour:$min';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('글쓰기'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
          padding: const EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
          children: <Widget>[
            // 상위 카테고리  //
            const Text(
              '상위 카테고리',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton(
                value: selectedUpper, //초기값 설정
                items: upperCategoryList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedUpper = value!;
                  });
                }),
            const SizedBox(
              height: 20.0,
            ),

            // 하위 카테고리 //
            const Text(
              '하위 카테고리',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton(
                value: selectedLower,
                items: lowerCategoryList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLower = value!;
                  });
                }),
            const SizedBox(
              height: 20.0,
            ),

            // 제목 //
            const Text(
              '제목',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: '제목을 입력해주세요.',
                ),
                onChanged: (text) {}),
            const SizedBox(
              height: 20.0,
            ),

            // 내용 //
            const Text(
              '내용',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              height: 10 * 24.0,
              padding: const EdgeInsets.only(right: 15),
              child: TextField(
                maxLines: 10,
                decoration: const InputDecoration(
                    hintText: '내용을 입력해주세요.',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    )),
                onChanged: (text) {},
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            // 인원 //
            Row(
              children: <Widget>[
                const Text(
                  '인원',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    width: 50,
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        if(_participantsCounter != 0){
                          _participantsCounter--;
                        }
                      });
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '$_participantsCounter',
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _participantsCounter++;
                      });
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),

            // 날짜 //
            const Text(
              '날짜',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: yearMonthDayPicker,
              child: AbsorbPointer(
                //사용자의 임의 입력을 방지
                child: TextField(
                  controller: ymdController,
                  decoration: const InputDecoration(
                    labelText: '날짜를 선택해 주세요',
                  ),
                  onChanged: (val) {
                    yearMonthDay = ymdController.text;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),

            // 시간 //
            const Text(
              '시간',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: timePicker,
              child: AbsorbPointer(
                //사용자의 임의 입력을 방지
                child: TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    labelText: '시간를 선택해 주세요',
                  ),
                  onChanged: (val) {
                    meetingTime = timeController.text;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              '장소',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: '장소를 입력해주세요.',
                ),
                onChanged: (text) {}
            ),
            const SizedBox(
              height: 100.0,
            ),

            // TODO: 버튼 클릭 시 동작 설정하기
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: const Text(
                        '취소하기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                  ),
                ),
                const SizedBox(
                  width: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff686EFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text(
                        '작성하기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    ),
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
