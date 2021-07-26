class Province {
  Province({
    this.rajaongkir,
  });

  Rajaongkir rajaongkir;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
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

  List<dynamic> query;
  Status status;
  List<Result> results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
    query: List<dynamic>.from(json["query"].map((x) => x)),
    status: Status.fromJson(json["status"]),
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "query": List<dynamic>.from(query.map((x) => x)),
    "status": status.toJson(),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.provinceId,
    this.province,
  });

  String provinceId;
  String province;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    provinceId: json["province_id"],
    province: json["province"],
  );

  Map<String, dynamic> toJson() => {
    "province_id": provinceId,
    "province": province,
  };
}

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