///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class RideHistoryDataInspectionsCarImagesAfterRide {
/*
{
  "respectiveSide": "Front Hood",
  "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
  "_id": "63a41224058e23a2fafbfe6b"
}
*/

  String? respectiveSide;
  String? image;
  String? Id;

  RideHistoryDataInspectionsCarImagesAfterRide({
    this.respectiveSide,
    this.image,
    this.Id,
  });
  RideHistoryDataInspectionsCarImagesAfterRide.fromJson(Map<String, dynamic> json) {
    respectiveSide = json['respectiveSide']?.toString();
    image = json['image']?.toString();
    Id = json['_id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['respectiveSide'] = respectiveSide;
    data['image'] = image;
    data['_id'] = Id;
    return data;
  }
}

class RideHistoryDataInspectionsCarImagesBeforeRide {
/*
{
  "respectiveSide": "Front Hood",
  "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-CAP127037721996105517.jpg",
  "_id": "64706bf030f1752ff424a387"
}
*/

  String? respectiveSide;
  String? image;
  String? Id;

  RideHistoryDataInspectionsCarImagesBeforeRide({
    this.respectiveSide,
    this.image,
    this.Id,
  });
  RideHistoryDataInspectionsCarImagesBeforeRide.fromJson(Map<String, dynamic> json) {
    respectiveSide = json['respectiveSide']?.toString();
    image = json['image']?.toString();
    Id = json['_id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['respectiveSide'] = respectiveSide;
    data['image'] = image;
    data['_id'] = Id;
    return data;
  }
}

class RideHistoryDataInspections {
/*
{
  "_id": "64706bf030f1752ff424a386",
  "booking": "64706a5730f1752ff424a367",
  "carImagesBeforeRide": [
    {
      "respectiveSide": "Front Hood",
      "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-CAP127037721996105517.jpg",
      "_id": "64706bf030f1752ff424a387"
    }
  ],
  "carImagesAfterRide": [
    {
      "respectiveSide": "Front Hood",
      "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
      "_id": "63a41224058e23a2fafbfe6b"
    }
  ],
  "createdAt": "2023-05-26T08:21:04.462Z",
  "updatedAt": "2023-05-26T08:21:04.462Z"
}
*/

  String? Id;
  String? booking;
  List<RideHistoryDataInspectionsCarImagesBeforeRide?>? carImagesBeforeRide;
  List<RideHistoryDataInspectionsCarImagesAfterRide?>? carImagesAfterRide;
  String? createdAt;
  String? updatedAt;

  RideHistoryDataInspections({
    this.Id,
    this.booking,
    this.carImagesBeforeRide,
    this.carImagesAfterRide,
    this.createdAt,
    this.updatedAt,
  });
  RideHistoryDataInspections.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    booking = json['booking']?.toString();
    if (json['carImagesBeforeRide'] != null) {
      final v = json['carImagesBeforeRide'];
      final arr0 = <RideHistoryDataInspectionsCarImagesBeforeRide>[];
      v.forEach((v) {
        arr0.add(RideHistoryDataInspectionsCarImagesBeforeRide.fromJson(v));
      });
      carImagesBeforeRide = arr0;
    }
    if (json['carImagesAfterRide'] != null) {
      final v = json['carImagesAfterRide'];
      final arr0 = <RideHistoryDataInspectionsCarImagesAfterRide>[];
      v.forEach((v) {
        arr0.add(RideHistoryDataInspectionsCarImagesAfterRide.fromJson(v));
      });
      carImagesAfterRide = arr0;
    }
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['booking'] = booking;
    if (carImagesBeforeRide != null) {
      final v = carImagesBeforeRide;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['carImagesBeforeRide'] = arr0;
    }
    if (carImagesAfterRide != null) {
      final v = carImagesAfterRide;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['carImagesAfterRide'] = arr0;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class RideHistoryDataDropLocation {
/*
{
  "type": "Point",
  "coordinates": [
    -121.264549
  ],
  "address": ""
}
*/

  String? type;
  List<double?>? coordinates;
  String? address;

  RideHistoryDataDropLocation({
    this.type,
    this.coordinates,
    this.address,
  });
  RideHistoryDataDropLocation.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toString();
    if (json['coordinates'] != null) {
      final v = json['coordinates'];
      final arr0 = <double>[];
      v.forEach((v) {
        arr0.add(v.toDouble());
      });
      coordinates = arr0;
    }
    address = json['address']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (coordinates != null) {
      final v = coordinates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['coordinates'] = arr0;
    }
    data['address'] = address;
    return data;
  }
}

class RideHistoryDataPickupLocation {
/*
{
  "type": "Point",
  "coordinates": [
    38.683975
  ],
  "address": "12801 Fair Oaks Blvd, ,California, 95610 "
}
*/

