import 'dart:io';
import 'dart:typed_data';
import 'package:abdulaziz_flutter/components/bixes_signed_show_header.dart';
import 'package:abdulaziz_flutter/components/header_signed_show_information.dart';
import 'package:abdulaziz_flutter/document_printing/pdf_classes.dart';
import 'package:abdulaziz_flutter/models/Bix.dart';
import 'package:abdulaziz_flutter/services/api_services.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:abdulaziz_flutter/utils/sorting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'sign_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:printing/printing.dart';

class BixesSignedScreen extends StatefulWidget {
  const BixesSignedScreen({Key? key}) : super(key: key);

  @override
  _BixesSignedScreenState createState() => _BixesSignedScreenState();
}

late List<dynamic> bixes;
List<dynamic> tempBixes = [];
String? dropdownValue = 'Bix Name';
TextEditingController searchBy = TextEditingController();
String? dropdownValue1 = 'Bix Name';
List<String> dropValues = [];
List<Map<String, dynamic>> values = [];
TextEditingController bixNameT = TextEditingController();
TextEditingController bixPortT = TextEditingController();
TextEditingController bixExtensionT = TextEditingController();
TextEditingController bixTypeT = TextEditingController();
TextEditingController lineTypeT = TextEditingController();
TextEditingController buildNameT = TextEditingController();
TextEditingController newBuildingT = TextEditingController();
String value = 'A';

class _BixesSignedScreenState extends State<BixesSignedScreen> {
  // Future newUser() async {
  //   User u = User(0, bixNameT.text, bixPortT.text, value!, bixExtensionT.text,
  //       bixTypeT.text);

  //   await ApiServices().putUser(u).then((value1) async {
  //     if (!value1.toString().contains('Request failed') &&
  //         !value1.toString().contains('Error')) {
  //       // print(int.parse(values[dropValues.indexOf(dropdownValue1!)]['ind'])
  //       //     .toString());
  //       await ApiServices().putUserType(
  //         User_Type(
  //           0,
  //           int.parse(value1['id'].toString()),
  //           int.parse(
  //               values[dropValues.indexOf(dropdownValue1!)]['ind'].toString()),
  //         ),
  //       );
  //       // await ApiServices().putUserType(User_Type(0, 6, 1));
  //       // User_Type t = User_Type(0, 1,
  //       //     values[dropValues.indexOf(dropdownValue!)]['ind']);
  //       // await ApiServices().editUserType(t);
  //     }
  //   });
  // }

  var anchor;
  final pdf = pw.Document();
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

