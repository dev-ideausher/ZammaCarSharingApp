class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://5.161.80.214/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String onBoardStatus = baseUrl+"user/login";
  static const String onBoardApi = baseUrl+"user/onboarding";
  static const String getCategories = baseUrl+"category";
  static const String getAllCars = baseUrl+"car";
  static const String upDateDetails = baseUrl+"user/";
  static const String imapgeUpload = baseUrl+"file-upload";
}
