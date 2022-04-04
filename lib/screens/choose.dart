import 'package:abdulaziz_flutter/screens/user_show.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserShowScreen()),
                );
              },
              child: Text(
                'Employees',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.w(24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