  String? type;
  List<double?>? coordinates;
  String? address;

  RideHistoryDataPickupLocation({
    this.type,
    this.coordinates,
    this.address,
  });
  RideHistoryDataPickupLocation.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toString();
    if (json['coordinates'] != null) {
      final v = json['coordinates'];
      final arr0 = <double>[];
      v.forEach((v) {
        arr0.add(v.toDouble());
      });
      coordinates = arr0;
    }
    address = json['address']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (coordinates != null) {
      final v = coordinates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['coordinates'] = arr0;
    }
    data['address'] = address;
    return data;
  }
}

class RideHistoryDataCarPosition {
/*
{
  "type": "Point",
  "coordinates": [
    -121.264549
  ]
}
*/

  String? type;
  List<double?>? coordinates;

  RideHistoryDataCarPosition({
    this.type,
    this.coordinates,
  });
  RideHistoryDataCarPosition.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toString();
    if (json['coordinates'] != null) {
      final v = json['coordinates'];
      final arr0 = <double>[];
      v.forEach((v) {
        arr0.add(v.toDouble());
      });
      coordinates = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (coordinates != null) {
      final v = coordinates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['coordinates'] = arr0;
    }
    return data;
  }
}

class RideHistoryDataCar {
/*
{
  "_id": "63f377e5d6cc2f883de290ce",
  "brand": "Toyota",
  "model": "Prius",
  "qnr": "6DB9853D00FFF005",
  "seatCapacity": 5,
  "color": "White",
  "carType": "fuel",
  "images": [
    "https://zammadl.s3.us-west-1.amazonaws.com/zammadl-2021_toyota_prius_prime_angularfront.jpg"
  ],
  "isDamaged": false,
  "status": "active",
  "position": {
    "type": "Point",
    "coordinates": [
      -121.264549
    ]
  },
  "bookingStatus": "booked",
  "isDeleted": false,
  "createdAt": "2023-02-20T13:38:45.912Z",
  "updatedAt": "2023-05-26T08:34:56.240Z",
  "category": "sedan",
  "fuelType": "fuel",
  "bluetooth_connection": "disconnected",
  "board_voltage": 12.5,
  "central_lock": "locked",
  "ignition": "off",
  "immobilizer": "unlocked",
  "mileage": 0,
  "mileage_since_immobilizer_unlock": 0,
  "alarm_input": "off",
  "alarm_input_2": "off",
  "central_lock_last_command": "locked",
  "low_battery_level_alarm": false,
  "low_fuel_level_alarm": false,
  "relay_value": 0,
  "fuel_level": 62,
  "speed": 0,
  "qrCodeImage": "https://www.hellotech.com/guide/wp-content/uploads/2020/05/HelloTech-qr-code.jpg"
}
*/

  String? Id;
  String? brand;
  String? model;
  String? qnr;
  int? seatCapacity;
  String? color;
  String? carType;
  List<String?>? images;
  bool? isDamaged;
  String? status;
  RideHistoryDataCarPosition? position;
  String? bookingStatus;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? category;
  String? fuelType;
  String? bluetoothConnection;
  double? boardVoltage;
  String? centralLock;
  String? ignition;
  String? immobilizer;
  int? mileage;
  int? mileageSinceImmobilizerUnlock;
  String? alarmInput;
  String? alarmInput_2;
  String? centralLockLastCommand;
  bool? lowBatteryLevelAlarm;
  bool? lowFuelLevelAlarm;
  int? relayValue;
  int? fuelLevel;
  int? speed;
  String? qrCodeImage;