  printPage() async {
    Printing.layoutPdf(onLayout: (format) {
      final doc = pw.Document();
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
                  topLeft: pw.Radius.circular(25),
                  topRight: pw.Radius.circular(25),
                ),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Building',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Bix Number',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Port',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Extension',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Type Of Extension',
                      style: pw.TextStyle(fontSize: 8),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Line Type',
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
              [pw.Wrap(children: GetPdfBody().getBixes(tempBixes))],
        ),
      );
      return doc.save();
    });

    savePDF(pdf);
  }

  Future getDropDownValues() async {
    await ApiServices().getBixesBuilds().then((value) {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {
        for (var item in value) {
          if (!dropValues.contains(item['buildName'])) {
            dropValues.add(item['buildName']);
            values.add(item);
          }
        }
      } else {
        EasyLoading.showError(value.toString());
      }
    });
    setState(() {});
  }

  Future getAllbixes() async {
    await ApiServices().getAllBixes().then((value) {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {
        // bixes.addAll(value as List<dynamic>);
        bixes = List.from(value);
        tempBixes = List.from(value);
        setState(() {});
      } else {
        EasyLoading.showError(value.toString());
      }
    });
    return bixes;
  }

  Future newBix() async {
    Bix b = Bix(
        0,
        values[dropValues.indexOf(dropdownValue1!)]['ind'],
        bixPortT.text,
        bixNameT.text,
        bixExtensionT.text,
        value,
        lineTypeT.text);
    await ApiServices().putBix(b).then((value) async {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {
      } else {
        EasyLoading.showError(value.toString());
      }
    });
  }

  searchByBixName(String? id) {
    tempBixes.clear();
    tempBixes = List.from(bixes
        .where((element) => element['bixName']
            .toString()
            .toLowerCase()
            .contains(id!.toLowerCase()))
        .toList());
    setState(() {});
  }

  searchByExtensionNo(String? name) {
    tempBixes.clear();
    tempBixes = List.from(bixes
        .where((element) => element['bixExtension']
            .toString()
            .toLowerCase()
            .contains(name!.toLowerCase()))
        .toList());
    setState(() {});
  }

  searchByPortNO(String? email) {
    tempBixes.clear();
    tempBixes = List.from(bixes
        .where((element) =>
            element['bixPort'].toString().toLowerCase() == email!.toLowerCase())
        .toList());
    setState(() {});
  }

  searchByLocation(String? email) {
    tempBixes.clear();
    tempBixes = List.from(bixes
        .where((element) => element['buildName']
            .toString()
            .toLowerCase()
            .contains(email!.toLowerCase()))
        .toList());
    setState(() {});
  }

  searchByTypeofextensoin(String? email) {
    tempBixes.clear();
    tempBixes = List.from(bixes
        .where((element) => element['bixType']
            .toString()
            .toLowerCase()
            .contains(email!.toLowerCase()))
        .toList());
    setState(() {});
  }

  emptySearch() {
    tempBixes.clear();
    setState(() {
      tempBixes.addAll(bixes);
    });
  }

  onSearchChange(String? s) {
    if (s == '') {
      emptySearch();
    } else if (dropdownValue == 'Bix Name') {
      searchByBixName(s);
    } else if (dropdownValue == 'Extension NO.') {
      searchByExtensionNo(s);
    } else if (dropdownValue == 'Port NO.') {
      searchByPortNO(s);
    } else if (dropdownValue == 'Location') {
      searchByLocation(s);
    } else if (dropdownValue == 'bixType') {
      searchByTypeofextensoin(s);
    }
  }

  Future _openPopup(context, String dopVal, String bixName, String bixPort,
      String extensionBix, String lineType) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Text(
                    'Add Bix',
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
                      'Section',
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
                    textDirection: TextDirection.rtl,
                    controller: bixNameT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Bix Name',
                    ),
                  ),
                  TextField(
                    textDirection: TextDirection.rtl,
                    controller: bixPortT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Port',
                    ),
                  ),
                  TextField(
                    textDirection: TextDirection.rtl,
                    controller: bixExtensionT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Bix Extension NO.',
                    ),
                  ),
                  TextField(
                    textDirection: TextDirection.rtl,
                    controller: lineTypeT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Line Type',
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       '? Analog',
                  //       textDirection: TextDirection.rtl,
                  //     ),
                  //     Checkbox(
                  //       value: value,
                  //       onChanged: (bool? v) {
                  //         setState(() {
                  //           value = !value!;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 'A',
                              groupValue: value,
                              onChanged: (index) {
                                setState(() {
                                  value = index.toString();
                                });
                              },
                            ),
                            Expanded(
                              child: Text('Analog'),
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: 'D',
                                groupValue: value,
                                onChanged: (index) {
                                  setState(() {
                                    value = index.toString();
                                  });
                                }),
                            Expanded(child: Text('Digital'))
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: 'EX',
                                groupValue: value,
                                onChanged: (index) {
                                  setState(() {
                                    value = index.toString();
                                  });
                                }),
                            Expanded(child: Text('External'))
                          ],
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.h(50),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await newBix();
                      dropdownValue = 'Bix Name';
                      await getAllbixes();
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                  SizedBox(
                    height: SizeConfig.h(50),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.showProgress(0.3,
        status: 'Loading...', maskType: EasyLoadingMaskType.clear);
    Future.delayed(
      Duration(seconds: 1),
      () async {
        await getDropDownValues();
        await getAllbixes();
        dropdownValue1 = dropValues[0];
        setState(() {});
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

  sortByBuilding() {
    if (tempBixes.isNotEmpty && bixes.isNotEmpty) {
      tempBixes.clear();
      tempBixes = List.from(
          Sorting().sortbixesByDepartment(bixes, 'buildName', depRev));
      depRev = !depRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByBix() {
    if (tempBixes.isNotEmpty && bixes.isNotEmpty) {
      tempBixes.clear();
      tempBixes =
          List.from(Sorting().sortbixesByDepartment(bixes, 'bixName', nameRev));
      nameRev = !nameRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByPort() {
    if (tempBixes.isNotEmpty && bixes.isNotEmpty) {
      tempBixes.clear();
      tempBixes = List.from(
          Sorting().sortbixesByDepartment(bixes, 'bixPort', emailRev));
      emailRev = !emailRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByExt() {
    if (tempBixes.isNotEmpty && bixes.isNotEmpty) {
      tempBixes.clear();
      tempBixes = List.from(
          Sorting().sortbixesByDepartment(bixes, 'bixExtension', noRev));
      noRev = !noRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByType() {
    if (tempBixes.isNotEmpty && bixes.isNotEmpty) {
      tempBixes.clear();
      tempBixes = List.from(
          Sorting().sortbixesByDepartment(bixes, 'bixType', mobNumRev));
      mobNumRev = !mobNumRev;
      if (mounted) {
        setState(() {});
      }
    }
  }

  sortByLine() {
    if (tempBixes.isNotEmpty && bixes.isNotEmpty) {
      tempBixes.clear();
      tempBixes = List.from(
          Sorting().sortbixesByDepartment(bixes, 'lineType', mobCodeRev));
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
          await _openPopup(context, '', '', '', '', '');
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
              await getAllbixes();
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
                  value: 'Bix Name',
                  child: Text('Bix Name'),
                ),
                DropdownMenuItem<String>(
                  value: 'Extension NO.',
                  child: Text('Extension NO.'),
                ),
                DropdownMenuItem<String>(
                  value: 'Port NO.',
                  child: Text('Port NO.'),
                ),
                DropdownMenuItem<String>(
                  value: 'Location',
                  child: Text('Location'),
                ),
                DropdownMenuItem<String>(
                  value: 'bixType',
                  child: Text('Type of Extension'),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bixes',
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
            child: BixesSignedHeader(
              sortByBix: sortByBix,
              sortByBuilding: sortByBuilding,
              sortByExt: sortByExt,
              sortByLine: sortByLine,
              sortByPort: sortByPort,
              sortByType: sortByType,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tempBixes.length,
              itemBuilder: (cnt, ind) {
                return HeaderSignedInformation(
                  bixName: tempBixes[ind]['bixName'],
                  bixPort: tempBixes[ind]['bixPort'],
                  bixExtension: tempBixes[ind]['bixExtension'],
                  bixType: tempBixes[ind]['bixType'],
                  lineType: tempBixes[ind]['lineType'],
                  BuildName: tempBixes[ind]['buildName'],
                  color: ind % 2 == 0 ? true : false,
                  deleteing: () => getAllbixes(),
                  bixID: tempBixes[ind]['bixID'],
                  buildID: tempBixes[ind]['buildID'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
