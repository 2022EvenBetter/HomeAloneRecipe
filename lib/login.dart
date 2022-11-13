import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_alone_recipe/home.dart';
import 'package:home_alone_recipe/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authentication = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';

  void _tryValidation() {
    //validation이 유효한지
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 300, 10),
                        child: Text('이메일',
                            style: TextStyle(
                                color: Palette.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ), //이메일 text

                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
                        child: TextFormField(
                          key: const ValueKey(1),
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
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '1234@gmail.com',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ), //이메일 form

                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 300, 10),
                        child: Text('비밀번호',
                            style: TextStyle(
                                color: Palette.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ), //비밀번호 text

                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
                        child: TextFormField(
                          key: const ValueKey(2),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '비밀번호를 입력해주세요!';
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
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'alstn1234',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ), //비밀번호 form

                      Positioned(
                          //로그인 버튼
                          top: 200,
                          child: GestureDetector(
                            onTap: () async {
                              _tryValidation();

                              try {
                                final newUser = await _authentication
                                    .signInWithEmailAndPassword(
                                  email: userEmail,
                                  password: userPassword,
                                );

                                if (newUser.user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return HomeScreen();
                                    }),
                                  );
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('로그인',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Text(
                            '계정이 없으신가요?',
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
