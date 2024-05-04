import 'package:flutter/material.dart';

import '../Configfile.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _otpSent = false;
  String _enteredOTP = '';

  void _sendOTP() {
    // Simulating OTP sending process (can be replaced with actual logic)
    setState(() {
      _otpSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Recovery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppConfig.image2Path, width: 150, height: 100),
            SizedBox(height: 10,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _sendOTP(); // Call the function to send OTP
              },
              child: Text(_otpSent ? 'Resend OTP' : 'Send OTP',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                minimumSize: Size(double.infinity, 50), // Set the width to match_parent and height to 50
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: Colors.purple, // Change the background color of the button
              ),
            ),
            if (_otpSent)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.0),
                  Text('An OTP has been sent to your email.'),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                          (index) => SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              _enteredOTP.length > index ? _enteredOTP[index] : '',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Verify OTP and proceed to password reset
                    },
                    child: Text('Verify OTP',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                      ),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      minimumSize: Size(double.infinity, 50), // Set the width to match_parent and height to 50
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      primary: Colors.purple, // Change the background color of the button
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _enteredOTP = '';
                      });
                    },
                    child: Text('Clear OTP'),
                  ),

                ],
              ),
            SizedBox(height: 10,),
            Image.asset(AppConfig.image1Path, width: 100, height: 100),
          ],

        ),

      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PasswordRecoveryPage(),
  ));
}
