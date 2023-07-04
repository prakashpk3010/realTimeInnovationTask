import 'dart:convert';

List<dynamic> getEmpDetailsModelFromJson(String str) => List<dynamic>.from(
    json.decode(str).map((x) => GetEmpDetailsModel.fromJson(x)));

class GetEmpDetailsModel {
  String empName;
  String designation;
  String fromDate;
  String toDate;

  GetEmpDetailsModel({
    required this.empName,
    required this.designation,
    required this.fromDate,
    required this.toDate,
  });

  factory GetEmpDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetEmpDetailsModel(
        empName: json["empName"],
        designation: json["designation"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
      );
}
