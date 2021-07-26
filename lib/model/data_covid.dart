class DataCovid {
  DataCovid({
    this.lastDate,
    this.currentData,
    this.missingData,
    this.tanpaProvinsi,
    this.listData,
  });

  DateTime lastDate;
  double currentData;
  double missingData;
  int tanpaProvinsi;
  List<ListDatum> listData;

  factory DataCovid.fromJson(Map<String, dynamic> json) => DataCovid(
    lastDate: DateTime.parse(json["last_date"]),
    currentData:json["current_data"],
    missingData: json["missing_data"],
    tanpaProvinsi: json["tanpa_provinsi"],
    listData: List<ListDatum>.from(json["list_data"].map((x) => ListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "last_date": "${lastDate.year.toString().padLeft(4, '0')}-${lastDate.month.toString().padLeft(2, '0')}-${lastDate.day.toString().padLeft(2, '0')}",
    "current_data": currentData,
    "missing_data": missingData,
    "tanpa_provinsi": tanpaProvinsi,
    "list_data": List<dynamic>.from(listData.map((x) => x.toJson())),
  };
}

class ListDatum {
  ListDatum({
    this.key,
    this.docCount,
    this.jumlahKasus,
    this.jumlahSembuh,
    this.jumlahMeninggal,
    this.jumlahDirawat,
    this.jenisKelamin,
    this.kelompokUmur,
    this.lokasi,
    this.penambahan,
  });

  String key;
  double docCount;
  int jumlahKasus;
  int jumlahSembuh;
  int jumlahMeninggal;
  int jumlahDirawat;
  List<JenisKelamin> jenisKelamin;
  List<KelompokUmur> kelompokUmur;
  Lokasi lokasi;
  Penambahan penambahan;

  factory ListDatum.fromJson(Map<String, dynamic> json) => ListDatum(
    key: json["key"],
    docCount: json["doc_count"].toDouble(),
    jumlahKasus: json["jumlah_kasus"],
    jumlahSembuh: json["jumlah_sembuh"],
    jumlahMeninggal: json["jumlah_meninggal"],
    jumlahDirawat: json["jumlah_dirawat"],
    jenisKelamin: List<JenisKelamin>.from(json["jenis_kelamin"].map((x) => JenisKelamin.fromJson(x))),
    kelompokUmur: List<KelompokUmur>.from(json["kelompok_umur"].map((x) => KelompokUmur.fromJson(x))),
    lokasi: Lokasi.fromJson(json["lokasi"]),
    penambahan: Penambahan.fromJson(json["penambahan"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "doc_count": docCount,
    "jumlah_kasus": jumlahKasus,
    "jumlah_sembuh": jumlahSembuh,
    "jumlah_meninggal": jumlahMeninggal,
    "jumlah_dirawat": jumlahDirawat,
    "jenis_kelamin": List<dynamic>.from(jenisKelamin.map((x) => x.toJson())),
    "kelompok_umur": List<dynamic>.from(kelompokUmur.map((x) => x.toJson())),
    "lokasi": lokasi.toJson(),
    "penambahan": penambahan.toJson(),
  };
}

class JenisKelamin {
  JenisKelamin({
    this.key,
    this.docCount,
  });

  JenisKelaminKey key;
  int docCount;

  factory JenisKelamin.fromJson(Map<String, dynamic> json) => JenisKelamin(
    key: jenisKelaminKeyValues.map[json["key"]],
    docCount: json["doc_count"],
  );

  Map<String, dynamic> toJson() => {
    "key": jenisKelaminKeyValues.reverse[key],
    "doc_count": docCount,
  };
}

enum JenisKelaminKey { LAKI_LAKI, PEREMPUAN }

final jenisKelaminKeyValues = EnumValues({
  "LAKI-LAKI": JenisKelaminKey.LAKI_LAKI,
  "PEREMPUAN": JenisKelaminKey.PEREMPUAN
});

class KelompokUmur {
  KelompokUmur({
    this.key,
    this.docCount,
    this.usia,
  });

  KelompokUmurKey key;
  int docCount;
  Usia usia;

  factory KelompokUmur.fromJson(Map<String, dynamic> json) => KelompokUmur(
    key: kelompokUmurKeyValues.map[json["key"]],
    docCount: json["doc_count"],
    usia: Usia.fromJson(json["usia"]),
  );

  Map<String, dynamic> toJson() => {
    "key": kelompokUmurKeyValues.reverse[key],
    "doc_count": docCount,
    "usia": usia.toJson(),
  };
}

enum KelompokUmurKey { THE_05, THE_618, THE_1930, THE_3145, THE_4659, THE_60 }

final kelompokUmurKeyValues = EnumValues({
  "0-5": KelompokUmurKey.THE_05,
  "19-30": KelompokUmurKey.THE_1930,
  "31-45": KelompokUmurKey.THE_3145,
  "46-59": KelompokUmurKey.THE_4659,
  "≥ 60": KelompokUmurKey.THE_60,
  "6-18": KelompokUmurKey.THE_618
});

class Usia {
  Usia({
    this.value,
  });

  double value;

  factory Usia.fromJson(Map<String, dynamic> json) => Usia(
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
  };
}

class Lokasi {
  Lokasi({
    this.lon,
    this.lat,
  });

  double lon;
  double lat;

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
    lon: json["lon"].toDouble(),
    lat: json["lat"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lon": lon,
    "lat": lat,
  };
}

class Penambahan {
  Penambahan({
    this.positif,
    this.sembuh,
    this.meninggal,
  });

  int positif;
  int sembuh;
  int meninggal;

  factory Penambahan.fromJson(Map<String, dynamic> json) => Penambahan(
    positif: json["positif"],
    sembuh: json["sembuh"],
    meninggal: json["meninggal"],
  );

  Map<String, dynamic> toJson() => {
    "positif": positif,
    "sembuh": sembuh,
    "meninggal": meninggal,
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
