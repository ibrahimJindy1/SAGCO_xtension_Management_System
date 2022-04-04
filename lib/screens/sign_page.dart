import 'package:abdulaziz_flutter/screens/bixes_signed_screen.dart';
import 'package:abdulaziz_flutter/screens/choose.dart';
import 'package:abdulaziz_flutter/screens/choose_signed.dart';
import 'package:abdulaziz_flutter/screens/user_show.dart';
import 'package:abdulaziz_flutter/screens/user_signed_show.dart';
import 'package:abdulaziz_flutter/services/api_services.dart';
import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/alignment.dart';

import '../components/loader_dialog.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

TextEditingController id = TextEditingController();
TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
String error = '';
String u = '';
final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(u == '' ? 'Hello World' : u),
      // ),
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 200),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.1,
                            blurRadius: 9,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            error,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: SizeConfig.w(8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/SG Logo.png'),
                            height: SizeConfig.w(50),
                            width: SizeConfig.h(100),
                          ),
                          SizedBox(
                            height: SizeConfig.h(30),
                          ),
                          Text(
                            'SAGCO Extension Management System',
                            style: TextStyle(
                              color: Color(0xFF0a7ef5),
                              fontSize: SizeConfig.w(6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('IT Login Page',
                              style: TextStyle(
                                color: Color(0xFF0a7ef5),
                                fontSize: SizeConfig.w(6),
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: SizeConfig.h(30),
                          ),
                          Container(
                            color: Color(0xFFf7f7f7),
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            width: SizeConfig.w(300),
                            height: SizeConfig.h(40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: SizeConfig.h(50),
                                    child: const DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Color(0xff0a7ef5)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  flex: 80,
                                  child: Center(
                                    child: TextField(
                                      controller: username,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Color(0xff9e9e9e),
                                        fontSize: SizeConfig.w(5),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Username',
                                        hintStyle: TextStyle(
                                          color: Color(0xff9e9e9e),
                                          fontSize: SizeConfig.w(5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.h(10),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Container(
                              color: Color(0xFFf7f7f7),
                              width: SizeConfig.w(300),
                              height: SizeConfig.h(40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: SizeConfig.h(50),
                                      child: const DecoratedBox(
                                        decoration: const BoxDecoration(
                                            color: Color(0xff0a7ef5)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.w(2),
                                  ),
                                  Expanded(
                                    flex: 80,
                                    child: Center(
                                      child: TextField(
                                        controller: password,
                                        maxLines: 1,
                                        obscureText: true,
                                        style: TextStyle(
                                          color: Color(0xff9e9e9e),
                                          fontSize: SizeConfig.w(5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                            color: Color(0xff9e9e9e),
                                            fontSize: SizeConfig.w(5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.h(20),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserShowScreen()),
                              );
                            },
                            child: Text(
                              'Continue Without Sign In',
                              style: TextStyle(
                                color: Color(0xFF0a7ef5),
                                fontSize: SizeConfig.w(5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.h(20),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (username.text.trim() != '' &&
                                    password.text.trim() != '') {
                                  LoaderDialog.showLoadingDialog(
                                      context, _LoaderDialog);
                                  await ApiServices()
                                      .getUser(username.text, password.text)
                                      .then((value) {
                                    if (!value.toString().contains('Error') &&
                                        !value
                                            .toString()
                                            .contains('Request failed') &&
                                        !value
                                            .toString()
                                            .contains('NotFound')) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChooseSignedScreen()),
                                      );
                                    } else {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      setState(() {
                                        error = 'Error in Sign in...';
                                      });
                                    }
                                  });
                                } else {
                                  setState(() {
                                    error = 'Please Fill Username and Password';
                                  });
                                }
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.w(5),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF0a7ef5),
                                fixedSize:
                                    Size(SizeConfig.w(300), SizeConfig.h(40)),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(
                                      SizeConfig.w(15)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.h(180),
                          ),
                          Text(
                            'Powered by : SAGCO IT Team',
                            style: TextStyle(
                              color: Color(0xFF0a7ef5),
                              fontSize: SizeConfig.w(3),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Expanded(
                  //   flex: 7,
                  //   child: Container(
                  //     height: double.infinity,
                  //     child: Image.asset(
                  //       'assets/signBack.jpg',
                  //       fit: BoxFit.fitHeight,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
