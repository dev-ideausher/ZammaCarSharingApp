class Endpoints {
  Endpoints._();

  // base url
  //static const String baseUrl = "http://5.161.80.214/";
  static const String baseUrl = "https://api.symboldrive.com/";
  // receiveTimeout
  static const int receiveTimeout = 150000;

  // connectTimeout
  static const int connectionTimeout = 150000;

  static const String onBoardStatus = baseUrl+"user/login";
  static const String onBoardApi = baseUrl+"user/onboarding";
  static const String getCategories = baseUrl+"category";
  //static const String getAllCars = baseUrl+"car";
  static const String getAllCars = "https://api.symboldrive.com/car/all/app";
  static const String upDateDetails = baseUrl+"user/";
  static const String imapgeUpload = baseUrl+"file-upload";
  static const String inspection = baseUrl+"user/onboarding";
  static const String createBooking = baseUrl+"booking";
  static const String getRideHistory = baseUrl+"booking/all/user";
  static const String getinProcessRideHistory = baseUrl+"booking/all/user?status=inprogress";
  static const String reportIssue = baseUrl+"report-issue";
  static const String savedCards = baseUrl+"user/stripe/cards";
  static const String addCardDetails = baseUrl+"user/stripe/add-card";
  static const String getCoordinates = baseUrl+"zone/parking";
  static const String getCoordinatesZonePolygon = baseUrl+"zone/polygon";

  static const String totalPayments = baseUrl+"transactions/user";
  static const String getcarPricing = baseUrl+"car-pricing/car/";

  //static const String payment = baseUrl+"user/stripe/add-card";

  //Poc Api Call
  static const String PocBaseUrl = "https://api.cloudboxx.invers.com/";
  static const String getLockStatus = PocBaseUrl+"api/devices/";
 // https://api.cloudboxx.invers.com/api/devices/{qnr}/central-lock
}
