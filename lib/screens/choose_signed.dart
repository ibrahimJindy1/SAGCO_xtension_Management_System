import 'package:abdulaziz_flutter/screens/bixes_signed_screen.dart';
import 'package:abdulaziz_flutter/screens/user_signed_show.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'build_signed_screen.dart';

class ChooseSignedScreen extends StatefulWidget {
  const ChooseSignedScreen({Key? key}) : super(key: key);

  @override
  _ChooseSignedScreenState createState() => _ChooseSignedScreenState();
}

class _ChooseSignedScreenState extends State<ChooseSignedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserSignedShowScreen()),
                );
              },
              child: Text(
                'Employees',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.w(16),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BixesSignedScreen()),
                );
              },
              child: Text(
                'Bixes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.w(16),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BuildScreen()),
                );
              },
              child: Text(
                'Buildings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.w(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
