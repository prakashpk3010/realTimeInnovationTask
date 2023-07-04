import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:realtime_task/constants/app_colors.dart';
import 'package:realtime_task/constants/app_font_style.dart';
import 'package:realtime_task/features/provider/provider.dart';
import 'package:realtime_task/features/screens/add_employee.dart';
import 'package:realtime_task/features/widgets/appbar.dart';
import '../../constants/app_layouts.dart';
import '../../constants/assets.dart';
import '../repo/get_data.dart';

class EmployeeList extends ConsumerStatefulWidget {
  const EmployeeList({
    super.key,
  });

  @override
  ConsumerState<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends ConsumerState<EmployeeList> {
  @override
  void initState() {
    super.initState();
    getData1(ref);
    getData2(ref);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final employeePreList = ref.watch(employeePreListProv);
    final employeeCurList = ref.watch(employeeCurListProv);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          kToolbarHeight,
        ),
        child: const MyAppBar(
          title: 'Employees List',
        ),
      ),
      body: (employeePreList.isEmpty && employeeCurList.isEmpty)
          ? Center(
              child: SvgPicture.asset(
                AppAsserts().emptyHolder,
              ),
            )
          : SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(vertical: Applayout().screenPadUnit),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (employeeCurList.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Applayout().screenPadUnit),
                      child: Text(
                        'Current Employees',
                        style: AppFontStyles().bodyNormalBold.copyWith(
                              color: AppColors().primaryColor,
                            ),
                      ),
                    ),
                    Applayout().height15,
                  ],
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container(
                        color: Colors.black,
                        height: 0.1,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Dismissible(
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Action"),
                                content: const Text(
                                    "Are you sure about deleting a Current Employee detail?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () async {
                                        var databox =
                                            await Hive.openBox('employeeDB');
                                        databox.deleteAt(index);
                                        if (!mounted) {
                                          return;
                                        }
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text("DELETE")),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        key: Key(employeeCurList[index].toString()),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          tileColor: Colors.white,
                          title: Text(
                            employeeCurList[index].empName,
                            style: AppFontStyles().bodyNormalBold,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Applayout().height10,
                              Text(
                                employeeCurList[index].designation,
                              ),
                              Applayout().height10,
                              Text(
                                'From ${employeeCurList[index].fromDate}',
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEmployees(
                                        index.toString(), 'employeeDB'),
                                  ));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: AppColors().blueDark,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: employeeCurList.length,
                  ),
                  if (employeePreList.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Applayout().screenPadUnit,
                          Applayout().screenPadUnit,
                          Applayout().screenPadUnit,
                          0),
                      child: Text(
                        'Previous Employees',
                        style: AppFontStyles().bodyNormalBold.copyWith(
                              color: AppColors().primaryColor,
                            ),
                      ),
                    ),
                    Applayout().height15,
                  ],
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container(
                        color: Colors.black,
                        height: 0.1,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Dismissible(
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Action"),
                                content: const Text(
                                    "Are you sure about deleting a Previous Employee detail?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () async {
                                        var databox =
                                            await Hive.openBox('employeeDB2');
                                        databox.deleteAt(index);
                                        if (!mounted) {
                                          return;
                                        }
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text("DELETE")),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        key: Key(employeePreList[index].toString()),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          tileColor: Colors.white,
                          title: Text(
                            employeePreList[index].empName,
                            style: AppFontStyles().bodyNormalBold,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Applayout().height10,
                              Text(
                                employeePreList[index].designation,
                              ),
                              Applayout().height10,
                              Text(
                                '${employeePreList[index].fromDate} - ${employeePreList[index].toDate}',
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEmployees(
                                        index.toString(), 'employeeDB2'),
                                  ));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: AppColors().blueDark,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: employeePreList.length,
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Applayout().cornerRadius,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddEmployees('', ''),
              ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
