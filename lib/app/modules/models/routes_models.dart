///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class BookingRoutesModelDataInspectionsCarImagesAfterRide {
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

  BookingRoutesModelDataInspectionsCarImagesAfterRide({
    this.respectiveSide,
    this.image,
    this.Id,
  });
  BookingRoutesModelDataInspectionsCarImagesAfterRide.fromJson(Map<String, dynamic> json) {
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

class BookingRoutesModelDataInspectionsCarImagesBeforeRide {
/*
{
  "respectiveSide": "Front Hood",
  "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-CAP3403461901841268839.jpg",
  "_id": "646b5a95611de76d1bc49c40"
}
*/

  String? respectiveSide;
  String? image;
  String? Id;

  BookingRoutesModelDataInspectionsCarImagesBeforeRide({
    this.respectiveSide,
    this.image,
    this.Id,
  });
  BookingRoutesModelDataInspectionsCarImagesBeforeRide.fromJson(Map<String, dynamic> json) {
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

class BookingRoutesModelDataInspections {
/*
{
  "_id": "646b5a95611de76d1bc49c3f",
  "booking": "646b5930611de76d1bc49bcd",
  "carImagesBeforeRide": [
    {
      "respectiveSide": "Front Hood",
      "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-CAP3403461901841268839.jpg",
      "_id": "646b5a95611de76d1bc49c40"
    }
  ],
  "carImagesAfterRide": [
    {
      "respectiveSide": "Front Hood",
      "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
      "_id": "63a41224058e23a2fafbfe6b"
    }
  ],
  "createdAt": "2023-05-22T12:05:41.190Z",
  "updatedAt": "2023-05-22T12:05:41.190Z"
}
*/

  String? Id;
  String? booking;
  List<BookingRoutesModelDataInspectionsCarImagesBeforeRide?>? carImagesBeforeRide;
  List<BookingRoutesModelDataInspectionsCarImagesAfterRide?>? carImagesAfterRide;
  String? createdAt;
  String? updatedAt;

  BookingRoutesModelDataInspections({
    this.Id,
    this.booking,
    this.carImagesBeforeRide,
    this.carImagesAfterRide,
    this.createdAt,
    this.updatedAt,
  });
  BookingRoutesModelDataInspections.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    booking = json['booking']?.toString();
    if (json['carImagesBeforeRide'] != null) {
      final v = json['carImagesBeforeRide'];
      final arr0 = <BookingRoutesModelDataInspectionsCarImagesBeforeRide>[];
      v.forEach((v) {
        arr0.add(BookingRoutesModelDataInspectionsCarImagesBeforeRide.fromJson(v));
      });
      carImagesBeforeRide = arr0;
    }
    if (json['carImagesAfterRide'] != null) {
      final v = json['carImagesAfterRide'];
      final arr0 = <BookingRoutesModelDataInspectionsCarImagesAfterRide>[];
      v.forEach((v) {
        arr0.add(BookingRoutesModelDataInspectionsCarImagesAfterRide.fromJson(v));
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

class BookingRoutesModelDataCarPosition {
/*
{
  "type": "Point",
  "coordinates": [
    -121.263054
  ]
}
*/

  String? type;
  List<double?>? coordinates;

  BookingRoutesModelDataCarPosition({
    this.type,
    this.coordinates,
  });
  BookingRoutesModelDataCarPosition.fromJson(Map<String, dynamic> json) {
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

class BookingRoutesModelDataCar {
/*
{
  "position": {
    "type": "Point",
    "coordinates": [
      -121.263054
    ]
  },
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
  "bookingStatus": "idle",
  "isDeleted": false,
  "createdAt": "2023-02-20T13:38:45.912Z",
  "updatedAt": "2023-08-24T08:54:58.724Z",
  "category": "sedan",
  "fuelType": "fuel",
  "bluetooth_connection": "disconnected",
  "board_voltage": 12.62,
  "ignition": "off",
  "immobilizer": "unlocked",
  "mileage": 25583,
  "mileage_since_immobilizer_unlock": 0,
  "alarm_input": "off",
  "alarm_input_2": "off",
  "low_battery_level_alarm": false,
  "low_fuel_level_alarm": false,
  "relay_value": 0,
  "qrCodeImage": "https://www.hellotech.com/guide/wp-content/uploads/2020/05/HelloTech-qr-code.jpg",
  "central_lock": "locked",
  "central_lock_last_command": "locked",
  "fuel_level": 79,
  "keyfob": "in",
  "vehicle_identification_number": "",
  "vehicle_license_plate": "",
  "speed": 0,
  "isPaused": false
}
*/

  BookingRoutesModelDataCarPosition? position;
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
  String? bookingStatus;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? category;
  String? fuelType;
  String? bluetoothConnection;
  double? boardVoltage;
  String? ignition;
  String? immobilizer;
  int? mileage;
  int? mileageSinceImmobilizerUnlock;
  String? alarmInput;
  String? alarmInput_2;
  bool? lowBatteryLevelAlarm;
  bool? lowFuelLevelAlarm;
  int? relayValue;
  String? qrCodeImage;
  String? centralLock;
  String? centralLockLastCommand;
  int? fuelLevel;
  String? keyfob;
  String? vehicleIdentificationNumber;
  String? vehicleLicensePlate;
  int? speed;
  bool? isPaused;

  BookingRoutesModelDataCar({
    this.position,
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
    this.bookingStatus,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.fuelType,
    this.bluetoothConnection,
    this.boardVoltage,
    this.ignition,
    this.immobilizer,
    this.mileage,
    this.mileageSinceImmobilizerUnlock,
    this.alarmInput,
    this.alarmInput_2,
    this.lowBatteryLevelAlarm,
    this.lowFuelLevelAlarm,
    this.relayValue,
    this.qrCodeImage,
    this.centralLock,
    this.centralLockLastCommand,
    this.fuelLevel,
    this.keyfob,
    this.vehicleIdentificationNumber,
    this.vehicleLicensePlate,
    this.speed,
    this.isPaused,
  });
  BookingRoutesModelDataCar.fromJson(Map<String, dynamic> json) {
    position = (json['position'] != null) ? BookingRoutesModelDataCarPosition.fromJson(json['position']) : null;
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
    bookingStatus = json['bookingStatus']?.toString();
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    category = json['category']?.toString();
    fuelType = json['fuelType']?.toString();
    bluetoothConnection = json['bluetooth_connection']?.toString();
    boardVoltage = json['board_voltage']?.toDouble();
    ignition = json['ignition']?.toString();
    immobilizer = json['immobilizer']?.toString();
    mileage = json['mileage']?.toInt();
    mileageSinceImmobilizerUnlock = json['mileage_since_immobilizer_unlock']?.toInt();
    alarmInput = json['alarm_input']?.toString();
    alarmInput_2 = json['alarm_input_2']?.toString();
    lowBatteryLevelAlarm = json['low_battery_level_alarm'];
    lowFuelLevelAlarm = json['low_fuel_level_alarm'];
    relayValue = json['relay_value']?.toInt();
    qrCodeImage = json['qrCodeImage']?.toString();
    centralLock = json['central_lock']?.toString();
    centralLockLastCommand = json['central_lock_last_command']?.toString();
    fuelLevel = json['fuel_level']?.toInt();
    keyfob = json['keyfob']?.toString();
    vehicleIdentificationNumber = json['vehicle_identification_number']?.toString();
    vehicleLicensePlate = json['vehicle_license_plate']?.toString();
    speed = json['speed']?.toInt();
    isPaused = json['isPaused'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (position != null) {
      data['position'] = position!.toJson();
    }
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
    data['bookingStatus'] = bookingStatus;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['category'] = category;
    data['fuelType'] = fuelType;
    data['bluetooth_connection'] = bluetoothConnection;
    data['board_voltage'] = boardVoltage;
    data['ignition'] = ignition;
    data['immobilizer'] = immobilizer;
    data['mileage'] = mileage;
    data['mileage_since_immobilizer_unlock'] = mileageSinceImmobilizerUnlock;
    data['alarm_input'] = alarmInput;
    data['alarm_input_2'] = alarmInput_2;
    data['low_battery_level_alarm'] = lowBatteryLevelAlarm;
    data['low_fuel_level_alarm'] = lowFuelLevelAlarm;
    data['relay_value'] = relayValue;
    data['qrCodeImage'] = qrCodeImage;
    data['central_lock'] = centralLock;
    data['central_lock_last_command'] = centralLockLastCommand;
    data['fuel_level'] = fuelLevel;
    data['keyfob'] = keyfob;
    data['vehicle_identification_number'] = vehicleIdentificationNumber;
    data['vehicle_license_plate'] = vehicleLicensePlate;
    data['speed'] = speed;
    data['isPaused'] = isPaused;
    return data;
  }
}

class BookingRoutesModelDataUserStripeCards {
/*
{
  "encryptedCode": "U2FsdGVkX19hNIU9tD2uoBOWHapP8XDMuezBjDsuYgtpEVpWyNBbIUbN3nP2XDbHjU5l1sVfKOxzqnHpl8c+wrf1j+qIApD390voB3lKsTKNsEB0s08liMZGz76D7p/NQettjBH9fsoG+tkoJGXqlUn5g7isYlUvjDUZ9tHojTw=",
  "stripeCardId": "card_1NAXPXERG4ZXrlcJH95qdkqm",
  "_id": "646b5958611de76d1bc49bd7"
}
*/

  String? encryptedCode;
  String? stripeCardId;
  String? Id;

  BookingRoutesModelDataUserStripeCards({
    this.encryptedCode,
    this.stripeCardId,
    this.Id,
  });
  BookingRoutesModelDataUserStripeCards.fromJson(Map<String, dynamic> json) {
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

class BookingRoutesModelDataUserInsurance {
/*
{
  "insuranceNumber": "456789054",
  "validTill": "09-09-2222",
  "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
}
*/

  String? insuranceNumber;
  String? validTill;
  String? image;

  BookingRoutesModelDataUserInsurance({
    this.insuranceNumber,
    this.validTill,
    this.image,
  });
  BookingRoutesModelDataUserInsurance.fromJson(Map<String, dynamic> json) {
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

class BookingRoutesModelDataUserDl {
/*
{
  "licenceNumber": "1234567890",
  "validTill": "01-03-1990",
  "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
}
*/

  String? licenceNumber;
  String? validTill;
  String? image;

  BookingRoutesModelDataUserDl({
    this.licenceNumber,
    this.validTill,
    this.image,
  });
  BookingRoutesModelDataUserDl.fromJson(Map<String, dynamic> json) {
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

class BookingRoutesModelDataUser {
/*
{
  "dl": {
    "licenceNumber": "1234567890",
    "validTill": "01-03-1990",
    "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
  },
  "insurance": {
    "insuranceNumber": "456789054",
    "validTill": "09-09-2222",
    "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
  },
  "_id": "638f2c6e11bf13fb011874a4",
  "name": "saha sir 1",
  "phone": "+919915537118",
  "email": "a@gmail.com",
  "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-image_picker5292979803169895893.jpg",
  "role": "user",
  "firebaseUid": "b1AAbG4zTPhkC3WYcQibyRnMs7k2",
  "firebaseSignInProvider": "phone",
  "gender": "male",
  "address": "Sunny Enclave Chandigarh",
  "suspensionReason": "Driving outside zone.",
  "isSuspended": false,
  "noOfRides": 17,
  "totalTravelKm": 0,
  "isDeleted": false,
  "isApproved": true,
  "createdAt": "2022-12-06T11:50:06.905Z",
  "updatedAt": "2023-07-12T05:40:54.524Z",
  "dob": "1995-05-01T00:00:00.000Z",
  "stripeCards": [
    {
      "encryptedCode": "U2FsdGVkX19hNIU9tD2uoBOWHapP8XDMuezBjDsuYgtpEVpWyNBbIUbN3nP2XDbHjU5l1sVfKOxzqnHpl8c+wrf1j+qIApD390voB3lKsTKNsEB0s08liMZGz76D7p/NQettjBH9fsoG+tkoJGXqlUn5g7isYlUvjDUZ9tHojTw=",
      "stripeCardId": "card_1NAXPXERG4ZXrlcJH95qdkqm",
      "_id": "646b5958611de76d1bc49bd7"
    }
  ],
  "stripeCustomerId": "cus_NwQGeUrzjecj2v",
  "stripeCardId": "card_1NAXPXERG4ZXrlcJH95qdkqm"
}
*/

  BookingRoutesModelDataUserDl? dl;
  BookingRoutesModelDataUserInsurance? insurance;
  String? Id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? role;
  String? firebaseUid;
  String? firebaseSignInProvider;
  String? gender;
  String? address;
  String? suspensionReason;
  bool? isSuspended;
  int? noOfRides;
  int? totalTravelKm;
  bool? isDeleted;
  bool? isApproved;
  String? createdAt;
  String? updatedAt;
  String? dob;
  List<BookingRoutesModelDataUserStripeCards?>? stripeCards;
  String? stripeCustomerId;
  String? stripeCardId;

  BookingRoutesModelDataUser({
    this.dl,
    this.insurance,
    this.Id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.role,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.gender,
    this.address,
    this.suspensionReason,
    this.isSuspended,
    this.noOfRides,
    this.totalTravelKm,
    this.isDeleted,
    this.isApproved,
    this.createdAt,
    this.updatedAt,
    this.dob,
    this.stripeCards,
    this.stripeCustomerId,
    this.stripeCardId,
  });
  BookingRoutesModelDataUser.fromJson(Map<String, dynamic> json) {
    dl = (json['dl'] != null) ? BookingRoutesModelDataUserDl.fromJson(json['dl']) : null;
    insurance = (json['insurance'] != null) ? BookingRoutesModelDataUserInsurance.fromJson(json['insurance']) : null;
    Id = json['_id']?.toString();
    name = json['name']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    image = json['image']?.toString();
    role = json['role']?.toString();
    firebaseUid = json['firebaseUid']?.toString();
    firebaseSignInProvider = json['firebaseSignInProvider']?.toString();
    gender = json['gender']?.toString();
    address = json['address']?.toString();
    suspensionReason = json['suspensionReason']?.toString();
    isSuspended = json['isSuspended'];
    noOfRides = json['noOfRides']?.toInt();
    totalTravelKm = json['totalTravelKm']?.toInt();
    isDeleted = json['isDeleted'];
    isApproved = json['isApproved'];
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    dob = json['dob']?.toString();
    if (json['stripeCards'] != null) {
      final v = json['stripeCards'];
      final arr0 = <BookingRoutesModelDataUserStripeCards>[];
      v.forEach((v) {
        arr0.add(BookingRoutesModelDataUserStripeCards.fromJson(v));
      });
      stripeCards = arr0;
    }
    stripeCustomerId = json['stripeCustomerId']?.toString();
    stripeCardId = json['stripeCardId']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (dl != null) {
      data['dl'] = dl!.toJson();
    }
    if (insurance != null) {
      data['insurance'] = insurance!.toJson();
    }
    data['_id'] = Id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['role'] = role;
    data['firebaseUid'] = firebaseUid;
    data['firebaseSignInProvider'] = firebaseSignInProvider;
    data['gender'] = gender;
    data['address'] = address;
    data['suspensionReason'] = suspensionReason;
    data['isSuspended'] = isSuspended;
    data['noOfRides'] = noOfRides;
    data['totalTravelKm'] = totalTravelKm;
    data['isDeleted'] = isDeleted;
    data['isApproved'] = isApproved;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['dob'] = dob;
    if (stripeCards != null) {
      final v = stripeCards;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['stripeCards'] = arr0;
    }
    data['stripeCustomerId'] = stripeCustomerId;
    data['stripeCardId'] = stripeCardId;
    return data;
  }
}

class BookingRoutesModelDataDropLocation {
/*
{
  "type": "Point",
  "coordinates": [
    80.9229409563887
  ],
  "address": "Lucknow"
}
*/

  String? type;
  List<double?>? coordinates;
  String? address;

  BookingRoutesModelDataDropLocation({
    this.type,
    this.coordinates,
    this.address,
  });
  BookingRoutesModelDataDropLocation.fromJson(Map<String, dynamic> json) {
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

class BookingRoutesModelDataPickupLocation {
/*
{
  "type": "Point",
  "coordinates": [
    38.678692
  ],
  "address": "6210 Windorah Way, ,California, 95662 "
}
*/

  String? type;
  List<double?>? coordinates;
  String? address;

  BookingRoutesModelDataPickupLocation({
    this.type,
    this.coordinates,
    this.address,
  });
  BookingRoutesModelDataPickupLocation.fromJson(Map<String, dynamic> json) {
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

class BookingRoutesModelData {
/*
{
  "pickupLocation": {
    "type": "Point",
    "coordinates": [
      38.678692
    ],
    "address": "6210 Windorah Way, ,California, 95662 "
  },
  "dropLocation": {
    "type": "Point",
    "coordinates": [
      80.9229409563887
    ],
    "address": "Lucknow"
  },
  "tripTime": 0,
  "ridePauseTime": 0,
  "tripData": [
    ""
  ],
  "_id": "646b5930611de76d1bc49bcd",
  "user": {
    "dl": {
      "licenceNumber": "1234567890",
      "validTill": "01-03-1990",
      "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
    },
    "insurance": {
      "insuranceNumber": "456789054",
      "validTill": "09-09-2222",
      "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
    },
    "_id": "638f2c6e11bf13fb011874a4",
    "name": "saha sir 1",
    "phone": "+919915537118",
    "email": "a@gmail.com",
    "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-image_picker5292979803169895893.jpg",
    "role": "user",
    "firebaseUid": "b1AAbG4zTPhkC3WYcQibyRnMs7k2",
    "firebaseSignInProvider": "phone",
    "gender": "male",
    "address": "Sunny Enclave Chandigarh",
    "suspensionReason": "Driving outside zone.",
    "isSuspended": false,
    "noOfRides": 17,
    "totalTravelKm": 0,
    "isDeleted": false,
    "isApproved": true,
    "createdAt": "2022-12-06T11:50:06.905Z",
    "updatedAt": "2023-07-12T05:40:54.524Z",
    "dob": "1995-05-01T00:00:00.000Z",
    "stripeCards": [
      {
        "encryptedCode": "U2FsdGVkX19hNIU9tD2uoBOWHapP8XDMuezBjDsuYgtpEVpWyNBbIUbN3nP2XDbHjU5l1sVfKOxzqnHpl8c+wrf1j+qIApD390voB3lKsTKNsEB0s08liMZGz76D7p/NQettjBH9fsoG+tkoJGXqlUn5g7isYlUvjDUZ9tHojTw=",
        "stripeCardId": "card_1NAXPXERG4ZXrlcJH95qdkqm",
        "_id": "646b5958611de76d1bc49bd7"
      }
    ],
    "stripeCustomerId": "cus_NwQGeUrzjecj2v",
    "stripeCardId": "card_1NAXPXERG4ZXrlcJH95qdkqm"
  },
  "car": {
    "position": {
      "type": "Point",
      "coordinates": [
        -121.263054
      ]
    },
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
    "bookingStatus": "idle",
    "isDeleted": false,
    "createdAt": "2023-02-20T13:38:45.912Z",
    "updatedAt": "2023-08-24T08:54:58.724Z",
    "category": "sedan",
    "fuelType": "fuel",
    "bluetooth_connection": "disconnected",
    "board_voltage": 12.62,
    "ignition": "off",
    "immobilizer": "unlocked",
    "mileage": 25583,
    "mileage_since_immobilizer_unlock": 0,
    "alarm_input": "off",
    "alarm_input_2": "off",
    "low_battery_level_alarm": false,
    "low_fuel_level_alarm": false,
    "relay_value": 0,
    "qrCodeImage": "https://www.hellotech.com/guide/wp-content/uploads/2020/05/HelloTech-qr-code.jpg",
    "central_lock": "locked",
    "central_lock_last_command": "locked",
    "fuel_level": 79,
    "keyfob": "in",
    "vehicle_identification_number": "",
    "vehicle_license_plate": "",
    "speed": 0,
    "isPaused": false
  },
  "qnr": "6DB9853D00FFF005",
  "status": "completed",
  "pickupTime": "2023-05-22T12:05:42.869Z",
  "dropTime": "2023-05-22T12:11:53.796Z",
  "cancelReason": "",
  "cancelledBy": "",
  "isPaymentSuccess": false,
  "paymentMethod": "",
  "rideEndedBy": "user",
  "waitingTime": 366,
  "additionalWaitingTime": 0,
  "path": [
    [
      "38.68391"
    ]
  ],
  "isDeleted": false,
  "createdAt": "2023-05-22T11:59:44.769Z",
  "updatedAt": "2023-05-22T12:11:55.310Z",
  "paymentStep": "initialPayment",
  "ignitionEvents": [
    ""
  ],
  "inspections": {
    "_id": "646b5a95611de76d1bc49c3f",
    "booking": "646b5930611de76d1bc49bcd",
    "carImagesBeforeRide": [
      {
        "respectiveSide": "Front Hood",
        "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-CAP3403461901841268839.jpg",
        "_id": "646b5a95611de76d1bc49c40"
      }
    ],
    "carImagesAfterRide": [
      {
        "respectiveSide": "Front Hood",
        "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
        "_id": "63a41224058e23a2fafbfe6b"
      }
    ],
    "createdAt": "2023-05-22T12:05:41.190Z",
    "updatedAt": "2023-05-22T12:05:41.190Z"
  },
  "id": "646b5930611de76d1bc49bcd"
}
*/

  BookingRoutesModelDataPickupLocation? pickupLocation;
  BookingRoutesModelDataDropLocation? dropLocation;
  int? tripTime;
  int? ridePauseTime;
  List<String?>? tripData;
  String? Id;
  BookingRoutesModelDataUser? user;
  BookingRoutesModelDataCar? car;
  String? qnr;
  String? status;
  String? pickupTime;
  String? dropTime;
  String? cancelReason;
  String? cancelledBy;
  bool? isPaymentSuccess;
  String? paymentMethod;
  String? rideEndedBy;
  int? waitingTime;
  int? additionalWaitingTime;
  List<List<String?>?>? path;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? paymentStep;
  List<String?>? ignitionEvents;
  BookingRoutesModelDataInspections? inspections;
  String? id;

  BookingRoutesModelData({
    this.pickupLocation,
    this.dropLocation,
    this.tripTime,
    this.ridePauseTime,
    this.tripData,
    this.Id,
    this.user,
    this.car,
    this.qnr,
    this.status,
    this.pickupTime,
    this.dropTime,
    this.cancelReason,
    this.cancelledBy,
    this.isPaymentSuccess,
    this.paymentMethod,
    this.rideEndedBy,
    this.waitingTime,
    this.additionalWaitingTime,
    this.path,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.paymentStep,
    this.ignitionEvents,
    this.inspections,
    this.id,
  });
  BookingRoutesModelData.fromJson(Map<String, dynamic> json) {
    pickupLocation = (json['pickupLocation'] != null) ? BookingRoutesModelDataPickupLocation.fromJson(json['pickupLocation']) : null;
    dropLocation = (json['dropLocation'] != null) ? BookingRoutesModelDataDropLocation.fromJson(json['dropLocation']) : null;
    tripTime = json['tripTime']?.toInt();
    ridePauseTime = json['ridePauseTime']?.toInt();
    if (json['tripData'] != null) {
      final v = json['tripData'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      tripData = arr0;
    }
    Id = json['_id']?.toString();
    user = (json['user'] != null) ? BookingRoutesModelDataUser.fromJson(json['user']) : null;
    car = (json['car'] != null) ? BookingRoutesModelDataCar.fromJson(json['car']) : null;
    qnr = json['qnr']?.toString();
    status = json['status']?.toString();
    pickupTime = json['pickupTime']?.toString();
    dropTime = json['dropTime']?.toString();
    cancelReason = json['cancelReason']?.toString();
    cancelledBy = json['cancelledBy']?.toString();
    isPaymentSuccess = json['isPaymentSuccess'];
    paymentMethod = json['paymentMethod']?.toString();
    rideEndedBy = json['rideEndedBy']?.toString();
    waitingTime = json['waitingTime']?.toInt();
    additionalWaitingTime = json['additionalWaitingTime']?.toInt();
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
    if (json['ignitionEvents'] != null) {
      final v = json['ignitionEvents'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      ignitionEvents = arr0;
    }
    inspections = (json['inspections'] != null) ? BookingRoutesModelDataInspections.fromJson(json['inspections']) : null;
    id = json['id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (pickupLocation != null) {
      data['pickupLocation'] = pickupLocation!.toJson();
    }
    if (dropLocation != null) {
      data['dropLocation'] = dropLocation!.toJson();
    }
    data['tripTime'] = tripTime;
    data['ridePauseTime'] = ridePauseTime;
    if (tripData != null) {
      final v = tripData;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['tripData'] = arr0;
    }
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
    data['dropTime'] = dropTime;
    data['cancelReason'] = cancelReason;
    data['cancelledBy'] = cancelledBy;
    data['isPaymentSuccess'] = isPaymentSuccess;
    data['paymentMethod'] = paymentMethod;
    data['rideEndedBy'] = rideEndedBy;
    data['waitingTime'] = waitingTime;
    data['additionalWaitingTime'] = additionalWaitingTime;
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
    if (ignitionEvents != null) {
      final v = ignitionEvents;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['ignitionEvents'] = arr0;
    }
    if (inspections != null) {
      data['inspections'] = inspections!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class BookingRoutesModel {
/*
{
  "status": true,
  "message": "Get a booking.",
  "data": {
    "pickupLocation": {
      "type": "Point",
      "coordinates": [
        38.678692
      ],
      "address": "6210 Windorah Way, ,California, 95662 "
    },
    "dropLocation": {
      "type": "Point",
      "coordinates": [
        80.9229409563887
      ],
      "address": "Lucknow"
    },
    "tripTime": 0,
    "ridePauseTime": 0,
    "tripData": [
      ""
    ],
    "_id": "646b5930611de76d1bc49bcd",
    "user": {
      "dl": {
        "licenceNumber": "1234567890",
        "validTill": "01-03-1990",
        "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
      },
      "insurance": {
        "insuranceNumber": "456789054",
        "validTill": "09-09-2222",
        "image": "https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
      },
      "_id": "638f2c6e11bf13fb011874a4",
      "name": "saha sir 1",
      "phone": "+919915537118",
      "email": "a@gmail.com",
      "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-image_picker5292979803169895893.jpg",
      "role": "user",
      "firebaseUid": "b1AAbG4zTPhkC3WYcQibyRnMs7k2",
      "firebaseSignInProvider": "phone",
      "gender": "male",
      "address": "Sunny Enclave Chandigarh",
      "suspensionReason": "Driving outside zone.",
      "isSuspended": false,
      "noOfRides": 17,
      "totalTravelKm": 0,
      "isDeleted": false,
      "isApproved": true,
      "createdAt": "2022-12-06T11:50:06.905Z",
      "updatedAt": "2023-07-12T05:40:54.524Z",
      "dob": "1995-05-01T00:00:00.000Z",
      "stripeCards": [
        {
          "encryptedCode": "U2FsdGVkX19hNIU9tD2uoBOWHapP8XDMuezBjDsuYgtpEVpWyNBbIUbN3nP2XDbHjU5l1sVfKOxzqnHpl8c+wrf1j+qIApD390voB3lKsTKNsEB0s08liMZGz76D7p/NQettjBH9fsoG+tkoJGXqlUn5g7isYlUvjDUZ9tHojTw=",
          "stripeCardId": "card_1NAXPXERG4ZXrlcJH95qdkqm",
          "_id": "646b5958611de76d1bc49bd7"
        }
      ],
      "stripeCustomerId": "cus_NwQGeUrzjecj2v",
      "stripeCardId": "card_1NAXPXERG4ZXrlcJH95qdkqm"
    },
    "car": {
      "position": {
        "type": "Point",
        "coordinates": [
          -121.263054
        ]
      },
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
      "bookingStatus": "idle",
      "isDeleted": false,
      "createdAt": "2023-02-20T13:38:45.912Z",
      "updatedAt": "2023-08-24T08:54:58.724Z",
      "category": "sedan",
      "fuelType": "fuel",
      "bluetooth_connection": "disconnected",
      "board_voltage": 12.62,
      "ignition": "off",
      "immobilizer": "unlocked",
      "mileage": 25583,
      "mileage_since_immobilizer_unlock": 0,
      "alarm_input": "off",
      "alarm_input_2": "off",
      "low_battery_level_alarm": false,
      "low_fuel_level_alarm": false,
      "relay_value": 0,
      "qrCodeImage": "https://www.hellotech.com/guide/wp-content/uploads/2020/05/HelloTech-qr-code.jpg",
      "central_lock": "locked",
      "central_lock_last_command": "locked",
      "fuel_level": 79,
      "keyfob": "in",
      "vehicle_identification_number": "",
      "vehicle_license_plate": "",
      "speed": 0,
      "isPaused": false
    },
    "qnr": "6DB9853D00FFF005",
    "status": "completed",
    "pickupTime": "2023-05-22T12:05:42.869Z",
    "dropTime": "2023-05-22T12:11:53.796Z",
    "cancelReason": "",
    "cancelledBy": "",
    "isPaymentSuccess": false,
    "paymentMethod": "",
    "rideEndedBy": "user",
    "waitingTime": 366,
    "additionalWaitingTime": 0,
    "path": [
      [
        "38.68391"
      ]
    ],
    "isDeleted": false,
    "createdAt": "2023-05-22T11:59:44.769Z",
    "updatedAt": "2023-05-22T12:11:55.310Z",
    "paymentStep": "initialPayment",
    "ignitionEvents": [
      ""
    ],
    "inspections": {
      "_id": "646b5a95611de76d1bc49c3f",
      "booking": "646b5930611de76d1bc49bcd",
      "carImagesBeforeRide": [
        {
          "respectiveSide": "Front Hood",
          "image": "https://zammauserprofile.s3.us-west-1.amazonaws.com/user-profile-CAP3403461901841268839.jpg",
          "_id": "646b5a95611de76d1bc49c40"
        }
      ],
      "carImagesAfterRide": [
        {
          "respectiveSide": "Front Hood",
          "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
          "_id": "63a41224058e23a2fafbfe6b"
        }
      ],
      "createdAt": "2023-05-22T12:05:41.190Z",
      "updatedAt": "2023-05-22T12:05:41.190Z"
    },
    "id": "646b5930611de76d1bc49bcd"
  }
}
*/

  bool? status;
  String? message;
  BookingRoutesModelData? data;

  BookingRoutesModel({
    this.status,
    this.message,
    this.data,
  });
  BookingRoutesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? BookingRoutesModelData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
