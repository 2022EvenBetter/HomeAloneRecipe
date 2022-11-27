import 'package:flutter/material.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {

  late UserProvider _userProvider;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    String str=_userProvider.locations.toString();
    str=str.substring(1,str.length-1);
    str=str.replaceAll(',', ' ');
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 정보',style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        elevation: 3.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Container(
            height: 180,
            width: 500,
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(15),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Padding(padding: EdgeInsets.only(left: 10,)),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_outline,
                      size : 35,
                      color: Colors.black12,
                    ),

                  ),
                  // Positioned(
                  //     bottom : 40,
                  //     right : 20,
                  //     child: InkWell(
                  //       onTap: (){},
                  //       child: Icon(
                  //         Icons.camera_alt_outlined,
                  //         size : 40,
                  //       ),
                  //
                  // )),

                  //image
                  // Padding(padding: EdgeInsets.only(left: 10)),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_userProvider.nickname+' 님',style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(str),
                      SizedBox(height:20),
                    ],
                  )
                ],
              ),


          ),
          ),

          // 2번째 박스!
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Container(
              height: 180,
              width: 500,
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text('  나의 활동',style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Icon(
                        Icons.post_add
                      ),
                      TextButton(onPressed: (){}, child: Text(' 내가 쓴 공동구매글 ', style: TextStyle(color:Colors.black)),),

                    ],
                  ),

                  SizedBox(height: 5,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Icon(
                          Icons.location_on
                      ),
                      TextButton(onPressed: (){
                        //go to GPS! code
                      }, child: Text(' 내 동네 설정 ', style: TextStyle(color:Colors.black)),),

                    ],
                  ),
                ],
              ),


            ),
          ),
        ]
      ),

    );
  }

}