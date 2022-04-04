import 'dart:ui';
import 'package:abdulaziz_flutter/document_printing/pdf_classes.dart';
import 'package:abdulaziz_flutter/utils/sorting.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:abdulaziz_flutter/components/user_show_header.dart';
import 'package:abdulaziz_flutter/components/user_show_information.dart';
import 'package:abdulaziz_flutter/models/user.dart';
import 'package:abdulaziz_flutter/screens/sign_page.dart';
import 'package:abdulaziz_flutter/services/api_services.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:printing/printing.dart';

class UserShowScreen extends StatefulWidget {
  const UserShowScreen({Key? key}) : super(key: key);

  @override
  _UserShowScreenState createState() => _UserShowScreenState();
}

late List<dynamic> users;
List<dynamic> tempUsers = [];

String? dropdownValue = 'Employee Name';
TextEditingController searchBy = TextEditingController();

class _UserShowScreenState extends State<UserShowScreen> {
  Future getAllUsers() async {
    await ApiServices().getAllUsers().then((value) {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {
        // users.addAll(value as List<dynamic>);
        users = List.from(value);
        tempUsers = List.from(value);
        setState(() {});
      } else {
        EasyLoading.showError(value.toString());
      }
    });
    return users;
  }

  searchByID(String? id) {
    tempUsers.clear();
    tempUsers = List.from(users
        .where((element) =>
            element['NO'].toString().toLowerCase().contains(id!.toLowerCase()))
        .toList());
    setState(() {});
  }

  searchByName(String? name) {
    tempUsers.clear();
    tempUsers = List.from(users
        .where((element) => element['Username']
            .toString()
            .toLowerCase()
            .contains(name!.toLowerCase()))
        .toList());
    setState(() {});
  }

  searchByEmail(String? email) {
    tempUsers.clear();
    tempUsers = List.from(users
        .where((element) => element['Email']
            .toString()
            .toLowerCase()
            .contains(email!.toLowerCase()))
        .toList());
    setState(() {});
  }

  emptySearch() {
    tempUsers.clear();
    setState(() {
      tempUsers.addAll(users);
    });
  }

  onSearchChange(String? s) {
    if (s == '') {
      emptySearch();
    } else if (dropdownValue == 'Extension NO.') {
      searchByID(s);
    } else if (dropdownValue == 'Employee Name') {
      searchByName(s);
    } else if (dropdownValue == 'Email Address') {
      searchByEmail(s);
    }
  }

  var anchor;
  savePDF(pw.Document pdf) async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'pdf.pdf';

    html.document.body!.children.add(anchor);
    anchor.click();
  }

  final pdf = pw.Document();
  printPage() async {
    // final path = await getSavePath();
    // final name = "hello_file_selector.txt";

    Printing.layoutPdf(onLayout: (format) {
      final doc = pw.Document();
      // final doc = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          header: (cnt) {
            return pw.Container(
              margin: pw.EdgeInsets.symmetric(
                horizontal: 50,
              ),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#0000ff'),
                borderRadius: pw.BorderRadius.only(
                  topLeft: pw.Radius.circular(15),
                  topRight: pw.Radius.circular(15),
                ),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Department',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Name',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Email',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Extension NO.',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Mobile Num',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Mobile Code',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          build: (pw.Context context) =>
              [pw.Wrap(children: GetPdfBody().getUsers(tempUsers))],
        ),
      );
      return doc.save();
    });

    savePDF(pdf);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.showProgress(0.3,
        status: 'Loading...', maskType: EasyLoadingMaskType.clear);
    Future.delayed(
      Duration(seconds: 2),
      () async {
        await getAllUsers();
        EasyLoading.dismiss();
      },
    );
  }

  bool depRev = false;
  bool nameRev = false;
  bool emailRev = false;
  bool noRev = false;
  bool mobNumRev = false;
  bool mobCodeRev = false;
  sortByDep() {
    if (tempUsers.isNotEmpty && users.isNotEmpty) {
      tempUsers.clear();
      tempUsers =
          List.from(Sorting().sortUsersByDepartment(users, 'Dep', depRev));
      depRev = !depRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByName() {
    if (tempUsers.isNotEmpty && users.isNotEmpty) {
      tempUsers.clear();
      tempUsers = List.from(
          Sorting().sortUsersByDepartment(users, 'Username', nameRev));
      nameRev = !nameRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByEmail() {
    if (tempUsers.isNotEmpty && users.isNotEmpty) {
      tempUsers.clear();
      tempUsers =
          List.from(Sorting().sortUsersByDepartment(users, 'Email', emailRev));
      emailRev = !emailRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByExtNO() {
    if (tempUsers.isNotEmpty && users.isNotEmpty) {
      tempUsers.clear();
      tempUsers =
          List.from(Sorting().sortUsersByDepartment(users, 'NO', noRev));
      noRev = !noRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByMobNum() {
    if (tempUsers.isNotEmpty && users.isNotEmpty) {
      tempUsers.clear();
      tempUsers = List.from(
          Sorting().sortUsersByDepartment(users, 'mobileNum', mobNumRev));
      mobNumRev = !mobNumRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByMobCode() {
    if (tempUsers.isNotEmpty && users.isNotEmpty) {
      tempUsers.clear();
      tempUsers = List.from(
          Sorting().sortUsersByDepartment(users, 'mobileCode', mobCodeRev));
      mobCodeRev = !mobCodeRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 50,
        actions: [
          TextButton.icon(
            onPressed: () async {
              EasyLoading.showProgress(0.3,
                  status: 'Loading...', maskType: EasyLoadingMaskType.clear);
              await getAllUsers();
              EasyLoading.dismiss();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            label: Text('Refresh'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
            child: Text(
              'Sign In',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 50,
              child: Center(
                child: TextField(
                  onChanged: (s) {
                    onSearchChange(s);
                  },
                  controller: searchBy,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.w(5),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search Here ...',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.w(5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            DropdownButton(
              elevation: 5,
              isExpanded: false,
              dropdownColor: Colors.white,
              hint: const Text('Search Type'),
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.w(5),
                fontWeight: FontWeight.bold,
              ),
              value: dropdownValue,
              items: <String>['Employee Name', 'Email Address', 'Extension NO.']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? s) {
                setState(() {
                  dropdownValue = s;
                });
              },
            ),
          ],
        ),
      ),

      body: Container(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SAGCO Extension Management System',
                  style: TextStyle(
                      fontSize: SizeConfig.w(8), fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    printPage();
                  },
                  child: const Text('Print'),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 30, 50, 0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: userShowHeader(
                sortByDep: sortByDep,
                sortByEmail: sortByEmail,
                sortByExtNo: sortByExtNO,
                sortByMobCode: sortByMobCode,
                sortByMobNum: sortByMobNum,
                sortByName: sortByName,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tempUsers.length,
                itemBuilder: (cnt, ind) {
                  return UserShowInformation(
                    department: tempUsers[ind]['Dep'],
                    name: tempUsers[ind]['Username'],
                    email: tempUsers[ind]['Email'],
                    exNo: tempUsers[ind]['NO'],
                    mobileNum: tempUsers[ind]['mobileNum'],
                    mobileCode: tempUsers[ind]['mobileCode'],
                    color: ind % 2 == 0 ? true : false,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // body: FutureBuilder(
      //   future: getAllUsers(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       // If we got an error
      //       if (snapshot.hasError) {
      //         return Center(
      //           child: Text(
      //             '${snapshot.error} occured',
      //             style: TextStyle(fontSize: 18),
      //           ),
      //         );

      //         // if we got our data
      //       } else if (snapshot.hasData) {
      //         return Container();
      //       }
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
