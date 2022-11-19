import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:home_alone_recipe/constants/apiKey.dart';

Future<String> getLocation() async {
  //경기도 성남시 수정구
  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  //현재위치를 position이라는 변수로 저장
  String lat = position.latitude.toString();
  String lon = position.longitude.toString();

  Response response = await get(
      Uri.parse(
          "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${lon},${lat}&sourcecrs=epsg:4326&output=json"),
      headers: headerss);
  String jsonData = response.body;
  var myJson_dong =
      jsonDecode(jsonData)["results"][1]['region']['area3']['name'];
  var myJson_gu = jsonDecode(jsonData)["results"][1]['region']['area2']['name'];
  var myJson_si = jsonDecode(jsonData)["results"][1]['region']['area1']['name'];

  String donggusi = myJson_si + " " + myJson_gu + " " + myJson_dong;

  print("update getLocation");
  return donggusi;
}

Future<String> getLocationUrl() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  //현재위치를 position이라는 변수로 저장
  String lat = position.latitude.toString();
  String lon = position.longitude.toString();
  String apiURL =
      'https://naveropenapi.apigw.ntruss.com/map-static/v2/raster?w=500&h=280&center=' +
          lon +
          ',' +
          lat +
          '&level=13';
  print("update getLocationURL");
  return apiURL;
}
