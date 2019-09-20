class Result {
  String name;
  String picture;
  String type;
  Value value;

  Result({this.name, this.picture, this.type, this.value});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['Name'] ?? '';
    picture = json['Picture'] ?? '';
    type = json['Type'] ?? 'Fail';
    value = json['Value'] != null
        ? json['Value'] ==
                'No captions found! Are you sure this profile is public and has posted?'
            ? []
            : Value.fromJson(json['Value'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Name'] = this.name;
    data['Picture'] = this.picture;
    data['Type'] = this.type;
    if (this.value != null) {
      data['Value'] = this.value.toJson();
    }
    return data;
  }
}

class Value {
  double negative;
  double neutral;
  double overall;
  double positive;

  Value({this.negative, this.neutral, this.overall, this.positive});

  Value.fromJson(Map<String, dynamic> json) {
    negative = json['Negative'];
    neutral = json['Neutral'];
    overall = json['Overall'];
    positive = json['Positive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Negative'] = this.negative;
    data['Neutral'] = this.neutral;
    data['Overall'] = this.overall;
    data['Positive'] = this.positive;
    return data;
  }
}
