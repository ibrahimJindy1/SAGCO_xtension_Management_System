import 'package:abdulaziz_flutter/components/buildings_show_header.dart';
import 'package:abdulaziz_flutter/components/user_signed_show_builds_informations.dart';
import 'package:abdulaziz_flutter/models/Building.dart';
import 'package:abdulaziz_flutter/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'sign_page.dart';

class BuildScreen extends StatefulWidget {
  const BuildScreen({Key? key}) : super(key: key);

  @override
  _BuildScreenState createState() => _BuildScreenState();
}

late List<dynamic> builds;
List<dynamic> tempBuilds = [];
TextEditingController buildName = TextEditingController();
String? dropdownValue = 'Build Name';
TextEditingController searchBy = TextEditingController();

class _BuildScreenState extends State<BuildScreen> {
  Future getAllBuilds() async {
    await ApiServices().getBixesBuilds().then((value) {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {
        // bixes.addAll(value as List<dynamic>);
        builds = List.from(value);
        tempBuilds = List.from(value);
        setState(() {});
      } else {
        EasyLoading.showError(value.toString());
      }
    });
    return builds;
  }

  Future newBuild() async {
    Building b = Building(0, buildName.text);
    await ApiServices().putBuild(b).then((value) async {
      if (!value.toString().contains('Request failed') &&
          !value.toString().contains('Error')) {
      } else {
        EasyLoading.showError(value.toString());
      }
    });
  }

  searchByBuildName(String? id) {
    tempBuilds.clear();
    tempBuilds = List.from(builds
        .where((element) => element['buildName']
            .toString()
            .toLowerCase()
            .contains(id!.toLowerCase()))
        .toList());
    setState(() {});
  }

  emptySearch() {
    tempBuilds.clear();
    setState(() {
      tempBuilds.addAll(builds);
    });
  }

  onSearchChange(String? s) {
    if (s == '') {
      emptySearch();
    } else if (dropdownValue == 'Build Name') {
      searchByBuildName(s);
    }
  }

  Future _openPopup(context, String buildN) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Text(
                    'Add Build',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.w(8),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  TextField(
                    textDirection: TextDirection.ltr,
                    controller: buildName,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Build Name',
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.h(50),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await newBuild();
                      dropdownValue = 'Build Name';
                      await getAllBuilds();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.showProgress(0.3,
        status: 'Loading...', maskType: EasyLoadingMaskType.clear);
    Future.delayed(
      Duration(seconds: 1),
      () async {
        await getAllBuilds();
        setState(() {});
        EasyLoading.dismiss();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _openPopup(context, '');
        },
        backgroundColor: Colors.blueAccent,
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
              await getAllBuilds();
              EasyLoading.dismiss();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: SizeConfig.w(5),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
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
                  value: 'Build Name',
                  child: Text('Build Name'),
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
          Text(
            'Buildings',
            style: TextStyle(fontSize: SizeConfig.w(12)),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 50,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: BuildingsHeader(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tempBuilds.length,
              itemBuilder: (cnt, ind) {
                return BuildsInformations(
                  buildName: tempBuilds[ind]['buildName'],
                  buildID: tempBuilds[ind]['ind'],
                  deleteing: () => getAllBuilds(),
                  color: ind % 2 == 0 ? true : false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