  RideHistoryDataCar({
    this.Id,
    this.brand,
    this.model,
    this.qnr,
    this.seatCapacity,
    this.color,
    this.carType,
    this.images,
    this.isDamaged,
    this.status,
    this.position,
    this.bookingStatus,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.fuelType,
    this.bluetoothConnection,
    this.boardVoltage,
    this.centralLock,
    this.ignition,
    this.immobilizer,
    this.mileage,
    this.mileageSinceImmobilizerUnlock,
    this.alarmInput,
    this.alarmInput_2,
    this.centralLockLastCommand,
    this.lowBatteryLevelAlarm,
    this.lowFuelLevelAlarm,
    this.relayValue,
    this.fuelLevel,
    this.speed,
    this.qrCodeImage,
  });
  RideHistoryDataCar.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    brand = json['brand']?.toString();
    model = json['model']?.toString();
    qnr = json['qnr']?.toString();
    seatCapacity = json['seatCapacity']?.toInt();
    color = json['color']?.toString();
    carType = json['carType']?.toString();
    if (json['images'] != null) {
      final v = json['images'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      images = arr0;
    }
    isDamaged = json['isDamaged'];
    status = json['status']?.toString();
    position = (json['position'] != null) ? RideHistoryDataCarPosition.fromJson(json['position']) : null;
    bookingStatus = json['bookingStatus']?.toString();
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    category = json['category']?.toString();
    fuelType = json['fuelType']?.toString();
    bluetoothConnection = json['bluetooth_connection']?.toString();
    boardVoltage = json['board_voltage']?.toDouble();
    centralLock = json['central_lock']?.toString();
    ignition = json['ignition']?.toString();
    immobilizer = json['immobilizer']?.toString();
    mileage = json['mileage']?.toInt();
    mileageSinceImmobilizerUnlock = json['mileage_since_immobilizer_unlock']?.toInt();
    alarmInput = json['alarm_input']?.toString();
    alarmInput_2 = json['alarm_input_2']?.toString();
    centralLockLastCommand = json['central_lock_last_command']?.toString();
    lowBatteryLevelAlarm = json['low_battery_level_alarm'];
    lowFuelLevelAlarm = json['low_fuel_level_alarm'];
    relayValue = json['relay_value']?.toInt();
    fuelLevel = json['fuel_level']?.toInt();
    speed = json['speed']?.toInt();
    qrCodeImage = json['qrCodeImage']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['brand'] = brand;
    data['model'] = model;
    data['qnr'] = qnr;
    data['seatCapacity'] = seatCapacity;
    data['color'] = color;
    data['carType'] = carType;
    if (images != null) {
      final v = images;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['images'] = arr0;
    }
    data['isDamaged'] = isDamaged;
    data['status'] = status;
    if (position != null) {
      data['position'] = position!.toJson();
    }
    data['bookingStatus'] = bookingStatus;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['category'] = category;
    data['fuelType'] = fuelType;
    data['bluetooth_connection'] = bluetoothConnection;
    data['board_voltage'] = boardVoltage;
    data['central_lock'] = centralLock;
    data['ignition'] = ignition;
    data['immobilizer'] = immobilizer;
    data['mileage'] = mileage;
    data['mileage_since_immobilizer_unlock'] = mileageSinceImmobilizerUnlock;
    data['alarm_input'] = alarmInput;
    data['alarm_input_2'] = alarmInput_2;
    data['central_lock_last_command'] = centralLockLastCommand;
    data['low_battery_level_alarm'] = lowBatteryLevelAlarm;
    data['low_fuel_level_alarm'] = lowFuelLevelAlarm;
    data['relay_value'] = relayValue;
    data['fuel_level'] = fuelLevel;
    data['speed'] = speed;
    data['qrCodeImage'] = qrCodeImage;
    return data;
  }
}

class RideHistoryDataUserStripeCards {
/*
{
  "encryptedCode": "U2FsdGVkX1+W4TCBMcZNJC0Tk6R+kdN/x186dIePUxiu1KDtQCijARM8FPU6T+Bm4QEN/Wtc7l8hXs22busRnkvpQ1Xoc7wuRDwB0qhI+U1lCndFFnKMjLNbPNksLtP+q0Qv1jNIQFFt/UR9FBMlN7v7Tb4F9HRgUTfCjATvIEk=",
  "stripeCardId": "card_1N5lqvERG4ZXrlcJ1xsAzT9V",
  "_id": "645a035a49fea5271de9d913"
}
*/

  String? encryptedCode;
  String? stripeCardId;
  String? Id;

