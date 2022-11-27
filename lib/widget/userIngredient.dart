import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/userProvider.dart';

class userIngredient extends StatefulWidget {

  @override
  State<userIngredient> createState() => _userIngredient();
}

class _userIngredient extends State<userIngredient> {

  late UserProvider _userProvider;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {

    _userProvider = Provider.of<UserProvider>(context);
    String str=_userProvider.ingredients.toString();
    str=str.substring(1,str.length-1);
    str=str.split(' ').join('');
    List<String> list=str.split(',');
    List<String> imageAsset=['1','2','3'];
//'1','lib/assets/icons/조미료양념/카레가루.png','lib/assets/icons/채소류/버섯.png'
    int i=0;
    for (String ingredient in list) {
      if(ingredient=='어묵')
        imageAsset[i]='lib/assets/icons/가공유제품/어묵.png';
      else if(ingredient=='계란')
        imageAsset[i]='lib/assets/icons/가공유제품/계란.png';
      else if(ingredient=='모짜렐라치즈')
        imageAsset[i]='lib/assets/icons/가공유제품/모짜렐라치즈.png';
      else if(ingredient=='버터')
        imageAsset[i]='lib/assets/icons/가공유제품/버터.png';
      else if(ingredient=='카레가루')
        imageAsset[i]='lib/assets/icons/조미료양념/카레가루.png';
      else if(ingredient=='새송이버섯')
        imageAsset[i]='lib/assets/icons/채소류/버섯.png';

      print(imageAsset[i]);
      i++;
    }

    return Container(
      child:
          Column(
            children: [
              Text(list.toString()),
                for(int n=0;n<i;n++)
                Image.asset(imageAsset[n],height: 50,width: 50,),


            ],
          ),

    );
  }

}