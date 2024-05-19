import 'package:flutter/material.dart';
import '../Configerrormessage.dart';
import '../Configfile.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _otpSent = false;
  String _enteredOTP = '';
  bool _showImage = false; // Added boolean variable to control image visibility

  void _sendOTP() {
    // Simulating OTP sending process (can be replaced with actual logic)
    setState(() {
      _otpSent = true;
      _showImage = true; // Show the image when OTP is sent
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Recovery'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Desktop View
            return _buildDesktopView();
          } else {
            // Mobile View
            return _buildMobileView();
          }
        },
      ),
    );
  }

  Widget _buildDesktopView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(AppConfig.image6Path, width: 600, height: 800),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 2,
              child: Container(
                width: 300,
                child: _buildForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Powered by",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 5),
              Image.asset(
                AppConfig.image4Path,
                width: 150,
                height: 100,
              ),
            ],
          ),
          Image.asset(AppConfig.image2Path, width: 150, height: 100),
          SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'E-mail',
              suffixIcon: Icon(Icons.email, color: Colors.purple),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppMessages.emailerror;
              }
              // Email validation rules
              if (!_isValidEmail(value)) {
                return AppMessages.invalidemailerror;
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _sendOTP();
            },
            child: Text(
              _otpSent ? 'Resend OTP' : 'Send OTP',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              backgroundColor: Colors.purple,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          if (_otpSent) ...[
            SizedBox(height: 20),
            Text('An OTP has been sent to your email.'),
            SizedBox(height: 20),
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Verify OTP and proceed to password reset
              },
              child: Text(
                'Verify OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  _enteredOTP = '';
                  _showImage = true; // Hide the image when clearing OTP
                });
              },
              child: Text('Clear OTP'),
            ),
            SizedBox(height: 20),
            if (_showImage) Image.asset(AppConfig.image1Path, width: 200, height: 150),
          ],
        ],
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9]{1,}@[a-zA-Z0-9.-]{2,}\.com$');
    return emailRegex.hasMatch(email) && email.length >= 1; // Add length check
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PasswordRecoveryPage(),
  ));
}
