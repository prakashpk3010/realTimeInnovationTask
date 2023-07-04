import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:realtime_task/constants/app_layouts.dart';
import 'package:realtime_task/features/provider/provider.dart';
import 'package:realtime_task/features/widgets/custom_textfield.dart';
import 'package:realtime_task/features/widgets/date_picker.dart';
import 'package:realtime_task/features/widgets/roles_list.dart';
import '../widgets/appbar.dart';
import '../widgets/buttons.dart';
import '../repo/get_data.dart';

class AddEmployees extends ConsumerStatefulWidget {
  final String primaryKey;
  final String db;
  const AddEmployees(this.primaryKey, this.db, {super.key});

  @override
  ConsumerState<AddEmployees> createState() => _AddEmployeesState();
}

class _AddEmployeesState extends ConsumerState<AddEmployees> {
  TextEditingController empNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController fromdateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    if (widget.db.isNotEmpty && widget.primaryKey.isNotEmpty) {
      if (widget.db == 'employeeDB') {
        getData1(ref);
        final employeeCurList = ref.read(employeeCurListProv);
        empNameController.text =
            employeeCurList[int.parse(widget.primaryKey)].empName;
        roleController.text =
            employeeCurList[int.parse(widget.primaryKey)].designation;
        fromdateController.text =
            employeeCurList[int.parse(widget.primaryKey)].fromDate;
        toDateController.text = '';
      } else {
        getData2(ref);
        final employeePreList = ref.read(employeePreListProv);
        empNameController.text =
            employeePreList[int.parse(widget.primaryKey)].empName;
        roleController.text =
            employeePreList[int.parse(widget.primaryKey)].designation;
        fromdateController.text =
            employeePreList[int.parse(widget.primaryKey)].fromDate;
        toDateController.text =
            employeePreList[int.parse(widget.primaryKey)].toDate;
      }
    }
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          kToolbarHeight,
        ),
        child: const MyAppBar(
          title: 'Add Employee Details',
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: Applayout().screenPad,
          children: [
            CustomTextfield(
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Employee name cannot be empty';
                } else {
                  return null;
                }
              },
              preIcon: const Icon(Icons.person),
              hint: 'Employee Name',
              controller: empNameController,
            ),
            Applayout().contentSpacerFields,
            CustomTextfield(
              readOnly: true,
              ontap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Applayout().cornerRadius,
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return const RolesList();
                  },
                ).then((value) {
                  final desig = ref.read(designationProv);
                  roleController.text = desig;
                  setState(() {});
                });
              },
              preIcon: const Icon(Icons.work),
              suficon: const Icon(Icons.expand_more),
              hint: 'Select Role',
              controller: roleController,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Role cannot be empty';
                } else {
                  return null;
                }
              },
            ),
            Applayout().contentSpacerFields,
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    readOnly: true,
                    preIcon: const Icon(Icons.calendar_month),
                    hint: 'From',
                    controller: fromdateController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'From date cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    ontap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const CustomDatePicker(true);
                        },
                      ).then((value) {
                        final from = ref.read(fromdateSelectedProv);
                        fromdateController.text = from;
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.arrow_forward),
                ),
                Expanded(
                  child: CustomTextfield(
                    readOnly: true,
                    ontap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const CustomDatePicker(false);
                        },
                      ).then((value) {
                        final to = ref.watch(todateSelectedProv);
                        toDateController.text = to;
                      });
                    },
                    preIcon: const Icon(Icons.calendar_month),
                    hint: 'To',
                    controller: toDateController,
                  ),
                ),
              ],
            ),
            Applayout().contentSpacerFields,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Applayout().screenPad,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtons(
                width: 70,
                function: () {
                  Navigator.pop(context);
                },
                text: 'Cancel',
                isSelected: false),
            CustomButtons(
              width: 70,
              function: () async {
                if (formKey.currentState!.validate()) {
                  var box = await Hive.openBox('employeeDB');
                  var box2 = await Hive.openBox('employeeDB2');
                  if (toDateController.text.isEmpty ||
                      toDateController.text == 'No Date') {
                    if (widget.db == 'employeeDB') {
                      await box.putAt(
                          int.parse(widget.primaryKey),
                          jsonEncode({
                            'empName': empNameController.text,
                            'designation': roleController.text,
                            'fromDate': fromdateController.text,
                            'toDate': toDateController.text,
                          }));
                    } else {
                      await box.add(jsonEncode({
                        'empName': empNameController.text,
                        'designation': roleController.text,
                        'fromDate': fromdateController.text,
                        'toDate': toDateController.text,
                      }));
                    }
                  }
                  if (toDateController.text.isNotEmpty) {
                    if (widget.db == 'employeeDB2') {
                      await box2.putAt(
                          int.parse(widget.primaryKey),
                          jsonEncode({
                            'empName': empNameController.text,
                            'designation': roleController.text,
                            'fromDate': fromdateController.text,
                            'toDate': toDateController.text,
                          }));
                    } else {
                      await box2.add(jsonEncode({
                        'empName': empNameController.text,
                        'designation': roleController.text,
                        'fromDate': fromdateController.text,
                        'toDate': toDateController.text,
                      }));
                    }
                  }
                }
                getData1(ref);
                getData2(ref);
                if (!mounted) return;
                Navigator.pop(context);
                ref.invalidate(employeePreListProv);
                ref.invalidate(employeeCurListProv);
              },
              text: 'Save',
              isSelected: true,
            ),
          ],
        ),
      ),
    );
  }
}
