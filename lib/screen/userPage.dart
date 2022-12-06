import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/screen/myPost_screen.dart';
import 'package:home_alone_recipe/screen/myScrapRecipe_screen.dart';
import 'package:home_alone_recipe/screen/postGroupBuying_screen.dart';
import 'package:provider/provider.dart';
import 'myTown_screen.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  final List<Category> catego = [
    Category(
      imagUrl: "lib/assets/icons/가공유제품/계란.png",
      name: "계란",
    ),
    Category(
      imagUrl: "lib/assets/icons/가공유제품/버터.png",
      name: "버터",
    ),
    Category(
      imagUrl: "lib/assets/icons/가공유제품/어묵.png",
      name: "어묵",
    ),
    Category(
      imagUrl: "lib/assets/icons/육류/닭고기.png",
      name: "닭가슴살",
    ),
  ];
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 4;
    _userProvider = Provider.of<UserProvider>(context);
    String str = _userProvider.locations.toString();
    str = str.substring(1, str.length - 1);
    str = str.replaceAll(',', ' ');
    return Scaffold(

        appBar: AppBar(
            title: Text('나의 정보',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            centerTitle: true,
            elevation: 3.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),

      body :
          ListView(
            padding:const EdgeInsets.all(8),
      children: [



                  Container(
                    height: 120,
                    // width: 500,
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Palette.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Padding(padding: EdgeInsets.only(left: 10,)),
                        // CircleAvatar(
                        //   radius: 35,
                        //   backgroundColor: Colors.white,
                        //   child: Icon(
                        //     Icons.person_outline,
                        //     size: 35,
                        //     color: Palette.grey,
                        //   ),
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Center(
                            child: Icon(
                              Icons.account_circle,
                              size: imageSize,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_userProvider.nickname + ' 님',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            (str=='') ? Text('위치를 설정해주세요.') : Text(str),

                          ],
                        )
                      ],
                    ),
                  ),




        Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            width: 500.0,
          ),
        ),
              Container(
                height : 180,
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Palette.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text('  나의 활동',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.post_add),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyPostScreen()),
                            );
                          },
                          child: Text(' 내가 쓴 공동구매글 ',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.location_on),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TownScreen()),
                            );
                          },
                          child: Text(' 내 동네 설정 ',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5),

          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            width: 500.0,
          ),
        ),
          // 3번째 박스!!
           Container(
                height: 110,
                decoration: BoxDecoration(
                  color: Palette.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text('  나의 레시피',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.search_rounded),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyScrapRecipeScreen()),
                            );
                          },
                          child: Text(' 내가 스크랩한 레시피 보기 ',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('   오늘의 추천 재료',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: 10,
                  ),



                ],
              ),
              //

            ),
          ),

        Container(
          width: 241,
          height: 190,
          child: ListView.builder(
              itemCount: catego.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height:200,
                          width: 150,

                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(catego[index].imagUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child:
                        Text(
                          catego[index].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),


      ],
      ),
    );
  }
}

class Category {
  final String imagUrl;
  final String name;

  Category({required this.imagUrl, required this.name});
}
