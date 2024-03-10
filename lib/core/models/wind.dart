class Wind {
  double? speed;
  double? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'] == null
        ? null
        : double.tryParse(json['speed'].toString()) ?? 0.0;
    deg = json['deg'] == null
        ? null
        : double.tryParse(json['deg'].toString()) ?? 0.0;
    gust = json['gust'] == null
        ? null
        : double.tryParse(json['gust'].toString()) ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}
