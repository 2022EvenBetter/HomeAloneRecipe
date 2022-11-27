import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_alone_recipe/screen/categoryIngredent.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_alone_recipe/models/findIngredientByString.dart';
import '../models/findIngredientByString.dart';
import '../widget/userIngredient.dart';

class ocr extends StatefulWidget {
  const ocr({Key? key}) : super(key: key);

  @override
  State<ocr> createState() => _ocr();
}

class _ocr extends State<ocr> {
  late UserProvider _userProvider;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;


  // Ingredient ingredient=new Ingredient();

  File? image;
  File? _image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    // final image = await picker.pickImage(source: imageSource);
    final XFile? image =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  int? flag = 0;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    _buildBottomDrawer(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('마이냉장고',style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        //
        centerTitle: true,
        elevation: 3.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
          actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (flag == 0) {
                    _controller.open();
                    flag = 1;
                  } else {
                    _controller.close();
                    flag = 0;
                  }

                  setState(() {
                    _button = 'Close Drawer';
                  });
                },
              ),
            ]),

      // appBar: AppBar(
      //   title: Text('마이냉장고',style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      //     backgroundColor: Colors.white,
      //     centerTitle: true,
      //     // elevation: 0.0,
      //     actions: <Widget>[
      //       IconButton(
      //         icon: Icon(
      //           Icons.add,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {
      //           if (flag == 0) {
      //             _controller.open();
      //             flag = 1;
      //           } else {
      //             _controller.close();
      //             flag = 0;
      //           }
      //
      //           setState(() {
      //             _button = 'Close Drawer';
      //           });
      //         },
      //       ),
      //     ]),

      // drawer: Drawer(
      //     child: ListView(
      //       children: [
      //         DrawerHeader(
      //           child: Text('header'),
      //           decoration: BoxDecoration(color: Colors.green),
      //         )
      //       ],
      //     )),
      body: Stack(
        children: [
          Column(


       // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(''),
              Text('식재료',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(''),
              Padding(
                padding : const EdgeInsets.only(top: 25),
              ),

              if(_userProvider.ingredients.isEmpty)
                Text('재료가 없습니다.',style: TextStyle( fontSize: 10))
              else
                userIngredient(),




              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // if(parsedtext.length>100)
                    //   Text(parsedtext.substring(0,100))
                    // else
                    //   Text(parsedtext),

                  ],
                ),
              ),
            ],
          ),
          _buildBottomDrawer(context),
        ],
      ),
    );
  }

  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: Colors.white38,
      controller: _controller,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 60,
          spreadRadius: 5,
          offset: const Offset(2, -6), // changes position of shadow
        ),
      ],
    );
  }

  Widget _buildBottomDrawerHead(BuildContext context) {
    return Container(
      height: _headerHeight,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                child: Text(
                  '레시피 추천받기',
                  style: GoogleFonts.getFont('Do Hyeon', textStyle:  const TextStyle(fontSize: 15) ,

                    color: Colors.black,
                  ),
                ),
                onPressed: () {},
              )
            ]),
          ),
          Spacer(),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDrawerBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _bodyHeight,
      child: SingleChildScrollView(
        child: Column(children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
          TextButton(
            child: Text(
              'OCR로 재료추가',
              style: GoogleFonts.getFont('Do Hyeon', textStyle:  const TextStyle(fontSize: 15) ,

                color: Colors.black,
              ),
            ),
            onPressed: () {
              _getFromGallery();
            },
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 0)),
          TextButton(
            child: Text(
              '카테고리로 재료추가',
              style: GoogleFonts.getFont('Do Hyeon', textStyle:  const TextStyle(fontSize: 15) ,

                color: Colors.black,
              ),
            ),
            onPressed: () async {
              final List<String> addUserIngredient = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryIngredient()),
              );
              if (addUserIngredient.isEmpty) {
                print("Data has NULL");
              } else {
                print("추가할 재료 목록 : $addUserIngredient");
              }
            },
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 0)),
          TextButton(
            child: Text(
              '재료 삭제하기',
              style: GoogleFonts.getFont('Do Hyeon', textStyle:  const TextStyle(fontSize: 15) ,

                color: Colors.black,
              ),
            ),
            onPressed: () {},
          )
        ]),
      ),
    );
  }

  List<Widget> _buildButtons(String prefix, int start, int end) {
    List<Widget> buttons = [];
    for (int i = start; i <= end; i++)
      buttons.add(TextButton(
        child: Text(
          '$prefix Button $i',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          setState(() {
            _button = '$prefix Button $i';
          });
        },
      ));
    return buttons;
  }

  String _button = 'None';
  double _headerHeight = 60.0;
  double _bodyHeight = 220.0;
  BottomDrawerController _controller = BottomDrawerController();

  String parsedtext = '';

  Future _getFromGallery() async {
    // final pickedFile=_image;
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {
      "base64Image": "data:image/jpg;base64,${img64.toString()}",
      "language": "kor"
    };
    var header = {"apikey": "K82749852688957"};

    var post = await http.post(Uri.parse(url), body: payload, headers: header);
    var result = jsonDecode(post.body);
    List<String> tmp = findIngredient(parsedtext);
    tmp.toSet();
    for (int i = 0; i < tmp.length; i++) {
      if (kDebugMode) {
        print(tmp[i]);
      }
    }
    _userProvider.ingredients.clear();

    print(tmp.toString());

    _userProvider.addIngredient(tmp);
    await FirebaseFirestore.instance
        .collection("User")
        .doc(_userProvider.uid)
        .set({
      "Email": _userProvider.email,
      "Password": _userProvider.password,
      "NickName": _userProvider.nickname,
      "Scope": "",
      "Ingredient": _userProvider.ingredients,
      "MyRecipes": [],
      "Location": "",
      "Post": [],
    },
    ).onError((e, _) =>
        print("Error writing document: $e"));
    // print(parsedtext);
    setState(() {
      parsedtext = result['ParsedResults'][0]['ParsedText'];
    });
  }







}

