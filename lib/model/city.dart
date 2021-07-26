// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    this.rajaongkir,
  });

  Rajaongkir rajaongkir;

  factory City.fromJson(Map<String, dynamic> json) => City(
    rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
  );

  Map<String, dynamic> toJson() => {
    "rajaongkir": rajaongkir.toJson(),
  };
}

class Rajaongkir {
  Rajaongkir({
    this.query,
    this.status,
    this.results,
  });

  Query query;
  Status status;
  List<Result> results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
    query: Query.fromJson(json["query"]),
    status: Status.fromJson(json["status"]),
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "query": query.toJson(),
    "status": status.toJson(),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Query {
  Query({
    this.province,
  });

  String province;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    province: json["province"],
  );

  Map<String, dynamic> toJson() => {
    "province": province,
  };
}

class Result {
  Result({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  String cityId;
  String provinceId;
  Province province;
  Type type;
  String cityName;
  String postalCode;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    cityId: json["city_id"],
    provinceId: json["province_id"],
    province: provinceValues.map[json["province"]],
    type: typeValues.map[json["type"]],
    cityName: json["city_name"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "province_id": provinceId,
    "province": provinceValues.reverse[province],
    "type": typeValues.reverse[type],
    "city_name": cityName,
    "postal_code": postalCode,
  };
}

enum Province { NANGGROE_ACEH_DARUSSALAM_NAD }

final provinceValues = EnumValues({
  "Nanggroe Aceh Darussalam (NAD)": Province.NANGGROE_ACEH_DARUSSALAM_NAD
});

enum Type { KABUPATEN, KOTA }

final typeValues = EnumValues({
  "Kabupaten": Type.KABUPATEN,
  "Kota": Type.KOTA
});

class Status {
  Status({
    this.code,
    this.description,
  });

  int code;
  String description;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}