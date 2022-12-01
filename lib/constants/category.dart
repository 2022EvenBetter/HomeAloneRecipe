final List<String> upperCategoryList = ['가공/유제품', '육류', '곡물', '과일', '면' ,'빵/떡', '채소류','콩/견과류','해산물','햄/소시지','조미료/양념'];

String selectedUpper = '가공/유제품';

final List<String> processedFoodList=['계란', '참치캔', '모짜렐라치즈', '우유', '옥수수콘', '버터', '슬라이스치즈', '어묵'];
final List<String>  meatList=['닭고기','돼지고기','소고기','곱창','다짐육','양','장조림'];
final List<String>  grainList=['감자', '고구마', '밀가루', '빵가루', '부침가루', '옥수수', '찹쌀가루', '쌀'];
final List<String>  fruitList=['감', '체리', '사과', '아보카도', '바나나', '오렌지', '건포도', '딸기', '레몬', '배', '자몽', '키위', '파인애플', '포도'];
final List<String>  noodleList=['칼국수면', '파스타면', '우동면', '소면', '당면', '라면'];
final List<String>  breadList=['식빵', '떡국떡'];
final List<String>  vegetableList=['가지','감자','검은콩','고추','김치','깻잎','당근','대파','마늘','무','바질','배추','버섯','브로콜리','비트','상추',
  '샐러리','생강','시금치','아스파라거스','애호박','양배추','양송이버섯','양파','오이','청경채','케일','콩','콩나물','토마토','파','파슬리','파프리카','팽이버섯','표고버섯','피망','호박'];
final List<String>  beanList=['깨', '두부', '콩', '아몬드', '호두', '청국장'];
final List<String>  seaFoodList=['갈치','게맛살','고등어','골뱅이','굴','꽁치','낙지','다시마','동태','멸치','문어','미역','새우','오징어','전복','조개','조기','쭈꾸미'];
final List<String>  hamList=['베이컨', '비엔나소시지', '소시지', '햄'];
final List<String>  seasoningList=['간장','고추장','고춧가루','굴소스','다진마늘','된장','마요네즈','멸치액젓', '설탕','소금',
  '쇠고기 다시다','식초','쌈장','올리브유','참기름','카레가루','케첩','후추'];
final List<String> errorList=['다시 선택해주세요'];

List<String> setLowerCategory(String? selected){
  if(selected==upperCategoryList[0]){
    return processedFoodList;
  }else if(selected==upperCategoryList[1]){
    return meatList;
  }else if(selected==upperCategoryList[2]){
    return grainList;
  }else if(selected==upperCategoryList[3]){
    return fruitList;
  }else if(selected==upperCategoryList[4]){
    return noodleList;
  }else if(selected==upperCategoryList[5]){
    return breadList;
  }else if(selected==upperCategoryList[6]){
    return vegetableList;
  }else if(selected==upperCategoryList[7]){
    return beanList;
  }else if(selected==upperCategoryList[8]){
    return seaFoodList;
  }else if(selected==upperCategoryList[9]){
    return hamList;
  }else if(selected==upperCategoryList[10]){
    return seasoningList;
  }
  else{
    return errorList;
  }
}