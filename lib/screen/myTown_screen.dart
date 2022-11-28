import 'package:flutter/material.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:home_alone_recipe/network/naver_api_connector.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_alone_recipe/constants/apiKey.dart';
import 'package:provider/provider.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_alone_recipe/widget/bottomBar.dart';
import 'package:home_alone_recipe/screen/home_screen.dart';

const List<String> list = <String>['동명 (읍/면)', '구 (시/군)', '도 (시)'];

class TownScreen extends StatefulWidget {
  const TownScreen({super.key});

  @override
  _TownScreenState createState() => _TownScreenState();
}

class _TownScreenState extends State<TownScreen> {
  late UserProvider _userProvider;
  Future<List<String>> mylocation = getLocation();
  Future<String> locationURL = getLocationUrl();

  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = list.first;

  void _onItemTapped(int index) {
    setState(() {
      int index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '내 동네 설정하기',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 3.0,
          backgroundColor: Colors.white,
        ),
        body: ListView(children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    '위치 업데이트하기',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, bottom: 5),
                    child: Text('내가 지금 있는 곳으로 위치를 설정할 수 있어요.',
                        style: TextStyle(color: Colors.black38)),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 0),
            child: FutureBuilder(
                future: mylocation,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(136, 25, 136, 10),
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    );
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                  else {
                    _userProvider.locations = snapshot.data as List<String>;
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: 10, // <-- Your width
                        height: 50, // <-- Your height
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() async {
                              mylocation = getLocation();
                              locationURL = getLocationUrl();
                              _userProvider.locations =
                                  mylocation as List<String>;
                              print(_userProvider.locations);
                            });
                          },
                          icon: Icon(Icons.update),
                          style: ElevatedButton.styleFrom(
                            primary: Palette.orange,
                            onPrimary: Colors.black,
                          ),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  _userProvider.locations[0] +
                                      " " +
                                      _userProvider.locations[1] +
                                      " " +
                                      _userProvider.locations[2],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: Container(
              height: 1.0,
              width: 500.0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 5),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        '범위를 지정해주세요.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 17),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list
                          .map((item) => DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          dropdownValue = "error";
                          return '범위를 지정해주세요!';
                        }
                      },
                      onSaved: (value) {
                        dropdownValue = value.toString();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                    child: Text('선택한 범위의 게시물만 볼 수 있어요.',
                        style: TextStyle(color: Colors.black38)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: FutureBuilder(
                        future: locationURL,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                          if (snapshot.hasData == false) {
                            return CircularProgressIndicator(
                              color: Colors.orange,
                            );
                          }
                          //error가 발생하게 될 경우 반환하게 되는 부분
                          else if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          }
                          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                          else {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                              child: Container(
                                alignment: Alignment.center,
                                child: Image.network(
                                  snapshot.data.toString(),
                                  headers: headerss,
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        if (dropdownValue.toString() == '도 (시)') {
                          _userProvider.scope = 0;
                        } else if (dropdownValue.toString() == '구 (시/군)') {
                          _userProvider.scope = 1;
                        } else if (dropdownValue.toString() == '동명 (읍/면)') {
                          _userProvider.scope = 2;
                        }
                        if (dropdownValue != "error") {
                          await FirebaseFirestore.instance
                              .collection("User")
                              .doc(_userProvider.uid)
                              .set({
                            "Location": _userProvider.locations,
                            "Scope": _userProvider.scope,
                          }, SetOptions(merge: true));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('위치가 업데이트되었습니다!'),
                            backgroundColor: Colors.blue,
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('범위를 지정해주세요!'),
                            backgroundColor: Colors.blue,
                          ));
                        }
                        ;
                      },
                      icon: Icon(
                        Icons.save_alt,
                        color: Colors.black,
                      ),
                      label: Text(
                        '저장하기',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
    );
  }
}
