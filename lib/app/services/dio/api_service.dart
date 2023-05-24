import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:zammacarsharing/app/services/dio/device_di_client.dart';
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
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.getAllCars);

  static Future<Response> getCarsByCategory({required String cat}) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
          .get(Endpoints.getAllCars+"?category=$cat");

  static Future<Response> updateDetails({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: false, isOverlayLoader: false)
          .patch(Endpoints.upDateDetails+"${Get.find<GlobalData>().userId}",data: jsonEncode(body));

  static Future<Response> postInspection({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).post(
          Endpoints.onBoardApi,data: jsonEncode(body)
      );

  static Future<Response> createBooking({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).post(
          Endpoints.createBooking,data: jsonEncode(body)
      );
  static Future<Response> cancelBooking({required dynamic body,required String bookingId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).patch(
          Endpoints.createBooking+"/$bookingId/cancel",data: jsonEncode(body)
      );
  static Future<Response> postInspectionImageUrl({required dynamic body,required String bookingId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).post(
          Endpoints.createBooking+"/$bookingId/inspection",data: jsonEncode(body)
      );
  static Future<Response> endInspectionImageUrl({required dynamic body,required String bookingId}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).patch(
          Endpoints.createBooking+"/$bookingId/end-ride",data: jsonEncode(body)
      );
  static Future<Response> getRideHistory() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.getRideHistory+"?user=${Get.find<GetStorageService>().getCustomUserId}");

  static Future<Response> markBookingOngoing({required String bookingId,required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false).patch(
          Endpoints.createBooking+"/$bookingId",data: jsonEncode(body)
      );

  static Future<Response> getinProcessRideHistory() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.getRideHistory+"?user=${Get.find<GetStorageService>().getCustomUserId}&status=inprogress");

  static Future<Response> getOnGoingRideHistory() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.getRideHistory+"?user=${Get.find<GetStorageService>().getCustomUserId}&status=ongoing");

  static Future<Response> ReportAnIssue({required dynamic body}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true).post(
        Endpoints.reportIssue,data: jsonEncode(body)
      );

  static Future<Response> getSavedCards() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: false)
          .get(Endpoints.savedCards);

  static Future<Response> payment({required String bookingId,required dynamic body }) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .post(Endpoints.baseUrl+"booking/$bookingId/payment",data: jsonEncode(body));

  static Future<Response> getPaymentHistory({required String bookingid}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.createBooking+"/${bookingid}/trasactions");

  static Future<Response> getfinalRideHistory() async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.getRideHistory+"?user=${Get.find<GetStorageService>().getCustomUserId}");

//getLock Status
  static Future<Response> getLockStatus(String qnr,dynamic header) async =>
      await DeviceDioClient(Dio(), showSnakbar: true, isOverlayLoader: false,header:header )
          .get(Endpoints.getLockStatus+"$qnr/central-lock");
}