  RideHistoryDataUserStripeCards({
    this.encryptedCode,
    this.stripeCardId,
    this.Id,
  });
  RideHistoryDataUserStripeCards.fromJson(Map<String, dynamic> json) {
    encryptedCode = json['encryptedCode']?.toString();
    stripeCardId = json['stripeCardId']?.toString();
    Id = json['_id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['encryptedCode'] = encryptedCode;
    data['stripeCardId'] = stripeCardId;
    data['_id'] = Id;
    return data;
  }
}

class RideHistoryDataUserInsurance {
/*
{
  "insuranceNumber": "1234512345",
  "validTill": "09-09-1234",
  "image": "https://miro.medium.com/max/1400/1*Lm9aFB_p9Bx8afzwx6KvlA.png"
}
*/

  String? insuranceNumber;
  String? validTill;
  String? image;

  RideHistoryDataUserInsurance({
    this.insuranceNumber,
    this.validTill,
    this.image,
  });
  RideHistoryDataUserInsurance.fromJson(Map<String, dynamic> json) {
    insuranceNumber = json['insuranceNumber']?.toString();
    validTill = json['validTill']?.toString();
    image = json['image']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['insuranceNumber'] = insuranceNumber;
    data['validTill'] = validTill;
    data['image'] = image;
    return data;
  }
}

class RideHistoryDataUserDl {
/*
{
  "licenceNumber": "1234567890",
  "validTill": "02-09-1995",
  "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
}
*/

  String? licenceNumber;
  String? validTill;
  String? image;

  RideHistoryDataUserDl({
    this.licenceNumber,
    this.validTill,
    this.image,
  });
  RideHistoryDataUserDl.fromJson(Map<String, dynamic> json) {
    licenceNumber = json['licenceNumber']?.toString();
    validTill = json['validTill']?.toString();
    image = json['image']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['licenceNumber'] = licenceNumber;
    data['validTill'] = validTill;
    data['image'] = image;
    return data;
  }
}

class RideHistoryDataUser {
/*
{
  "_id": "6388c33fc6b2d524a07fdc15",
  "name": "pushpam kumar",
  "phone": "+919999999999",
  "email": "p .singh@gmail.com",
  "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-image_picker1943085984164623910.jpg",
  "role": "user",
  "firebaseUid": "UcN7eGb1oVShfCwm3Ogwry6q9T93",
  "firebaseSignInProvider": "phone",
  "gender": "male",
  "dl": {
    "licenceNumber": "1234567890",
    "validTill": "02-09-1995",
    "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
  },
  "insurance": {
    "insuranceNumber": "1234512345",
    "validTill": "09-09-1234",
    "image": "https://miro.medium.com/max/1400/1*Lm9aFB_p9Bx8afzwx6KvlA.png"
  },
  "address": "Janakpuri Delhi",
  "suspensionReason": "Driving outside zone.",
  "isSuspended": false,
  "noOfRides": 18,
  "isDeleted": false,
  "createdAt": "2022-12-01T15:07:43.680Z",
  "updatedAt": "2023-05-26T08:14:16.194Z",
  "dob": "1999-05-09T00:00:00.000Z",
  "isApproved": true,
  "totalTravelKm": 0,
  "stripeCustomerId": "cus_NrUqU0rlJ0QffW",
  "stripeCardId": "card_1N8iJAERG4ZXrlcJoahvhnXr",
  "stripeCards": [
    {
      "encryptedCode": "U2FsdGVkX1+W4TCBMcZNJC0Tk6R+kdN/x186dIePUxiu1KDtQCijARM8FPU6T+Bm4QEN/Wtc7l8hXs22busRnkvpQ1Xoc7wuRDwB0qhI+U1lCndFFnKMjLNbPNksLtP+q0Qv1jNIQFFt/UR9FBMlN7v7Tb4F9HRgUTfCjATvIEk=",
      "stripeCardId": "card_1N5lqvERG4ZXrlcJ1xsAzT9V",
      "_id": "645a035a49fea5271de9d913"
    }
  ]
}
*/

  String? Id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? role;
  String? firebaseUid;
  String? firebaseSignInProvider;
  String? gender;
  RideHistoryDataUserDl? dl;
  RideHistoryDataUserInsurance? insurance;
  String? address;
  String? suspensionReason;
  bool? isSuspended;
  int? noOfRides;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? dob;
  bool? isApproved;
  int? totalTravelKm;
  String? stripeCustomerId;
  String? stripeCardId;
  List<RideHistoryDataUserStripeCards?>? stripeCards;

