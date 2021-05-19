import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MoreInfo {
  MoreInfo({
    this.type,
    this.kilo,
    this.engineSize,
    this.passenger,
    this.color,
    this.gear,
    this.oldOwner,
    this.listImage,
    this.carFeature,
    this.additionalInformation,
    this.publishDate,
    this.downPayment,
    this.monthlyPayment,
    this.userId,
  });

  String type;
  int kilo;
  int engineSize;
  int passenger;
  String color;
  String gear;
  int oldOwner;
  List<String> listImage;
  List<String> carFeature;
  String additionalInformation;
  String publishDate;
  int downPayment;
  int monthlyPayment;
  String userId;

  factory MoreInfo.fromJson(Map<String, dynamic> json) => MoreInfo(
        type: json["type"],
        kilo: json["kilo"],
        engineSize: json["engineSize"],
        passenger: json["passenger"],
        color: json["color"],
        gear: json["gear"],
        oldOwner: json["oldOwner"],
        listImage: List<String>.from(json["listImage"].map((x) => x)),
        carFeature: List<String>.from(json["carFeature"].map((x) => x)),
        additionalInformation: json["additionalInformation"],
        publishDate: json["publishDate"] == null
            ? null
            : DateFormat.yMMMMd().format(json["publishDate"].toDate()),
        // .format(DateTime.parse(json["publishDate"].toString())),
        downPayment: json["downPayment"],
        monthlyPayment: json["monthlyPayment"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate();
    return {
      "type": type,
      "kilo": kilo,
      "engineSize": engineSize,
      "passenger": passenger,
      "color": color,
      "gear": gear,
      "oldOwner": oldOwner,
      "listImage": List<dynamic>.from(listImage.map((x) => x)),
      "carFeature": List<dynamic>.from(carFeature.map((x) => x)),
      "additionalInformation": additionalInformation,
      "publishDate": myDateTime,
      // "publishDate":
      //     "${publishDate.year.toString().padLeft(4, '0')}-${publishDate.month.toString().padLeft(2, '0')}-${publishDate.day.toString().padLeft(2, '0')}",
      "downPayment": downPayment,
      "monthlyPayment": monthlyPayment,
      "userId": userId,
    };
  }
}
