import 'package:abdulaziz_flutter/components/user_show_header.dart';
import 'package:abdulaziz_flutter/components/user_show_information.dart';
import 'package:abdulaziz_flutter/components/user_signed_show_header.dart';
import 'package:abdulaziz_flutter/components/user_signed_show_information.dart';
import 'package:abdulaziz_flutter/models/User_Type.dart';
import 'package:abdulaziz_flutter/models/user.dart';
import 'package:abdulaziz_flutter/services/api_services.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:abdulaziz_flutter/utils/sorting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../components/loader_dialog.dart';
import 'sign_page.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:printing/printing.dart';
import 'package:abdulaziz_flutter/document_printing/pdf_classes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class UserSignedShowScreen extends StatefulWidget {
  const UserSignedShowScreen({Key? key}) : super(key: key);

  @override
  _UserSignedShowScreenState createState() => _UserSignedShowScreenState();
}

late List<dynamic> users;
List<dynamic> tempUsers = [];

String? dropdownValue = 'Employee Name';
TextEditingController searchBy = TextEditingController();
String? dropdownValue1 = '';
List<String> dropValues = [];
List<Map<String, dynamic>> values = [];
TextEditingController usernameT = TextEditingController();
TextEditingController passwordT = TextEditingController();
TextEditingController emailT = TextEditingController();
TextEditingController exNOT = TextEditingController();
TextEditingController mobNum = TextEditingController();
TextEditingController mobCode = TextEditingController();

bool? value = false;

class _UserSignedShowScreenState extends State<UserSignedShowScreen> {
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

  Future newUser() async {
    User u = User(0, usernameT.text, passwordT.text, value!, emailT.text,
        exNOT.text, mobNum.text, mobCode.text);

    await ApiServices().putUser(u).then((value1) async {
      if (!value1.toString().contains('Request failed') &&
          !value1.toString().contains('Error')) {
        // print(int.parse(values[dropValues.indexOf(dropdownValue1!)]['ind'])
        //     .toString());
        await ApiServices().putUserType(
          User_Type(
            0,
            int.parse(value1['id'].toString()),
            int.parse(
                values[dropValues.indexOf(dropdownValue1!)]['ind'].toString()),
          ),
        );
        // await ApiServices().putUserType(User_Type(0, 6, 1));
        // User_Type t = User_Type(0, 1,
        //     values[dropValues.indexOf(dropdownValue!)]['ind']);
        // await ApiServices().editUserType(t);
      }
    });
  }

  Future getDropDownValues() async {
    await ApiServices().getUserTypes().then((value) {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {
        for (var item in value) {
          if (!dropValues.contains(item['Dep'])) {
            dropValues.add(item['Dep']);
            values.add(item);
          }
        }
      } else {
        EasyLoading.showError(value.toString());
      }
    });
    setState(() {});
  }

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

  Future _openPopup(context, String departmen, String username, String password,
      String email, String exNO) async {
    dropdownValue1 = departmen;
    usernameT.text = username;
    passwordT.text = password;
    emailT.text = email;
    exNOT.text = exNO;
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Text(
                    'Add Employee',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.w(8),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  DropdownButton(
                    elevation: 5,
                    isExpanded: false,
                    hint: Text(
                      'Sector',
                      textDirection: TextDirection.rtl,
                    ),
                    style: TextStyle(
                      fontSize: SizeConfig.w(5),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    value: dropdownValue1,
                    items: dropValues
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? s) {
                      setState(() {
                        dropdownValue1 = s;
                      });
                    },
                  ),
                  TextField(
                    controller: usernameT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Username',
                    ),
                  ),
                  TextField(
                    controller: passwordT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                  ),
                  TextField(
                    controller: emailT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: exNOT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Ex NO.',
                    ),
                  ),
                  TextField(
                    controller: mobNum,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Mobile Number',
                    ),
                  ),
                  TextField(
                    controller: mobCode,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Mobile Code',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: value,
                        onChanged: (bool? v) {
                          setState(() {
                            value = !value!;
                          });
                        },
                      ),
                      Text(
                        'is IT?',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.h(50),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await newUser();
                      dropdownValue = 'Employee Name';
                      await getAllUsers();
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.showProgress(0.3,
        status: 'Loading...', maskType: EasyLoadingMaskType.clear);
    Future.delayed(
      Duration(seconds: 2),
      () async {
        await getDropDownValues();
        await getAllUsers();
        dropdownValue1 = dropValues[0];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _openPopup(context, 'Directors', '', '', '', '');
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
              'Sign Out',
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
              items: const [
                DropdownMenuItem<String>(
                  value: 'Employee Name',
                  child: Text('Employee Name'),
                ),
                DropdownMenuItem<String>(
                  value: 'Email Address',
                  child: Text('Email Address'),
                ),
                DropdownMenuItem<String>(
                  value: 'Extension NO.',
                  child: Text('Extension NO.'),
                ),
              ],
              onChanged: (String? s) {
                setState(() {
                  dropdownValue = s;
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Employee Page',
                style: TextStyle(fontSize: SizeConfig.w(12)),
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
            margin: EdgeInsets.symmetric(
              horizontal: 50,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: userSignedShowHeader(
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
                return UserSignedShowInformation(
                  typeInd: tempUsers[ind]['userTypeInd'],
                  userFK: tempUsers[ind]['userID'],
                  department: tempUsers[ind]['Dep'],
                  name: tempUsers[ind]['Username'],
                  email: tempUsers[ind]['Email'],
                  exNo: tempUsers[ind]['NO'],
                  mobileNum: tempUsers[ind]['mobileNum'],
                  mobileCode: tempUsers[ind]['mobileCode'],
                  color: ind % 2 == 0 ? true : false,
                  IsIT: tempUsers[ind]['IsIT'],
                  deleteing: () async {
                    await getAllUsers();
                  },
                  password: tempUsers[ind]['Password'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
