import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_alone_recipe/screen/home_screen.dart';
import 'package:home_alone_recipe/screen/login_screen.dart';
import 'package:home_alone_recipe/Provider/userProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _authentication = FirebaseAuth.instance;
  late UserProvider _userProvider;
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  String userNickName = '';

  void _tryValidation() {
    //validation이 유효한지
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  void showPopup(context, message) {
    //이메일 유효하지 않을 때
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('닫기'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        onPrimary: Colors.white, // Background color
                      ),
                    )
                  ],
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Palette.lightgray,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 300, 5),
                        child: Text('이메일',
                            style: TextStyle(
                                color: Palette.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ), //이메일 text

                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: TextFormField(
                          key: ValueKey(1),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '이메일을 입력해주세요!';
                            } else if (!value.contains('@')) {
                              return '이메일의 형식에 맞지 않습니다!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userEmail = value!;
                          },
                          onChanged: (value) {
                            userEmail = value!;
                          },
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '1234@gmail.com',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ), //이메일 form

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 55, 5),
                        child: Text('비밀번호 (영문+숫자+특수기호 포함 6자 이상)',
                            style: TextStyle(
                                color: Palette.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ), //비밀번호 text

                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: TextFormField(
                          key: ValueKey(2),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '비밀번호를 입력해주세요!';
                            } else if (value!.length < 6) {
                              return '최소 6자 이어야 합니다!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userPassword = value!;
                          },
                          onChanged: (value) {
                            userPassword = value!;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'alstn1234',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ), //비밀번호 form

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 130, 5),
                        child: Text('닉네임 (영문+숫자 포함 4자 이상)',
                            style: TextStyle(
                                color: Palette.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ), //닉네임 text

                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 40),
                        child: TextFormField(
                          key: ValueKey(3),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '닉네임을 입력해주세요!';
                            } else if (value!.length < 4) {
                              return '최소 4자 이어야 합니다!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userNickName = value!;
                          },
                          onChanged: (value) {
                            userNickName = value!;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '불굴의 자취생',
                            prefixIcon: Icon(Icons.account_circle),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ), //닉네임 form

                      Positioned(
                          //회원가입 버튼
                          top: 200,
                          child: GestureDetector(
                            onTap: () async {
                              _tryValidation();
                              try {
                                //회원가입 성공
                                final newUser = await _authentication
                                    .createUserWithEmailAndPassword(
                                  email: userEmail,
                                  password: userPassword,
                                );


                                print(_userProvider.toString());
                                if (newUser.user != null) {
                                  await FirebaseFirestore.instance
                                      .collection("User")
                                      .doc(newUser.user!.uid)
                                      .set({
                                    "Email": userEmail,
                                    "Password": userPassword,
                                    "NickName": userNickName,
                                    "Scope": "",
                                    "Ingredient": [],
                                    "MyRecipes": [],
                                    "Location": "",
                                    "Post": "",
                                  },
                                  ).onError((e, _) =>
                                          print("Error writing document: $e"));

                                  _userProvider.signup(newUser.user!.uid,
                                      userEmail, userPassword, userNickName);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return HomeScreen();
                                    }),
                                  );
                                }
                              } catch (e) {
                                print(e);
                                String message = "이미 중복된 아이디입니다!";
                                showPopup(context, message);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please Check your email and password'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('회원가입',
                                    style: TextStyle(
                                        color: Palette.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                              ),
                              height: 60,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Palette.yellow,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Text(
                            '로그인하러 가기',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
