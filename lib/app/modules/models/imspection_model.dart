///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class InspectionModelDataCarImagesAfterRide {
/*
{
  "respectiveSide": "Right Side",
  "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
  "_id": "63a31640838d8332a0ed7517"
}
*/

  String? respectiveSide;
  String? image;
  String? Id;

  InspectionModelDataCarImagesAfterRide({
    this.respectiveSide,
    this.image,
    this.Id,
  });
  InspectionModelDataCarImagesAfterRide.fromJson(Map<String, dynamic> json) {
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

class InspectionModelDataCarImagesBeforeRide {
/*
{
  "respectiveSide": "Front Hood",
  "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
  "_id": "63a31640838d8332a0ed7515"
}
*/

  String? respectiveSide;
  String? image;
  String? Id;

  InspectionModelDataCarImagesBeforeRide({
    this.respectiveSide,
    this.image,
    this.Id,
  });
  InspectionModelDataCarImagesBeforeRide.fromJson(Map<String, dynamic> json) {
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

class InspectionModelData {
/*
{
  "booking": "63a2e79b33e4a03b10a8a279",
  "carImagesBeforeRide": [
    {
      "respectiveSide": "Front Hood",
      "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
      "_id": "63a31640838d8332a0ed7515"
    }
  ],
  "_id": "63a31640838d8332a0ed7514",
  "carImagesAfterRide": [
    {
      "respectiveSide": "Right Side",
      "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
      "_id": "63a31640838d8332a0ed7517"
    }
  ],
  "createdAt": "2022-12-21T14:20:48.262Z",
  "updatedAt": "2022-12-21T14:20:48.262Z"
}
*/

  String? booking;
  List<InspectionModelDataCarImagesBeforeRide?>? carImagesBeforeRide;
  String? Id;
  List<InspectionModelDataCarImagesAfterRide?>? carImagesAfterRide;
  String? createdAt;
  String? updatedAt;

  InspectionModelData({
    this.booking,
    this.carImagesBeforeRide,
    this.Id,
    this.carImagesAfterRide,
    this.createdAt,
    this.updatedAt,
  });
  InspectionModelData.fromJson(Map<String, dynamic> json) {
    booking = json['booking']?.toString();
    if (json['carImagesBeforeRide'] != null) {
      final v = json['carImagesBeforeRide'];
      final arr0 = <InspectionModelDataCarImagesBeforeRide>[];
      v.forEach((v) {
        arr0.add(InspectionModelDataCarImagesBeforeRide.fromJson(v));
      });
      carImagesBeforeRide = arr0;
    }
    Id = json['_id']?.toString();
    if (json['carImagesAfterRide'] != null) {
      final v = json['carImagesAfterRide'];
      final arr0 = <InspectionModelDataCarImagesAfterRide>[];
      v.forEach((v) {
        arr0.add(InspectionModelDataCarImagesAfterRide.fromJson(v));
      });
      carImagesAfterRide = arr0;
    }
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['booking'] = booking;
    if (carImagesBeforeRide != null) {
      final v = carImagesBeforeRide;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['carImagesBeforeRide'] = arr0;
    }
    data['_id'] = Id;
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

class InspectionModel {
/*
{
  "status": true,
  "message": "Inspection images added before ride.",
  "data": {
    "booking": "63a2e79b33e4a03b10a8a279",
    "carImagesBeforeRide": [
      {
        "respectiveSide": "Front Hood",
        "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
        "_id": "63a31640838d8332a0ed7515"
      }
    ],
    "_id": "63a31640838d8332a0ed7514",
    "carImagesAfterRide": [
      {
        "respectiveSide": "Right Side",
        "image": "https://imgd.aeplcdn.com/370x208/n/cw/ec/54399/exterior-right-front-three-quarter-10.jpeg",
        "_id": "63a31640838d8332a0ed7517"
      }
    ],
    "createdAt": "2022-12-21T14:20:48.262Z",
    "updatedAt": "2022-12-21T14:20:48.262Z"
  }
}
*/

  bool? status;
  String? message;
  InspectionModelData? data;

  InspectionModel({
    this.status,
    this.message,
    this.data,
  });
  InspectionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? InspectionModelData.fromJson(json['data']) : null;
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
