// To parse this JSON data, do
//
//     final verificationResponse = verificationResponseFromJson(jsonString);

import 'dart:convert';

VerificationResponse verificationResponseFromJson(String str) =>
    VerificationResponse.fromJson(json.decode(str));

String verificationResponseToJson(VerificationResponse data) =>
    json.encode(data.toJson());

class VerificationResponse {
  VerificationResponse({
    this.id,
    this.version,
    this.creationDate,
    this.lastModificationDate,
    this.uuid,
    this.objectType,
    this.attachments,
    this.name,
    this.mobileNumber,
    this.normalizedMobileNumber,
    this.email,
    this.address,
    this.description,
    this.blocked,
    this.receiveNotifications,
  });

  dynamic id;
  int version;
  DateTime creationDate;
  DateTime lastModificationDate;
  dynamic uuid;
  String objectType;
  List<dynamic> attachments;
  String name;
  String mobileNumber;
  String normalizedMobileNumber;
  String email;
  String address;
  String description;
  bool blocked;
  bool receiveNotifications;

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      VerificationResponse(
        id: json["id"],
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        uuid: json["uuid"],
        objectType: json["objectType"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        normalizedMobileNumber: json["normalizedMobileNumber"],
        email: json["email"],
        address: json["address"],
        description: json["description"],
        blocked: json["blocked"],
        receiveNotifications: json["receiveNotifications"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "uuid": uuid,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "name": name,
        "mobileNumber": mobileNumber,
        "normalizedMobileNumber": normalizedMobileNumber,
        "email": email,
        "address": address,
        "description": description,
        "blocked": blocked,
        "receiveNotifications": receiveNotifications,
      };
}
