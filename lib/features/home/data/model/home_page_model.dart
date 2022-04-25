// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
    HomePageModel({
      this.trendingBrand,
        this.notificationCounter,
        this.topBoutiques,
        this.aboutToFinish,
        this.allAds,
        this.matchPreferences,
        this.headerElements
    });

    int notificationCounter;
    List<TrendingBrand> trendingBrand;
    List<AboutToFinish> topBoutiques;
    List<AboutToFinish> aboutToFinish;
    List<AboutToFinish> allAds;
    List<AboutToFinish> matchPreferences;
       List<HeaderElement> headerElements;

    factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
              trendingBrand: List<TrendingBrand>.from(json["trendingBrands"].map((x) => TrendingBrand.fromJson(x))),
       headerElements: List<HeaderElement>.from(json["headerElements"].map((x) => HeaderElement.fromJson(x))),
        notificationCounter: json["notificationCounter"],
        topBoutiques: List<AboutToFinish>.from(json["topBoutiques"].map((x) => AboutToFinish.fromJson(x))),
        aboutToFinish: List<AboutToFinish>.from(json["aboutToFinish"].map((x) => AboutToFinish.fromJson(x))),
        allAds: List<AboutToFinish>.from(json["allADS"].map((x) => AboutToFinish.fromJson(x))),
        matchPreferences: List<AboutToFinish>.from(json["matchPreferences"].map((x) => AboutToFinish.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notificationCounter": notificationCounter,
        "topBoutiques": List<dynamic>.from(topBoutiques.map((x) => x.toJson())),
        "aboutToFinish": List<dynamic>.from(aboutToFinish.map((x) => x.toJson())),
        "allADS": List<dynamic>.from(allAds.map((x) => x.toJson())),
        "matchPreferences": List<dynamic>.from(matchPreferences.map((x) => x.toJson())),
    };
}

class AboutToFinish {
    AboutToFinish({
        this.attachments,
        this.id,
        this.lastPrice,
        this.location,
        this.mainCategory,
        this.sellType,
        this.subCategory,
        this.timeToEnd,
        this.viewers,
        this.liked,
        this.fixedPrice,
        this.tags
    });

    List<Attachment> attachments;
    String id;
    dynamic fixedPrice ;
    bool liked;
    List<String>tags;
    int lastPrice;
    String location;
    Category mainCategory;
    String sellType;
    Category subCategory;
    String timeToEnd;
    int viewers;

    factory AboutToFinish.fromJson(Map<String, dynamic> json) => AboutToFinish(
                  tags: List<String>.from(json["tags"].map((x) => x)),
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        liked: json["liked"],
        id: json["id"],
        fixedPrice: json['directSellPrice'],
        lastPrice: json["lastPrice"],
        location: json["location"],
        mainCategory: Category.fromJson(json["mainCategory"]),
        sellType:json["sellType"],
        subCategory: Category.fromJson(json["subCategory"]),
        timeToEnd: json["timeToEnd"],
        viewers: json["viewers"],
    );

    Map<String, dynamic> toJson() => {
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "id": id,
        "lastPrice": lastPrice,
        "location": location,
        "mainCategory": mainCategory.toJson(),
        // "sellType": sellTypeValues.reverse[sellType],
        "subCategory": subCategory.toJson(),
        "timeToEnd": timeToEnd,
        "viewers": viewers,
    };
}

class Attachment {
    Attachment({
        this.publicUrl,
    });

    String publicUrl;

    factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        publicUrl: json["publicURL"],
    );

    Map<String, dynamic> toJson() => {
        "publicURL": publicUrl,
    };
}

class Category {
    Category({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class HeaderElement {
    HeaderElement({
        this.version,
        this.creationDate,
        this.lastModificationDate,
        this.id,
        this.objectType,
        this.attachments,
        this.name,
        this.description,
        this.website,
        this.whatsappNumber,
        this.facebookLink,
        this.instagramLink,
        this.active,
        this.endDate,
        this.elementOrder,
    });

    int version;
    DateTime creationDate;
    DateTime lastModificationDate;
    String id;
    String objectType;
    List<Attachment> attachments;
    String name;
    String description;
    String website;
    String whatsappNumber;
    String facebookLink;
    String instagramLink;
    bool active;
    DateTime endDate;
    int elementOrder;

    factory HeaderElement.fromJson(Map<String, dynamic> json) => HeaderElement(
        version: json["version"],
        creationDate: DateTime.parse(json["creationDate"]),
        lastModificationDate: DateTime.parse(json["lastModificationDate"]),
        id: json["id"],
        objectType: json["objectType"],
        attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
        name: json["name"],
        description: json["description"],
        website: json["website"],
        whatsappNumber: json["whatsappNumber"],
        facebookLink: json["facebookLink"],
        instagramLink: json["instagramLink"],
        active: json["active"],
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        elementOrder: json["elementOrder"],
    );

    Map<String, dynamic> toJson() => {
        "version": version,
        "creationDate": creationDate.toIso8601String(),
        "lastModificationDate": lastModificationDate.toIso8601String(),
        "id": id,
        "objectType": objectType,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "name": name,
        "description": description,
        "website": website,
        "whatsappNumber": whatsappNumber,
        "facebookLink": facebookLink,
        "instagramLink": instagramLink,
        "active": active,
        "endDate": endDate == null ? null : endDate.toIso8601String(),
        "elementOrder": elementOrder,
    };
}





class TrendingBrand {
    TrendingBrand({
        this.count,
        this.mainCategory,
        this.subCategory,
        this.brand,
    });

    int count;
    Category mainCategory;
    Category subCategory;
    Category brand;

    factory TrendingBrand.fromJson(Map<String, dynamic> json) => TrendingBrand(
        count: json["count"],
        mainCategory: Category.fromJson(json["mainCategory"]),
        subCategory: Category.fromJson(json["subCategory"]),
        brand: Category.fromJson(json["brand"]),
    );

  
}