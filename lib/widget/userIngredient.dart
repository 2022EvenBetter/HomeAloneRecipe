import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:home_alone_recipe/models/findIngredientByString.dart';
import 'package:home_alone_recipe/widget/ingredient_button.dart';
import 'package:provider/provider.dart';
import '../provider/userProvider.dart';

class userIngredient extends StatefulWidget {
  final Function setRemoveIngredient;
  final Function cancelRemoveIngredient;
  final List<String> selectedIngredient;
  const userIngredient(this.selectedIngredient, this.setRemoveIngredient,
      this.cancelRemoveIngredient,
      {Key? key})
      : super(key: key);
  @override
  State<userIngredient> createState() => _userIngredient();
}

class _userIngredient extends State<userIngredient> {
  late UserProvider _userProvider;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;




  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    var a = widget.selectedIngredient;
    String str = _userProvider.ingredients.toString();



    distinctIngredient(str);





    str = str.substring(1, str.length - 1);
    str = str.split(' ').join('');
    List<String> list = str.split(',');
    List<String> imageAsset = [];

//'1','lib/assets/icons/조미료양념/카레가루.png'),'lib/assets/icons/채소류/버섯.png')

    int i = 0;
    for (String ingredient in list) {
      if (ingredient == '어묵')
        imageAsset.add('lib/assets/icons/가공유제품/어묵.png');
      else if (ingredient == '계란')
        imageAsset.add('lib/assets/icons/가공유제품/계란.png');
      else if (ingredient == '모짜렐라치즈')
        imageAsset.add('lib/assets/icons/가공유제품/모짜렐라치즈.png');
      else if (ingredient == '버터')
        imageAsset.add('lib/assets/icons/가공유제품/버터.png');
      else if (ingredient == '슬라이스치즈')
        imageAsset.add('lib/assets/icons/가공유제품/슬라이스치즈.png');
      else if (ingredient == '옥수수콘')
        imageAsset.add('lib/assets/icons/가공유제품/옥수수콘.png');
      else if (ingredient == '우유')
        imageAsset.add('lib/assets/icons/가공유제품/우유.png');
      else if (ingredient == '참치캔')
        imageAsset.add('lib/assets/icons/가공유제품/참치캔.png');
      else if (ingredient == '감자')
        imageAsset.add('lib/assets/icons/곡류/감자.png');
      else if (ingredient == '고구마')
        imageAsset.add('lib/assets/icons/곡류/고구마.png');
      else if (ingredient == '밀가루')
        imageAsset.add('lib/assets/icons/곡류/밀가루.png');
      else if (ingredient == '부침가루')
        imageAsset.add('lib/assets/icons/곡류/부침가루.png');
      else if (ingredient == '빵가루')
        imageAsset.add('lib/assets/icons/곡류/빵가루.png');
      else if (ingredient == '쌀')
        imageAsset.add('lib/assets/icons/곡류/쌀.png');
      else if (ingredient == '옥수수')
        imageAsset.add('lib/assets/icons/곡류/옥수수.png');
      else if (ingredient == '찹쌀가루')
        imageAsset.add('lib/assets/icons/곡류/찹쌀가루.png');
      else if (ingredient == '감')
        imageAsset.add('lib/assets/icons/과일/감.png');
      else if (ingredient == '건포도')
        imageAsset.add('lib/assets/icons/과일/건포도.png');
      else if (ingredient == '딸기')
        imageAsset.add('lib/assets/icons/과일/딸기.png');
      else if (ingredient == '레몬')
        imageAsset.add('lib/assets/icons/과일/레몬.png');
      else if (ingredient == '바나나')
        imageAsset.add('lib/assets/icons/과일/바나나.png');
      else if (ingredient == '배')
        imageAsset.add('lib/assets/icons/과일/배.png');
      else if (ingredient == '사과')
        imageAsset.add('lib/assets/icons/과일/사과.png');
      else if (ingredient == '아보카도')
        imageAsset.add('lib/assets/icons/과일/아보카도.png');
      else if (ingredient == '오렌지')
        imageAsset.add('lib/assets/icons/과일/오렌지.png');
      else if (ingredient == '자몽')
        imageAsset.add('lib/assets/icons/과일/자몽.png');
      else if (ingredient == '체리')
        imageAsset.add('lib/assets/icons/과일/체리.png');
      else if (ingredient == '키위')
        imageAsset.add('lib/assets/icons/과일/키위.png');
      else if (ingredient == '파인애플')
        imageAsset.add('lib/assets/icons/과일/파인애플.png');
      else if (ingredient == '포도')
        imageAsset.add('lib/assets/icons/과일/포도.png');
      else if (ingredient == '당면')
        imageAsset.add('lib/assets/icons/면/당면.png');
      else if (ingredient == '라면')
        imageAsset.add('lib/assets/icons/면/라면.png');
      else if (ingredient == '소면')
        imageAsset.add('lib/assets/icons/면/소면.png');
      else if (ingredient == '우동면')
        imageAsset.add('lib/assets/icons/면/우동면.png');
      else if (ingredient == '칼국수면')
        imageAsset.add('lib/assets/icons/면/칼국수면.png');
      else if (ingredient == '파스타면')
        imageAsset.add('lib/assets/icons/면/파스타면.png');
      else if (ingredient == '떡국떡')
        imageAsset.add('lib/assets/icons/빵떡/떡국떡.png');
      else if (ingredient == '식빵')
        imageAsset.add('lib/assets/icons/빵떡/식빵.png');
      else if (ingredient == '곱창')
        imageAsset.add('lib/assets/icons/육류/곱창.png');
      else if (ingredient == '다짐육')
        imageAsset.add('lib/assets/icons/육류/다짐육.png');
      else if (ingredient == '닭고기')
        imageAsset.add('lib/assets/icons/육류/닭고기.png');
      else if (ingredient == '돼지고기')
        imageAsset.add('lib/assets/icons/육류/돼지고기.png');
      else if (ingredient == '소고기')
        imageAsset.add('lib/assets/icons/육류/소고기.png');
      else if (ingredient == '양')
        imageAsset.add('lib/assets/icons/육류/양.png');
      else if (ingredient == '장조림')
        imageAsset.add('lib/assets/icons/육류/장조림.png');
      else if (ingredient == '간장')
        imageAsset.add('lib/assets/icons/조미료양념/간장.png');
      else if (ingredient == '고추장')
        imageAsset.add('lib/assets/icons/조미료양념/고추장.png');
      else if (ingredient == '고춧가루')
        imageAsset.add('lib/assets/icons/조미료양념/고춧가루.png');
      else if (ingredient == '굴소스')
        imageAsset.add('lib/assets/icons/조미료양념/굴소스.png');
      else if (ingredient == '다진마늘')
        imageAsset.add('lib/assets/icons/조미료양념/다진마늘.png');
      else if (ingredient == '된장')
        imageAsset.add('lib/assets/icons/조미료양념/된장.png');
      else if (ingredient == '마요네즈')
        imageAsset.add('lib/assets/icons/조미료양념/마요네즈.png');
      else if (ingredient == '멸치액젓')
        imageAsset.add('lib/assets/icons/조미료양념/멸치액젓.png');
      else if (ingredient == '설탕')
        imageAsset.add('lib/assets/icons/조미료양념/설탕.png');
      else if (ingredient == '소금')
        imageAsset.add('lib/assets/icons/조미료양념/소금.png');
      else if (ingredient == '쇠고기 다시다')
        imageAsset.add('lib/assets/icons/조미료양념/쇠고기 다시다.png');
      else if (ingredient == '식초')
        imageAsset.add('lib/assets/icons/조미료양념/식초.png');
      else if (ingredient == '쌈장')
        imageAsset.add('lib/assets/icons/조미료양념/쌈장.png');
      else if (ingredient == '올리브유')
        imageAsset.add('lib/assets/icons/조미료양념/올리브유.png');
      else if (ingredient == '참기름')
        imageAsset.add('lib/assets/icons/조미료양념/참기름.png');
      else if (ingredient == '카레가루')
        imageAsset.add('lib/assets/icons/조미료양념/카레가루.png');
      else if (ingredient == '케첩')
        imageAsset.add('lib/assets/icons/조미료양념/케첩.png');
      else if (ingredient == '후추')
        imageAsset.add('lib/assets/icons/조미료양념/후추.png');
      else if (ingredient == '가지')
        imageAsset.add('lib/assets/icons/채소류/가지.png');
      else if (ingredient == '감자')
        imageAsset.add('lib/assets/icons/채소류/감자.png');
      else if (ingredient == '검은콩')
        imageAsset.add('lib/assets/icons/채소류/검은콩.png');
      else if (ingredient == '고추')
        imageAsset.add('lib/assets/icons/채소류/고추.png');
      else if (ingredient == '김치')
        imageAsset.add('lib/assets/icons/채소류/김치.png');
      else if (ingredient == '깻잎')
        imageAsset.add('lib/assets/icons/채소류/깻잎.png');
      else if (ingredient == '당근')
        imageAsset.add('lib/assets/icons/채소류/당근.png');
      else if (ingredient == '대파')
        imageAsset.add('lib/assets/icons/채소류/대파.png');
      else if (ingredient == '마늘')
        imageAsset.add('lib/assets/icons/채소류/마늘.png');
      else if (ingredient == '무')
        imageAsset.add('lib/assets/icons/채소류/무.png');
      else if (ingredient == '바질')
        imageAsset.add('lib/assets/icons/채소류/바질.png');
      else if (ingredient == '배추')
        imageAsset.add('lib/assets/icons/채소류/배추.png');
      else if (ingredient == '버섯')
        imageAsset.add('lib/assets/icons/채소류/버섯.png');
      else if (ingredient == '브로콜리')
        imageAsset.add('lib/assets/icons/채소류/브로콜리.png');
      else if (ingredient == '비트')
        imageAsset.add('lib/assets/icons/채소류/비트.png');
      else if (ingredient == '상추')
        imageAsset.add('lib/assets/icons/채소류/상추.png');
      else if (ingredient == '샐러리')
        imageAsset.add('lib/assets/icons/채소류/샐러리.png');
      else if (ingredient == '생강')
        imageAsset.add('lib/assets/icons/채소류/생강.png');
      else if (ingredient == '시금치')
        imageAsset.add('lib/assets/icons/채소류/시금치.png');
      else if (ingredient == '아스파라거스')
        imageAsset.add('lib/assets/icons/채소류/아스파라거지.png');
      else if (ingredient == '애호박')
        imageAsset.add('lib/assets/icons/채소류/애호박.png');
      else if (ingredient == '양배추')
        imageAsset.add('lib/assets/icons/채소류/양배추.png');
      else if (ingredient == '양송이버섯')
        imageAsset.add('lib/assets/icons/채소류/양송이버섯.png');
      else if (ingredient == '양파')
        imageAsset.add('lib/assets/icons/채소류/양파.png');
      else if (ingredient == '오이')
        imageAsset.add('lib/assets/icons/채소류/오이.png');
      else if (ingredient == '청경채')
        imageAsset.add('lib/assets/icons/채소류/청경채.png');
      else if (ingredient == '케일')
        imageAsset.add('lib/assets/icons/채소류/케일.png');
      else if (ingredient == '콩')
        imageAsset.add('lib/assets/icons/채소류/콩.png');
      else if (ingredient == '콩나물')
        imageAsset.add('lib/assets/icons/채소류/콩나물.png');
      else if (ingredient == '토마토')
        imageAsset.add('lib/assets/icons/채소류/토마토.png');
      else if (ingredient == '파')
        imageAsset.add('lib/assets/icons/채소류/파.png');
      else if (ingredient == '파슬리')
        imageAsset.add('lib/assets/icons/채소류/파슬리.png');
      else if (ingredient == '파프리카')
        imageAsset.add('lib/assets/icons/채소류/파프리카.png');
      else if (ingredient == '팽이버섯')
        imageAsset.add('lib/assets/icons/채소류/팽이버섯.png');
      else if (ingredient == '표고버섯')
        imageAsset.add('lib/assets/icons/채소류/표고버섯.png');
      else if (ingredient == '호박')
        imageAsset.add('lib/assets/icons/채소류/호박.png');
      else if (ingredient == '피망')
        imageAsset.add('lib/assets/icons/채소류/피망.png');
      else if (ingredient == '새송이버섯')
        imageAsset.add('lib/assets/icons/채소류/버섯.png');
      else if (ingredient == '깨')
        imageAsset.add('lib/assets/icons/콩견과류/깨.png');
      else if (ingredient == '두부')
        imageAsset.add('lib/assets/icons/콩견과류/두부.png');
      else if (ingredient == '아몬드')
        imageAsset.add('lib/assets/icons/콩견과류/아몬드.png');
      else if (ingredient == '청국장')
        imageAsset.add('lib/assets/icons/콩견과류/청국장.png');
      else if (ingredient == '콩')
        imageAsset.add('lib/assets/icons/콩견과류/콩.png');
      else if (ingredient == '호두')
        imageAsset.add('lib/assets/icons/콩견과류/호두.png');
      else if (ingredient == '갈치')
        imageAsset.add('lib/assets/icons/해산물/갈치.png');
      else if (ingredient == '게맛살')
        imageAsset.add('lib/assets/icons/해산물/게맛살.png');
      else if (ingredient == '고등어')
        imageAsset.add('lib/assets/icons/해산물/고등어.png');
      else if (ingredient == '골뱅이')
        imageAsset.add('lib/assets/icons/해산물/골뱅이.png');
      else if (ingredient == '굴')
        imageAsset.add('lib/assets/icons/해산물/굴.png');
      else if (ingredient == '꽁치')
        imageAsset.add('lib/assets/icons/해산물/꽁치.png');
      else if (ingredient == '낙지')
        imageAsset.add('lib/assets/icons/해산물/낙지.png');
      else if (ingredient == '다시마')
        imageAsset.add('lib/assets/icons/해산물/다시마.png');
      else if (ingredient == '동태')
        imageAsset.add('lib/assets/icons/해산물/동태.png');
      else if (ingredient == '멸치')
        imageAsset.add('lib/assets/icons/해산물/멸치.png');
      else if (ingredient == '문어')
        imageAsset.add('lib/assets/icons/해산물/문어.png');
      else if (ingredient == '미역')
        imageAsset.add('lib/assets/icons/해산물/미역.png');
      else if (ingredient == '새우')
        imageAsset.add('lib/assets/icons/해산물/새우.png');
      else if (ingredient == '오징어')
        imageAsset.add('lib/assets/icons/해산물/오징어.png');
      else if (ingredient == '전복')
        imageAsset.add('lib/assets/icons/해산물/전복.png');
      else if (ingredient == '조개')
        imageAsset.add('lib/assets/icons/해산물/조개.png');
      else if (ingredient == '조기')
        imageAsset.add('lib/assets/icons/해산물/조기.png');
      else if (ingredient == '쭈꾸미')
        imageAsset.add('lib/assets/icons/해산물/쭈꾸미.png');
      else if (ingredient == '베이컨')
        imageAsset.add('lib/assets/icons/햄소시지/베이컨.png');
      else if (ingredient == '비엔나소시지')
        imageAsset.add('lib/assets/icons/햄소시지/비엔나소시지.png');
      else if (ingredient == '소시지')
        imageAsset.add('lib/assets/icons/햄소시지/소시지.png');
      else if (ingredient == '햄') imageAsset.add('lib/assets/icons/햄소시지/햄.png');
    }

