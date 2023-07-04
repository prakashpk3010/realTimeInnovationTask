import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../model/getdetails_model.dart';
import '../provider/provider.dart';

getData1(WidgetRef ref) async {
  var databox = await Hive.openBox('employeeDB');
  var format = databox.values.toList().toString();
  var data = getEmpDetailsModelFromJson(format);
  ref.read(employeeCurListProv.notifier).update((state) => data);
}

getData2(WidgetRef ref) async {
  var databox = await Hive.openBox('employeeDB2');
  var format = databox.values.toList().toString();
  var data = getEmpDetailsModelFromJson(format);
  ref.read(employeePreListProv.notifier).update((state) => data);
}