  RideHistoryDataUser({
    this.Id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.role,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.gender,
    this.dl,
    this.insurance,
    this.address,
    this.suspensionReason,
    this.isSuspended,
    this.noOfRides,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.dob,
    this.isApproved,
    this.totalTravelKm,
    this.stripeCustomerId,
    this.stripeCardId,
    this.stripeCards,
  });
  RideHistoryDataUser.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    name = json['name']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    image = json['image']?.toString();
    role = json['role']?.toString();
    firebaseUid = json['firebaseUid']?.toString();
    firebaseSignInProvider = json['firebaseSignInProvider']?.toString();
    gender = json['gender']?.toString();
    dl = (json['dl'] != null) ? RideHistoryDataUserDl.fromJson(json['dl']) : null;
    insurance = (json['insurance'] != null) ? RideHistoryDataUserInsurance.fromJson(json['insurance']) : null;
    address = json['address']?.toString();
    suspensionReason = json['suspensionReason']?.toString();
    isSuspended = json['isSuspended'];
    noOfRides = json['noOfRides']?.toInt();
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    dob = json['dob']?.toString();
    isApproved = json['isApproved'];
    totalTravelKm = json['totalTravelKm']?.toInt();
    stripeCustomerId = json['stripeCustomerId']?.toString();
    stripeCardId = json['stripeCardId']?.toString();
    if (json['stripeCards'] != null) {
      final v = json['stripeCards'];
      final arr0 = <RideHistoryDataUserStripeCards>[];
      v.forEach((v) {
        arr0.add(RideHistoryDataUserStripeCards.fromJson(v));
      });
      stripeCards = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['role'] = role;
    data['firebaseUid'] = firebaseUid;
    data['firebaseSignInProvider'] = firebaseSignInProvider;
    data['gender'] = gender;
    if (dl != null) {
      data['dl'] = dl!.toJson();
    }
    if (insurance != null) {
      data['insurance'] = insurance!.toJson();
    }
    data['address'] = address;
    data['suspensionReason'] = suspensionReason;
    data['isSuspended'] = isSuspended;
    data['noOfRides'] = noOfRides;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['dob'] = dob;
    data['isApproved'] = isApproved;
    data['totalTravelKm'] = totalTravelKm;
    data['stripeCustomerId'] = stripeCustomerId;
    data['stripeCardId'] = stripeCardId;
    if (stripeCards != null) {
      final v = stripeCards;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['stripeCards'] = arr0;
    }
    return data;
  }
}

class RideHistoryData {
/*
{
  "_id": "64706a5730f1752ff424a367",
  "user": {
    "_id": "6388c33fc6b2d524a07fdc15",
    "name": "pushpam kumar",
    "phone": "+919999999999",
    "email": "p .singh@gmail.com",
    "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-image_picker1943085984164623910.jpg",
    "role": "user",
    "firebaseUid": "UcN7eGb1oVShfCwm3Ogwry6q9T93",
    "firebaseSignInProvider": "phone",
    "gender": "male",
    "dl": {
      "licenceNumber": "1234567890",
      "validTill": "02-09-1995",
      "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
    },
    "insurance": {
      "insuranceNumber": "1234512345",
      "validTill": "09-09-1234",
      "image": "https://miro.medium.com/max/1400/1*Lm9aFB_p9Bx8afzwx6KvlA.png"
    },
    "address": "Janakpuri Delhi",
    "suspensionReason": "Driving outside zone.",
    "isSuspended": false,
    "noOfRides": 18,
    "isDeleted": false,
    "createdAt": "2022-12-01T15:07:43.680Z",
    "updatedAt": "2023-05-26T08:14:16.194Z",
    "dob": "1999-05-09T00:00:00.000Z",
    "isApproved": true,
    "totalTravelKm": 0,
    "stripeCustomerId": "cus_NrUqU0rlJ0QffW",
    "stripeCardId": "card_1N8iJAERG4ZXrlcJoahvhnXr",
    "stripeCards": [
      {
        "encryptedCode": "U2FsdGVkX1+W4TCBMcZNJC0Tk6R+kdN/x186dIePUxiu1KDtQCijARM8FPU6T+Bm4QEN/Wtc7l8hXs22busRnkvpQ1Xoc7wuRDwB0qhI+U1lCndFFnKMjLNbPNksLtP+q0Qv1jNIQFFt/UR9FBMlN7v7Tb4F9HRgUTfCjATvIEk=",
        "stripeCardId": "card_1N5lqvERG4ZXrlcJ1xsAzT9V",
        "_id": "645a035a49fea5271de9d913"
      }
    ]
  },
  "car": {
    "_id": "63f377e5d6cc2f883de290ce",
    "brand": "Toyota",
    "model": "Prius",
    "qnr": "6DB9853D00FFF005",
    "seatCapacity": 5,
    "color": "White",
    "carType": "fuel",
    "images": [
      "https://zammadl.s3.us-west-1.amazonaws.com/zammadl-2021_toyota_prius_prime_angularfront.jpg"
    ],
    "isDamaged": false,
    "status": "active",
    "position": {
      "type": "Point",
      "coordinates": [
        -121.264549
      ]
    },
    "bookingStatus": "booked",
    "isDeleted": false,
    "createdAt": "2023-02-20T13:38:45.912Z",
    "updatedAt": "2023-05-26T08:34:56.240Z",
    "category": "sedan",
    "fuelType": "fuel",
    "bluetooth_connection": "disconnected",
    "board_voltage": 12.5,
    "central_lock": "locked",
    "ignition": "off",
    "immobilizer": "unlocked",
    "mileage": 0,
    "mileage_since_immobilizer_unlock": 0,
    "alarm_input": "off",
    "alarm_input_2": "off",
    "central_lock_last_command": "locked",
    "low_battery_level_alarm": false,
    "low_fuel_level_alarm": false,
    "relay_value": 0,
    "fuel_level": 62,
    "speed": 0,
    "qrCodeImage": "https://www.hellotech.com/guide/wp-content/uploads/2020/05/HelloTech-qr-code.jpg"
  },
  "qnr": "6DB9853D00FFF005",
  "status": "ongoing",
  "pickupTime": "2023-05-26T08:21:06.405Z",
  "pickupLocation": {
    "type": "Point",
    "coordinates": [
      38.683975
    ],
    "address": "12801 Fair Oaks Blvd, ,California, 95610 "
  },
  "dropTime": "",
  "dropLocation": {
    "type": "Point",
    "coordinates": [
      -121.264549
    ],
    "address": ""
  },
  "cancelReason": "",
  "cancelledBy": "",
  "isPaymentSuccess": false,
  "paymentMethod": "",
  "rideEndedBy": "user",
  "waitingTime": 465,
  "additionalWaitingTime": 0,
  "tripTime": 0,
  "path": [
    [
      "38.683971"
    ]
  ],
  "isDeleted": false,
  "createdAt": "2023-05-26T08:14:15.574Z",
  "updatedAt": "2023-05-26T08:34:56.662Z",
  "paymentStep": "initialPayment",
  "inspections": {
    "_id": "64706bf030f1752ff424a386",
    "booking": "64706a5730f1752ff424a367",
    "carImagesBeforeRide": [
      {
        "respectiveSide": "Front Hood",
        "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-CAP127037721996105517.jpg",
        "_id": "64706bf030f1752ff424a387"
      }
    ],
    "carImagesAfterRide": [
      {
        "respectiveSide": "Front Hood",
        "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
        "_id": "63a41224058e23a2fafbfe6b"
      }
    ],
    "createdAt": "2023-05-26T08:21:04.462Z",
    "updatedAt": "2023-05-26T08:21:04.462Z"
  },
  "totalAmount": 1
}
*/

