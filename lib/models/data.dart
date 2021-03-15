import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.email,
    this.name,
    this.dateAndTime,
    this.steps,
  });

  String email;
  String name;
  DateTime dateAndTime;
  int steps;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["Email"],
        name: json["Name"],
        dateAndTime: DateTime.parse(json["DateAndTime"]),
        steps: json["Steps"],
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "Name": name,
        "DateAndTime": dateAndTime.toIso8601String(),
        "Steps": steps,
      };
}
