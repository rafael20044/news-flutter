class Country {
  final bool error;
  final String msg;
  final List<Data> data;

  Country({
    required this.error,
    required this.msg,
    required this.data
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      error: json['error'],
      msg: json['msg'],
      data: (json['data'] as List).map((e) => Data.fromJson(e)).toList(),
    );
  }
}

class Data {
  final String name;
  final String iso2;
  final String iso3;
  final String unicodeFlag;

  Data({
    required this.name,
    required this.iso2,
    required this.iso3,
    required this.unicodeFlag,
  });

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      name: json['name'],
      iso2: json['iso2'],
      iso3: json['iso3'],
      unicodeFlag: json['unicodeFlag'],
    );
  }
}
