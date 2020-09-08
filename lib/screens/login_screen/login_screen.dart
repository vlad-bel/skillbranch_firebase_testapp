import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  ///todo remove test number
  final numberInputController = TextEditingController(text: '+1 222-333-4445');

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(),
          SizedBox(height: 28),
          _buildNumberInput(),
          SizedBox(height: 12),
          _buildNumberLoginButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Text(
        "firebase_test_app",
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget _buildNumberInput() {
    return Container(
        width: 280,
        child: TextField(
          controller: numberInputController,
        ));
  }

  Widget _buildNumberLoginButton() {
    return Container(
      width: 280,
      child: RaisedButton(
          child: Text("login by number"),
          onPressed: () async {
            ///todo login
            await registerUser(numberInputController.text);
          }),
    );
  }

  Future registerUser(String number) async {
    return auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: Duration(seconds: 60),
      verificationCompleted: (authCredentional) {
        print("Пользователь авторизован! $authCredentional");
      },
      verificationFailed: (error) {
        print("Ошибка авторизации $error");
      },
      codeSent: (verifactionId, forceResendingToken) async {
        final userCredentionals = await showDialog<UserCredential>(
            context: context,
            builder: (context) {
              final smsCodeController = TextEditingController(text: '123456');
              return AlertDialog(
                title: Text("sms confirmation"),
                content: TextField(
                  controller: smsCodeController,
                ),
                actions: [
                  RaisedButton(
                    child: Text("confirm"),
                    onPressed: () async {
                      final userCreds = PhoneAuthProvider.credential(
                        verificationId: verifactionId,
                        smsCode: smsCodeController.text,
                      );
                      final userAuth =
                          await auth.signInWithCredential(userCreds);

                      Navigator.of(context).pop(userAuth);
                    },
                  ),
                ],
              );
            });
        print("Пользователь авторизован $userCredentionals");
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}