    Set<String> tmpIng;
    tmpIng = imageAsset.toSet();
    imageAsset = tmpIng.toList();
    print('userIngredient');
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Wrap(
          children: [
            for (int n = 0; n < imageAsset.length; n++)
              homeIngredient(
                imageAsset[n],
                widget.setRemoveIngredient,
                widget.cancelRemoveIngredient,
              ),
          ],
        ),
      ),
    );
  }




  Future distinctIngredient(String str) async {
    List<String> tmp = findIngredient(str);
    tmp.toSet();
    for (int i = 0; i < tmp.length; i++) {
      if (kDebugMode) {
        print(tmp[i]);
      }
    }

    print(tmp.toString());
    _userProvider.ingredients.clear();
    _userProvider.addIngredient(tmp);

    await FirebaseFirestore.instance
        .collection("User")
        .doc(_userProvider.uid)
        .set(
      {
        "Ingredient": _userProvider.ingredients,
      } , SetOptions(merge: true),
    );
  }







}

class homeIngredient extends StatefulWidget {
  final String url;
  final Function setRemoveIngredient;
  final Function cancelRemoveIngredient;

  const homeIngredient(
      this.url, this.setRemoveIngredient, this.cancelRemoveIngredient,
      {super.key});

  @override
  State<homeIngredient> createState() => _homeIngredientState();
}

class _homeIngredientState extends State<homeIngredient> {
  late bool _hasPressed = false;

  @override
  Widget build(BuildContext context) {
    List<String> s = widget.url.split('/');
    List<String> ingName = s[s.length - 1].split('.');
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Column(
            children: [
              ElevatedButton(
                child: Image.asset(
                  widget.url,
                  height: 50,
                  width: 50,
                ),
                onPressed: () {
                  setState(() {
                    _hasPressed = !_hasPressed;

                    print(_hasPressed);
                    if (_hasPressed) {
                      widget.setRemoveIngredient(ingName[0]);
                    } else {
                      widget.cancelRemoveIngredient(ingName[0]);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  minimumSize: Size(30, 30),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
              Text('${ingName[0]}')
            ],
          ),
          Visibility(
            child: Icon(
              Icons.check_circle,
              color: Palette.blue,
            ),
            visible: _hasPressed,
          )
        ],
      ),
    );
  }






}
