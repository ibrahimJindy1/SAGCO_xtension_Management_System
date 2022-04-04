import 'package:abdulaziz_flutter/models/User_Type.dart';
import 'package:abdulaziz_flutter/models/user.dart';
import 'package:abdulaziz_flutter/services/api_services.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class UserSignedShowInformation extends StatefulWidget {
  final String department, name, email, exNo, password, mobileNum, mobileCode;
  final bool color, IsIT;
  final Function deleteing;
  final int userFK, typeInd;
  const UserSignedShowInformation({
    Key? key,
    required this.department,
    required this.name,
    required this.email,
    required this.exNo,
    required this.color,
    required this.deleteing,
    required this.IsIT,
    required this.password,
    required this.userFK,
    required this.typeInd,
    required this.mobileNum,
    required this.mobileCode,
  }) : super(key: key);

  @override
  State<UserSignedShowInformation> createState() =>
      _UserSignedShowInformationState();
}

String? dropdownValue = '';
List<String> dropValues = [];
List<Map<String, dynamic>> values = [];
TextEditingController usernameT = TextEditingController();
TextEditingController passwordT = TextEditingController();
TextEditingController emailT = TextEditingController();
TextEditingController exNOT = TextEditingController();
TextEditingController mobNum = TextEditingController();
TextEditingController mobCode = TextEditingController();

class _UserSignedShowInformationState extends State<UserSignedShowInformation> {
  Future putUser() async {
    User_Type t = User_Type(widget.typeInd, widget.userFK,
        values[dropValues.indexOf(dropdownValue!)]['ind']);
    User u = User(widget.userFK, usernameT.text, passwordT.text, value!,
        emailT.text, exNOT.text, mobNum.text, mobCode.text);
    await ApiServices().editUser(u).then((value) async {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {
        await ApiServices().editUserType(t);
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
      }
    });
    setState(() {});
  }

  deleteUser(int s) async {
    await ApiServices().deleteUser(s);
    widget.deleteing();
    setState(() {});
  }

  bool? value = false;
  isAdmin(bool? val) {
    if (val == true) {
      value = true;
    } else {
      value = false;
    }
  }

  Future _openPopup(context, String departmen, String username, String password,
      String email, String exNO, String mobileNum, String mobileCode) async {
    dropdownValue = departmen;
    usernameT.text = username;
    passwordT.text = password;
    emailT.text = email;
    exNOT.text = exNO;
    mobNum.text = mobileNum;
    mobCode.text = mobileCode;
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Text(
                    'Employee Edit',
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
                      await putUser();
                      await widget.deleteing();
                      setAll();
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

  setAll() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.IsIT;
    dropdownValue = widget.department;
    Future.delayed(Duration(seconds: 1), () async {
      await getDropDownValues();
    });
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
              widget.department,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.name,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.email,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.exNo,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.mobileNum,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              widget.mobileCode,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {
                print(dropValues);
                _openPopup(
                  context,
                  widget.department,
                  widget.name,
                  widget.password,
                  widget.email,
                  widget.exNo,
                  widget.mobileNum,
                  widget.mobileCode,
                );
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
                await deleteUser(widget.userFK);
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
