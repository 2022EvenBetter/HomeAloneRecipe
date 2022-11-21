import 'dart:ffi';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _uid="";
  String _email = ""; //사용자 이메일
  String _password = ""; //사용자 비밀번호
  String _location=""; //사용자 위치 (경기도 성남시 수정구 창곡동)
  String _nickname=""; //사용자 닉네임 (게시글 작성 시)
  String _scope=""; //사용자 위치 범위
  List<String> _ingredients=[]; //사용자 재료
  List<String> _recipes=[]; //사용자 스크랩한 레시피
  List<String> _posts=[]; //사용자 게시글

  String get uid=>_uid;
  String get email => _email;
  String get password => _password;
  String get location=>_location;
  String get nickname => _nickname;
  String get scope=>_scope;
  List<String> get ingredients=>_ingredients;
  List<String> get recipes=>_recipes;
  List<String> get posts=>_posts;


  void signup(String _uid, String _email, String _password, String _nickname){
    this._uid=_uid;
    this._email=_email;
    this._password=_password;
    this._nickname=_nickname;
    this._location="";
    this._scope="";
    this._ingredients=[];
    this._recipes=[];
    this._posts=[];
    notifyListeners();
  }

  void login( String _uid, String _email, String _password, String _nickname, String _location,
      String _scope, List<String> _ingredients, List<String> _recipes, List<String> _posts) {
    this._uid=_uid;
    this._email=_email;
    this._password=_password;
    this._nickname=_nickname;
    this._location=_location;
    this._scope=_scope;
    this._ingredients=_ingredients;
    this._recipes=_recipes;
    this._posts=_posts;
    notifyListeners();
  }

  void set uid(String input_uid){
    _uid=input_uid;
    notifyListeners();
  }

  void set email(String input_email) {
    _email = input_email;
    notifyListeners();
  }

  void set password(String input_password) {
    _password = input_password;
    notifyListeners();
  }

  void set location(String input_location){
    _location=input_location;
    notifyListeners();
  }

  void set nickname(String input_nickname){
    _nickname=input_nickname;
    notifyListeners();
  }

  void set scope(String input_scope){
    _scope=input_scope;
    notifyListeners();
  }

  void set ingredients(List<String> input_ingredients){
    _ingredients=input_ingredients;
    notifyListeners();
  }

  void set recipes(List<String> input_recipes){
    _recipes=input_recipes;
    notifyListeners();
  }

  void set posts(List<String> input_posts){
    _posts=input_posts;
    notifyListeners();
  }

  void addIngredient(List<String> input_ingredients){ //재료추가할 때는 list로 받기
    _ingredients.addAll(input_ingredients);
    notifyListeners();
  }

  void scrapRecipe(String recipeCode){
    _recipes.add(recipeCode);
    notifyListeners();
  }

  void addPost(String postId){
    _posts.add(postId);
    notifyListeners();
  }
}