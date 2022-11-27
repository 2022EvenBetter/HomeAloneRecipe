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
      else if(ingredient=='슬라이스치즈')
        imageAsset[i]='lib/assets/icons/가공유제품/슬라이스치즈.png';
      else if(ingredient=='옥수수콘')
        imageAsset[i]='lib/assets/icons/가공유제품/옥수수콘.png';
      else if(ingredient=='우유')
        imageAsset[i]='lib/assets/icons/가공유제품/우유.png';
      else if(ingredient=='참치캔')
        imageAsset[i]='lib/assets/icons/가공유제품/참치캔.png';
      else if(ingredient=='감자')
        imageAsset[i]='lib/assets/icons/곡류/감자.png';
      else if(ingredient=='고구마')
        imageAsset[i]='lib/assets/icons/곡류/고구마.png';
      else if(ingredient=='밀가루')
        imageAsset[i]='lib/assets/icons/곡류/밀가루.png';
      else if(ingredient=='부침가루')
        imageAsset[i]='lib/assets/icons/곡류/부침가루.png';
      else if(ingredient=='빵가루')
        imageAsset[i]='lib/assets/icons/곡류/빵가루.png';
      else if(ingredient=='쌀')
        imageAsset[i]='lib/assets/icons/곡류/쌀.png';
      else if(ingredient=='옥수수')
        imageAsset[i]='lib/assets/icons/곡류/옥수수.png';
      else if(ingredient=='찹쌀가루')
        imageAsset[i]='lib/assets/icons/곡류/찹쌀가루.png';
      else if(ingredient=='감')
        imageAsset[i]='lib/assets/icons/과일/감.png';
      else if(ingredient=='건포도')
        imageAsset[i]='lib/assets/icons/과일/건포도.png';
      else if(ingredient=='딸기')
        imageAsset[i]='lib/assets/icons/과일/딸기.png';
      else if(ingredient=='레몬')
        imageAsset[i]='lib/assets/icons/과일/레몬.png';
      else if(ingredient=='바나나')
        imageAsset[i]='lib/assets/icons/과일/바나나.png';
      else if(ingredient=='배')
        imageAsset[i]='lib/assets/icons/과일/배.png';
      else if(ingredient=='사과')
        imageAsset[i]='lib/assets/icons/과일/사과.png';
      else if(ingredient=='아보카도')
        imageAsset[i]='lib/assets/icons/과일/아보카도.png';
      else if(ingredient=='오렌지')
        imageAsset[i]='lib/assets/icons/과일/오렌지.png';
      else if(ingredient=='자몽')
        imageAsset[i]='lib/assets/icons/과일/자몽.png';
      else if(ingredient=='체리')
        imageAsset[i]='lib/assets/icons/과일/체리.png';
      else if(ingredient=='키위')
        imageAsset[i]='lib/assets/icons/과일/키위.png';
      else if(ingredient=='파인애플')
        imageAsset[i]='lib/assets/icons/과일/파인애플.png';
      else if(ingredient=='포도')
        imageAsset[i]='lib/assets/icons/과일/포도.png';
      else if(ingredient=='당면')
        imageAsset[i]='lib/assets/icons/면/당면.png';
      else if(ingredient=='라면')
        imageAsset[i]='lib/assets/icons/면/라면.png';
      else if(ingredient=='소면')
        imageAsset[i]='lib/assets/icons/면/소면.png';
      else if(ingredient=='우동면')
        imageAsset[i]='lib/assets/icons/면/우동면.png';
      else if(ingredient=='칼국수면')
        imageAsset[i]='lib/assets/icons/면/칼국수면.png';
      else if(ingredient=='파스타면')
        imageAsset[i]='lib/assets/icons/면/파스타면.png';
      else if(ingredient=='떡국떡')
        imageAsset[i]='lib/assets/icons/빵떡/떡국떡.png';
      else if(ingredient=='식빵')
        imageAsset[i]='lib/assets/icons/빵떡/식빵.png';
      else if(ingredient=='곱창')
        imageAsset[i]='lib/assets/icons/육류/곱창.png';
      else if(ingredient=='다짐육')
        imageAsset[i]='lib/assets/icons/육류/다짐육.png';
      else if(ingredient=='닭고기')
        imageAsset[i]='lib/assets/icons/육류/닭고기.png';
      else if(ingredient=='돼지고기')
        imageAsset[i]='lib/assets/icons/육류/돼지고기.png';
      else if(ingredient=='소고기')
        imageAsset[i]='lib/assets/icons/육류/소고기.png';
      else if(ingredient=='양')
        imageAsset[i]='lib/assets/icons/육류/양.png';
      else if(ingredient=='장조림')
        imageAsset[i]='lib/assets/icons/육류/장조림.png';
      else if(ingredient=='간장')
        imageAsset[i]='lib/assets/icons/조미료양념/간장.png';
      else if(ingredient=='고추장')
        imageAsset[i]='lib/assets/icons/조미료양념/고추장.png';
      else if(ingredient=='고춧가루')
        imageAsset[i]='lib/assets/icons/조미료양념/고춧가루.png';
      else if(ingredient=='굴소스')
        imageAsset[i]='lib/assets/icons/조미료양념/굴소스.png';
      else if(ingredient=='다진마늘')
        imageAsset[i]='lib/assets/icons/조미료양념/다진마늘.png';
      else if(ingredient=='된장')
        imageAsset[i]='lib/assets/icons/조미료양념/된장.png';
      else if(ingredient=='마요네즈')
        imageAsset[i]='lib/assets/icons/조미료양념/마요네즈.png';
      else if(ingredient=='멸치액젓')
        imageAsset[i]='lib/assets/icons/조미료양념/멸치액젓.png';
      else if(ingredient=='설탕')
        imageAsset[i]='lib/assets/icons/조미료양념/설탕.png';
      else if(ingredient=='소금')
        imageAsset[i]='lib/assets/icons/조미료양념/소금.png';
      else if(ingredient=='쇠고기 다시다')
        imageAsset[i]='lib/assets/icons/조미료양념/쇠고기 다시다.png';
      else if(ingredient=='식초')
        imageAsset[i]='lib/assets/icons/조미료양념/식초.png';
      else if(ingredient=='쌈장')
        imageAsset[i]='lib/assets/icons/조미료양념/쌈장.png';
      else if(ingredient=='올리브유')
        imageAsset[i]='lib/assets/icons/조미료양념/올리브유.png';
      else if(ingredient=='참기름')
        imageAsset[i]='lib/assets/icons/조미료양념/참기름.png';
      else if(ingredient=='카레가루')
        imageAsset[i]='lib/assets/icons/조미료양념/카레가루.png';
      else if(ingredient=='케첩')
        imageAsset[i]='lib/assets/icons/조미료양념/케첩.png';
      else if(ingredient=='후추')
        imageAsset[i]='lib/assets/icons/조미료양념/후추.png';
      else if(ingredient=='가지')
        imageAsset[i]='lib/assets/icons/채소류/가지.png';
      else if(ingredient=='감자')
        imageAsset[i]='lib/assets/icons/채소류/감자.png';
      else if(ingredient=='검은콩')
        imageAsset[i]='lib/assets/icons/채소류/검은콩.png';
      else if(ingredient=='고추')
        imageAsset[i]='lib/assets/icons/채소류/고추.png';
      else if(ingredient=='김치')
        imageAsset[i]='lib/assets/icons/채소류/김치.png';
      else if(ingredient=='깻잎')
        imageAsset[i]='lib/assets/icons/채소류/깻잎.png';
      else if(ingredient=='당근')
        imageAsset[i]='lib/assets/icons/채소류/당근.png';
      else if(ingredient=='대파')
        imageAsset[i]='lib/assets/icons/채소류/대파.png';
      else if(ingredient=='마늘')
        imageAsset[i]='lib/assets/icons/채소류/마늘.png';
      else if(ingredient=='무')
        imageAsset[i]='lib/assets/icons/채소류/무.png';
      else if(ingredient=='바질')
        imageAsset[i]='lib/assets/icons/채소류/바질.png';
      else if(ingredient=='배추')
        imageAsset[i]='lib/assets/icons/채소류/배추.png';
      else if(ingredient=='버섯')
        imageAsset[i]='lib/assets/icons/채소류/버섯.png';
      else if(ingredient=='브로콜리')
        imageAsset[i]='lib/assets/icons/채소류/브로콜리.png';
      else if(ingredient=='비트')
        imageAsset[i]='lib/assets/icons/채소류/비트.png';
      else if(ingredient=='상추')
        imageAsset[i]='lib/assets/icons/채소류/상추.png';
      else if(ingredient=='샐러리')
        imageAsset[i]='lib/assets/icons/채소류/샐러리.png';
      else if(ingredient=='생강')
        imageAsset[i]='lib/assets/icons/채소류/생강.png';
      else if(ingredient=='시금치')
        imageAsset[i]='lib/assets/icons/채소류/시금치.png';
      else if(ingredient=='아스파라거스')
        imageAsset[i]='lib/assets/icons/채소류/아스파라거지.png';
      else if(ingredient=='애호박')
        imageAsset[i]='lib/assets/icons/채소류/애호박.png';
      else if(ingredient=='양배추')
        imageAsset[i]='lib/assets/icons/채소류/양배추.png';
      else if(ingredient=='양송이버섯')
        imageAsset[i]='lib/assets/icons/채소류/양송이버섯.png';
      else if(ingredient=='양파')
        imageAsset[i]='lib/assets/icons/채소류/양파.png';
      else if(ingredient=='오이')
        imageAsset[i]='lib/assets/icons/채소류/오이.png';
      else if(ingredient=='청경채')
        imageAsset[i]='lib/assets/icons/채소류/청경채.png';
      else if(ingredient=='케일')
        imageAsset[i]='lib/assets/icons/채소류/케일.png';
      else if(ingredient=='콩')
        imageAsset[i]='lib/assets/icons/채소류/콩.png';
      else if(ingredient=='콩나물')
        imageAsset[i]='lib/assets/icons/채소류/콩나물.png';
      else if(ingredient=='토마토')
        imageAsset[i]='lib/assets/icons/채소류/토마토.png';
      else if(ingredient=='파')
        imageAsset[i]='lib/assets/icons/채소류/파.png';
      else if(ingredient=='파슬리')
        imageAsset[i]='lib/assets/icons/채소류/파슬리.png';
      else if(ingredient=='파프리카')
        imageAsset[i]='lib/assets/icons/채소류/파프리카.png';
      else if(ingredient=='팽이버섯')
        imageAsset[i]='lib/assets/icons/채소류/팽이버섯.png';
      else if(ingredient=='표고버섯')
        imageAsset[i]='lib/assets/icons/채소류/표고버섯.png';
      else if(ingredient=='호박')
        imageAsset[i]='lib/assets/icons/채소류/호박.png';
      else if(ingredient=='피망')
        imageAsset[i]='lib/assets/icons/채소류/피망.png';
      else if(ingredient=='새송이버섯')
        imageAsset[i]='lib/assets/icons/채소류/버섯.png';
      else if(ingredient=='깨')
        imageAsset[i]='lib/assets/icons/콩견과류/깨.png';
      else if(ingredient=='두부')
        imageAsset[i]='lib/assets/icons/콩견과류/두부.png';
      else if(ingredient=='아몬드')
        imageAsset[i]='lib/assets/icons/콩견과류/아몬드.png';
      else if(ingredient=='청국장')
        imageAsset[i]='lib/assets/icons/콩견과류/청국장.png';
      else if(ingredient=='콩')
        imageAsset[i]='lib/assets/icons/콩견과류/콩.png';
      else if(ingredient=='호두')
        imageAsset[i]='lib/assets/icons/콩견과류/호두.png';
      else if(ingredient=='갈치')
        imageAsset[i]='lib/assets/icons/해산물/갈치.png';
      else if(ingredient=='게맛살')
        imageAsset[i]='lib/assets/icons/해산물/게맛살.png';
      else if(ingredient=='고등어')
        imageAsset[i]='lib/assets/icons/해산물/고등어.png';
      else if(ingredient=='골뱅이')
        imageAsset[i]='lib/assets/icons/해산물/골뱅이.png';
      else if(ingredient=='굴')
        imageAsset[i]='lib/assets/icons/해산물/굴.png';
      else if(ingredient=='꽁치')
        imageAsset[i]='lib/assets/icons/해산물/꽁치.png';
      else if(ingredient=='낙지')
        imageAsset[i]='lib/assets/icons/해산물/낙지.png';
      else if(ingredient=='다시마')
        imageAsset[i]='lib/assets/icons/해산물/다시마.png';
      else if(ingredient=='동태')
        imageAsset[i]='lib/assets/icons/해산물/동태.png';
      else if(ingredient=='멸치')
        imageAsset[i]='lib/assets/icons/해산물/멸치.png';
      else if(ingredient=='문어')
        imageAsset[i]='lib/assets/icons/해산물/문어.png';
      else if(ingredient=='미역')
        imageAsset[i]='lib/assets/icons/해산물/미역.png';
      else if(ingredient=='새우')
        imageAsset[i]='lib/assets/icons/해산물/새우.png';
      else if(ingredient=='오징어')
        imageAsset[i]='lib/assets/icons/해산물/오징어.png';
      else if(ingredient=='전복')
        imageAsset[i]='lib/assets/icons/해산물/전복.png';
      else if(ingredient=='조개')
        imageAsset[i]='lib/assets/icons/해산물/조개.png';
      else if(ingredient=='조기')
        imageAsset[i]='lib/assets/icons/해산물/조기.png';
      else if(ingredient=='쭈꾸미')
        imageAsset[i]='lib/assets/icons/해산물/쭈꾸미.png';
      else if(ingredient=='베이컨')
        imageAsset[i]='lib/assets/icons/햄소시지/베이컨.png';
      else if(ingredient=='비엔나소시지')
        imageAsset[i]='lib/assets/icons/햄소시지/비엔나소시지.png';
      else if(ingredient=='소시지')
        imageAsset[i]='lib/assets/icons/햄소시지/소시지.png';
      else if(ingredient=='햄')
        imageAsset[i]='lib/assets/icons/햄소시지/햄.png';




      print(imageAsset[i]);
      i++;
    }

    return Container(
      child:
          Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  for(int n=0;n<i;n++)
                    Image.asset(imageAsset[n], height: 50, width: 50,),


                ],
              ),
            ],
          ),


    );
  }

}