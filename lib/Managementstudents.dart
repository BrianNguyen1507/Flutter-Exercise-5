import 'package:flutter/material.dart';
import 'package:lab7_exercise/model/student.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  static const List<String> stafftype = <String>[
    'Office Staff',
    'Accountant Staff'
  ];
  String dropdownValue = stafftype.first;
  List<Staff> listStaff = <Staff>[];
  TextEditingController manvController = TextEditingController();
  TextEditingController tenController = TextEditingController();
  TextEditingController hesoLuongController = TextEditingController();
  TextEditingController troCapController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'CUSTOM LISTVIEW SAMPLE',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: manvController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Staff code',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: tenController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text(
                    "Staff type: ",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: stafftype
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: dropdownValue == 'Office Staff',
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: troCapController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Luong Tro Cap',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: dropdownValue == 'Accountant Staff',
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: hesoLuongController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'He So Luong',
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: MaterialButton(
                    onPressed: () {
                      addStaff();
                    },
                    color: Colors.blue,
                    child: const Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: const Text(
                      'Show',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

//func
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    manvController.dispose();
    tenController.dispose();
    troCapController.dispose();
    hesoLuongController.dispose();
    super.dispose();
  }

  void addStaff() {
    setState(() {
      String manv = manvController.text;
      String ten = tenController.text;
      double? tienTC = double.tryParse(troCapController.text);
      double? hesoLuong = double.tryParse(hesoLuongController.text);

      Staff staff;
      if (dropdownValue == 'Office Staff') {
        var officeStaff = OfficeStaff(manv, ten, tienTC ?? 0);
        staff = officeStaff;
        officeStaff.tienTC = tienTC ?? 0; // Set the value of tienTC
      } else if (dropdownValue == 'Accounting Staff') {
        var accountingStaff = AccountingStaff(manv, ten, hesoLuong ?? 0);
        staff = accountingStaff;
        accountingStaff.hesoLuong =
            hesoLuong ?? 1.0; // Set the value of hesoLuong
      } else {
        return;
      }

      staff.tinhLuong();

      listStaff.add(staff);
      for (var staff in listStaff) {
        if (staff is OfficeStaff) {
          print('Office Staff:');
          print('Staff ID: ${staff.manv}');
          print('Staff Name: ${staff.ten}');
          print('Basic Salary: ${staff.luongCB}');
          print('Total Salary: ${staff.tinhLuong()}');
        } else if (staff is AccountingStaff) {
          print('Accounting Staff:');
          print('Staff ID: ${staff.manv}');
          print('Staff Name: ${staff.ten}');
          print('Basic Salary: ${staff.luongCB}');
          print('Total Salary: ${staff.tinhLuong()}');
        }
      }
      clearField(); // Assuming clearField() is a function that clears the text fields
    });
  }

  void clearField() {
    manvController.clear();
    tenController.clear();
    troCapController.clear();
    hesoLuongController.clear();
  }
}
