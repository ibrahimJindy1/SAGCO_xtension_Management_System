import 'package:abdulaziz_flutter/models/Bix.dart';
import 'package:abdulaziz_flutter/screens/bixes_signed_screen.dart';
import 'package:abdulaziz_flutter/services/api_services.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class HeaderSignedInformation extends StatefulWidget {
  final String bixName, bixPort, bixExtension, bixType, lineType, BuildName;
  final bool color;
  final Function deleteing;
  final int bixID, buildID;
  const HeaderSignedInformation({
    Key? key,
    required this.bixName,
    required this.bixPort,
    required this.bixExtension,
    required this.bixType,
    required this.lineType,
    required this.BuildName,
    required this.color,
    required this.deleteing,
    required this.bixID,
    required this.buildID,
  }) : super(key: key);

  @override
  _HeaderSignedInformationState createState() =>
      _HeaderSignedInformationState();
}

String value = 'A';
String? dropdownValue = '';
List<String> dropValues = [];
List<Map<String, dynamic>> values = [];
TextEditingController bixNameT = TextEditingController();
TextEditingController bixPortT = TextEditingController();
TextEditingController bixExtensionT = TextEditingController();
TextEditingController bixTypeT = TextEditingController();
TextEditingController lineTypeT = TextEditingController();
TextEditingController buildNameT = TextEditingController();

class _HeaderSignedInformationState extends State<HeaderSignedInformation> {
  Future putUser() async {
    Bix b = Bix(
        widget.bixID,
        values[dropValues.indexOf(dropdownValue!)]['ind'],
        bixPortT.text,
        bixNameT.text,
        bixExtensionT.text,
        value,
        lineTypeT.text);
    await ApiServices().editBix(b).then((value) async {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {}
    });
  }

  Future _openPopup(context, String dopVal, String bixName, String bixPort,
      String extensionBix, String lineType) async {
    dropdownValue = dopVal;
    bixNameT.text = bixName;
    bixPortT.text = bixPort;
    bixExtensionT.text = extensionBix;
    lineTypeT.text = lineType;

    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Text(
                    'Bix Edit',
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
                    value: dropdownValue,
                    items: dropValues
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
                  TextField(
                    controller: bixNameT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Bix Name',
                    ),
                  ),
                  TextField(
                    controller: bixPortT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Port',
                    ),
                  ),
                  TextField(
                    controller: bixExtensionT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Bix Extension NO.',
                    ),
                  ),
                  TextField(
                    controller: lineTypeT,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Line Type',
                    ),
                  ),
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
                      // await newUser();
                      await putUser();
                      // dropdownValue = '';
                      await widget.deleteing();
                      Navigator.pop(context);
                    },
                    child: Text('Update'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
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
      }
    });
    setState(() {});
  }

  deleteUser(int s) async {
    await ApiServices().deleteBix(s);
    widget.deleteing();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.BuildName;
    value = widget.bixType;
    Future.delayed(
      Duration(seconds: 1),
      () async {
        await getDropDownValues();

        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      color: widget.color == true
          ? Color.fromARGB(255, 146, 197, 228)
          : Colors.white70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              widget.BuildName,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.bixName,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.bixPort,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.bixExtension,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.bixType,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.lineType,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {
                // print(dropValues);
                _openPopup(context, widget.BuildName, widget.bixName,
                    widget.bixPort, widget.bixExtension, widget.lineType);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              label: Text(
                'Edit',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () async {
                await deleteUser(widget.bixID);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              label: Text(
                'Delete',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
