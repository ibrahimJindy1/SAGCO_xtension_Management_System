import 'package:abdulaziz_flutter/models/Building.dart';
import 'package:abdulaziz_flutter/services/api_services.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class BuildsInformations extends StatefulWidget {
  final String buildName;
  final int buildID;
  final bool color;
  final Function deleteing;
  const BuildsInformations(
      {Key? key,
      required this.buildName,
      required this.buildID,
      required this.deleteing,
      required this.color})
      : super(key: key);

  @override
  _BuildsInformationsState createState() => _BuildsInformationsState();
}

TextEditingController buildName = TextEditingController();

class _BuildsInformationsState extends State<BuildsInformations> {
  Future putBuild() async {
    Building b = Building(widget.buildID, buildName.text);
    await ApiServices().editBuild(b).then((value) async {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {}
    });
  }

  Future _openPopup(context, String buildN) async {
    buildName.text = buildN;

    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Text(
                    'Build Edit',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.w(8),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  TextField(
                    controller: buildName,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Bix Name',
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.h(50),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // await newUser();
                      await putBuild();
                      // dropdownValue = '';
                      await widget.deleteing();
                      Navigator.pop(context);
                    },
                    child: Text('Edit'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  deleteBuild(int s) async {
    await ApiServices().deleteBuild(s);
    widget.deleteing();
    setState(() {});
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
              widget.buildName,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {
                // print(dropValues);
                _openPopup(context, widget.buildName);
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
                await deleteBuild(widget.buildID);
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
