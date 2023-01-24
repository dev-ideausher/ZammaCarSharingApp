import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'client.dart';
import 'endpoints.dart';

class APIManager {
  ///Post API
  static Future<Response> postApiExample({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.baseUrl, data: jsonEncode(body));

  static Future<Response> checkIsUserOnBoard() async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false).post(
          Endpoints.onBoardStatus,
          );
  static Future<Response> onBoardUser({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).post(
        Endpoints.onBoardApi,data: jsonEncode(body)
      );

  static Future<Response> getCateories() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.getCategories);

  static Future<Response> getCars() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.getAllCars);

  static Future<Response> getCarsByCategory({required String cat}) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
          .get(Endpoints.getAllCars+"?category=$cat");

  static Future<Response> updateDetails({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
          .patch(Endpoints.upDateDetails+"${Get.find<GlobalData>().userId}",data: jsonEncode(body));
}
