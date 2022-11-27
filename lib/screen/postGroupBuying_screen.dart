import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/screen/home_screen.dart';
import 'package:home_alone_recipe/models/post.dart';
import 'package:home_alone_recipe/screen/showGroupBuying_screen.dart';
import 'package:provider/provider.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/constants/category.dart';

class GroupBuying extends StatefulWidget {
  const GroupBuying({Key? key}) : super(key: key);

  @override
  State<GroupBuying> createState() => _GroupBuyingState();
}

class _GroupBuyingState extends State<GroupBuying> {
  List<String> lowerCategoryList = [];
  String? selectedUpper;
  String? selectedLower;
  late UserProvider _userProvider;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  Post post = Post(); //Post 클래스의 인스턴스 생성
  int participantsCounter = 0;

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

  void _tryValidation() {
    //validation이 유효한지
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
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

  void showPopup(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("해당 게시글을 등록하시겠습니까?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 110,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                _tryValidation();
                                try {
                                  if (post.content != null &&
                                      post.date != null &&
                                      post.upperCategory != null &&
                                      post.lowerCategory != null &&
                                      post.maxParticipants != null &&
                                      post.meetingPlace != null &&
                                      post.time != null &&
                                      post.title != null) {
                                    await FirebaseFirestore.instance
                                        .collection("Post")
                                        .add({
                                      "Uid": _userProvider.uid,
                                      "WriterName": _userProvider.nickname,
                                      "UserLocation": _userProvider.locations,
                                      "Content": post.content!,
                                      "Date": post.date!,
                                      "UpperCategory": post.upperCategory!,
                                      "LowerCategory": post.lowerCategory!,
                                      "maxParticipants": post.maxParticipants!,
                                      "curParticipants": 0,
                                      "Place": post.meetingPlace!,
                                      "Time": post.time!,
                                      "Title": post.title!,
                                    });

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return showGroupBuying();
                                      }),
                                    );
                                  } else {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('모든 값이 입력되어야 합니다!'),
                                        backgroundColor: Colors.blue,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              icon: const Icon(Icons.circle_outlined),
                              label: const Text('네'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff686EFF),
                                onPrimary: Colors.white, // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                              label: const Text('아니요'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff686EFF),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ), // Background color
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    ymdController.addListener(setYmd);
    timeController.addListener(setTime);
  }

  void setYmd() {
    post.date = ymdController.text;
    print("set date");
    print(post.date);
  }

  void setTime() {
    post.time = timeController.text;
    print("set time");
    print(post.time);
  }

  // myController의 텍스트를 콘솔에 출력하는 메소드
  void _printLatestValue() {
    print("${ymdController.text},${timeController.text}");
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              '글쓰기',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
            elevation: 3.0,
            backgroundColor: Colors.white, //뒤로가기 버튼 삭제
          ),
          body: ListView(
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '상위 카테고리',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: DropdownButtonFormField(
                                    hint: Text('상위 카테고리를 선택해주세요',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17)),
                                    isExpanded: true,
                                    alignment: Alignment.center,
                                    items: upperCategoryList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            value,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedUpper = value!;
                                        post.upperCategory = value;
                                        lowerCategoryList =
                                            setLowerCategory(value!.toString());
                                        selectedLower = lowerCategoryList[0];
                                      });
                                    },
                                    onSaved: (value) {
                                      selectedUpper = value!.toString();
                                      post.upperCategory = value;
                                      lowerCategoryList =
                                          setLowerCategory(value!.toString());
                                    },
                                    value: selectedUpper == null
                                        ? null
                                        : selectedUpper,
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 20.0,
                          width: 600,
                        ),

                        // 하위 카테고리 //
                        const Text(
                          '하위 카테고리',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  value: selectedLower == null
                                      ? null
                                      : selectedLower,
                                  hint: Text('하위 카테고리를 선택해주세요',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17)),
                                  alignment: Alignment.center,
                                  items: lowerCategoryList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedLower = value!;
                                      post.lowerCategory = value;
                                      print(post.lowerCategory);
                                    });
                                  },
                                  onSaved: (value) {
                                    selectedLower = value!.toString();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        // 제목 //
                        const Text(
                          '제목',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: TextFormField(
                            key: ValueKey(1),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '제목을 입력해주세요!';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: '제목을 입력해주세요.',
                            ),
                            onChanged: (text) {
                              post.title = text;
                            },
                            onSaved: (text) {
                              post.title = text;
                            },
                            autofocus: true,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        // 내용 //
                        const Text(
                          '내용',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: 10 * 24.0,
                          padding: const EdgeInsets.only(right: 15),
                          child: TextFormField(
                            key: ValueKey(2),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '내용을 입력해주세요!';
                              } else {
                                return null;
                              }
                            },
                            maxLines: 10,
                            decoration: const InputDecoration(
                                hintText: '내용을 입력해주세요.',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                )),
                            onChanged: (text) {
                              post.content = text;
                            },
                            onSaved: (text) {
                              post.content = text;
                            },
                            autofocus: true,
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
                                fontSize: 15,
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
                                    if (participantsCounter != 0) {
                                      participantsCounter--;
                                      post.maxParticipants =
                                          participantsCounter;
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
                              '$participantsCounter',
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: SizedBox(
                                width: 45,
                                height: 45,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      participantsCounter++;
                                      post.maxParticipants =
                                          participantsCounter;
                                    });
                                  },
                                  tooltip: 'Increment',
                                  child: const Icon(Icons.add),
                                ),
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
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
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
                                  post.date = yearMonthDay;
                                },
                              ),
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
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
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
                                  post.time = meetingTime;
                                },
                              ),
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
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: TextFormField(
                            key: ValueKey(3),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '장소를 입력해주세요!';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: '장소를 입력해주세요.',
                            ),
                            onChanged: (text) {
                              post.meetingPlace = text;
                            },
                            onSaved: (text) {
                              post.meetingPlace = text;
                            },
                            autofocus: true,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                  );
                                },
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
                                onPressed: () {
                                  showPopup(context);
                                },
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
                ),
              ])),
    );
  }
}