  String? Id;
  RideHistoryDataUser? user;
  RideHistoryDataCar? car;
  String? qnr;
  String? status;
  String? pickupTime;
  RideHistoryDataPickupLocation? pickupLocation;
  String? dropTime;
  RideHistoryDataDropLocation? dropLocation;
  String? cancelReason;
  String? cancelledBy;
  bool? isPaymentSuccess;
  String? paymentMethod;
  String? rideEndedBy;
  int? waitingTime;
  int? additionalWaitingTime;
  int? tripTime;
  List<List<String?>?>? path;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? paymentStep;
  RideHistoryDataInspections? inspections;
  int? totalAmount;

  RideHistoryData({
    this.Id,
    this.user,
    this.car,
    this.qnr,
    this.status,
    this.pickupTime,
    this.pickupLocation,
    this.dropTime,
    this.dropLocation,
    this.cancelReason,
    this.cancelledBy,
    this.isPaymentSuccess,
    this.paymentMethod,
    this.rideEndedBy,
    this.waitingTime,
    this.additionalWaitingTime,
    this.tripTime,
    this.path,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.paymentStep,
    this.inspections,
    this.totalAmount,
  });
  RideHistoryData.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    user = (json['user'] != null) ? RideHistoryDataUser.fromJson(json['user']) : null;
    car = (json['car'] != null) ? RideHistoryDataCar.fromJson(json['car']) : null;
    qnr = json['qnr']?.toString();
    status = json['status']?.toString();
    pickupTime = json['pickupTime']?.toString();
    pickupLocation = (json['pickupLocation'] != null) ? RideHistoryDataPickupLocation.fromJson(json['pickupLocation']) : null;
    dropTime = json['dropTime']?.toString();
    dropLocation = (json['dropLocation'] != null) ? RideHistoryDataDropLocation.fromJson(json['dropLocation']) : null;
    cancelReason = json['cancelReason']?.toString();
    cancelledBy = json['cancelledBy']?.toString();
    isPaymentSuccess = json['isPaymentSuccess'];
    paymentMethod = json['paymentMethod']?.toString();
    rideEndedBy = json['rideEndedBy']?.toString();
    waitingTime = json['waitingTime']?.toInt();
    additionalWaitingTime = json['additionalWaitingTime']?.toInt();
    tripTime = json['tripTime']?.toInt();
    if (json['path'] != null) {
      final v = json['path'];
      final arr0 = <List<String>>[];
      v.forEach((v) {
        final arr1 = <String>[];
        v.forEach((v) {
          arr1.add(v.toString());
        });
        arr0.add(arr1);
      });
      path = arr0;
    }
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    paymentStep = json['paymentStep']?.toString();
    inspections = (json['inspections'] != null) ? RideHistoryDataInspections.fromJson(json['inspections']) : null;
    totalAmount = json['totalAmount']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['qnr'] = qnr;
    data['status'] = status;
    data['pickupTime'] = pickupTime;
    if (pickupLocation != null) {
      data['pickupLocation'] = pickupLocation!.toJson();
    }
    data['dropTime'] = dropTime;
    if (dropLocation != null) {
      data['dropLocation'] = dropLocation!.toJson();
    }
    data['cancelReason'] = cancelReason;
    data['cancelledBy'] = cancelledBy;
    data['isPaymentSuccess'] = isPaymentSuccess;
    data['paymentMethod'] = paymentMethod;
    data['rideEndedBy'] = rideEndedBy;
    data['waitingTime'] = waitingTime;
    data['additionalWaitingTime'] = additionalWaitingTime;
    data['tripTime'] = tripTime;
    if (path != null) {
      final v = path;
      final arr0 = [];
      v!.forEach((v) {
        final arr1 = [];
        v!.forEach((v) {
          arr1.add(v);
        });
        arr0.add(arr1);
      });
      data['path'] = arr0;
    }
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['paymentStep'] = paymentStep;
    if (inspections != null) {
      data['inspections'] = inspections!.toJson();
    }
    data['totalAmount'] = totalAmount;
    return data;
  }
}

class RideHistory {
/*
{
  "status": true,
  "message": "All bookings Of a user .",
  "results": 1,
  "data": [
    {
      "_id": "64706a5730f1752ff424a367",
      "user": {
        "_id": "6388c33fc6b2d524a07fdc15",
        "name": "pushpam kumar",
        "phone": "+919999999999",
        "email": "p .singh@gmail.com",
        "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-image_picker1943085984164623910.jpg",
        "role": "user",
        "firebaseUid": "UcN7eGb1oVShfCwm3Ogwry6q9T93",
        "firebaseSignInProvider": "phone",
        "gender": "male",
        "dl": {
          "licenceNumber": "1234567890",
          "validTill": "02-09-1995",
          "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
        },
        "insurance": {
          "insuranceNumber": "1234512345",
          "validTill": "09-09-1234",
          "image": "https://miro.medium.com/max/1400/1*Lm9aFB_p9Bx8afzwx6KvlA.png"
        },
        "address": "Janakpuri Delhi",
        "suspensionReason": "Driving outside zone.",
        "isSuspended": false,
        "noOfRides": 18,
        "isDeleted": false,
        "createdAt": "2022-12-01T15:07:43.680Z",
        "updatedAt": "2023-05-26T08:14:16.194Z",
        "dob": "1999-05-09T00:00:00.000Z",
        "isApproved": true,
        "totalTravelKm": 0,
        "stripeCustomerId": "cus_NrUqU0rlJ0QffW",
        "stripeCardId": "card_1N8iJAERG4ZXrlcJoahvhnXr",
        "stripeCards": [
          {
            "encryptedCode": "U2FsdGVkX1+W4TCBMcZNJC0Tk6R+kdN/x186dIePUxiu1KDtQCijARM8FPU6T+Bm4QEN/Wtc7l8hXs22busRnkvpQ1Xoc7wuRDwB0qhI+U1lCndFFnKMjLNbPNksLtP+q0Qv1jNIQFFt/UR9FBMlN7v7Tb4F9HRgUTfCjATvIEk=",
            "stripeCardId": "card_1N5lqvERG4ZXrlcJ1xsAzT9V",
            "_id": "645a035a49fea5271de9d913"
          }
        ]
      },
      "car": {
        "_id": "63f377e5d6cc2f883de290ce",
        "brand": "Toyota",
        "model": "Prius",
        "qnr": "6DB9853D00FFF005",
        "seatCapacity": 5,
        "color": "White",
        "carType": "fuel",
        "images": [
          "https://zammadl.s3.us-west-1.amazonaws.com/zammadl-2021_toyota_prius_prime_angularfront.jpg"
        ],
        "isDamaged": false,
        "status": "active",
        "position": {
          "type": "Point",
          "coordinates": [
            -121.264549
          ]
        },
        "bookingStatus": "booked",
        "isDeleted": false,
        "createdAt": "2023-02-20T13:38:45.912Z",
        "updatedAt": "2023-05-26T08:34:56.240Z",
        "category": "sedan",
        "fuelType": "fuel",
        "bluetooth_connection": "disconnected",
        "board_voltage": 12.5,
        "central_lock": "locked",
        "ignition": "off",
        "immobilizer": "unlocked",
        "mileage": 0,
        "mileage_since_immobilizer_unlock": 0,
        "alarm_input": "off",
        "alarm_input_2": "off",
        "central_lock_last_command": "locked",
        "low_battery_level_alarm": false,
        "low_fuel_level_alarm": false,
        "relay_value": 0,
        "fuel_level": 62,
        "speed": 0,
        "qrCodeImage": "https://www.hellotech.com/guide/wp-content/uploads/2020/05/HelloTech-qr-code.jpg"
      },
      "qnr": "6DB9853D00FFF005",
      "status": "ongoing",
      "pickupTime": "2023-05-26T08:21:06.405Z",
      "pickupLocation": {
        "type": "Point",
        "coordinates": [
          38.683975
        ],
        "address": "12801 Fair Oaks Blvd, ,California, 95610 "
      },
      "dropTime": "",
      "dropLocation": {
        "type": "Point",
        "coordinates": [
          -121.264549
        ],
        "address": ""
      },
      "cancelReason": "",
      "cancelledBy": "",
      "isPaymentSuccess": false,
      "paymentMethod": "",
      "rideEndedBy": "user",
      "waitingTime": 465,
      "additionalWaitingTime": 0,
      "tripTime": 0,
      "path": [
        [
          "38.683971"
        ]
      ],
      "isDeleted": false,
      "createdAt": "2023-05-26T08:14:15.574Z",
      "updatedAt": "2023-05-26T08:34:56.662Z",
      "paymentStep": "initialPayment",
      "inspections": {
        "_id": "64706bf030f1752ff424a386",
        "booking": "64706a5730f1752ff424a367",
        "carImagesBeforeRide": [
          {
            "respectiveSide": "Front Hood",
            "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-CAP127037721996105517.jpg",
            "_id": "64706bf030f1752ff424a387"
          }
        ],
        "carImagesAfterRide": [
          {
            "respectiveSide": "Front Hood",
            "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
            "_id": "63a41224058e23a2fafbfe6b"
          }
        ],
        "createdAt": "2023-05-26T08:21:04.462Z",
        "updatedAt": "2023-05-26T08:21:04.462Z"
      },
      "totalAmount": 1
    }
  ]
}
*/

  bool? status;
  String? message;
  int? results;
  List<RideHistoryData?>? data;

  RideHistory({
    this.status,
    this.message,
    this.results,
    this.data,
  });
  RideHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    results = json['results']?.toInt();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <RideHistoryData>[];
      v.forEach((v) {
        arr0.add(RideHistoryData.fromJson(v));
      });
      this.data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['results'] = results;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    return data;
  }
}
