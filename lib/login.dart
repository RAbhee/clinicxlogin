import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/register.dart';
import 'Configerrormessage.dart';
import 'Configfile.dart';
import 'Superadmin/Dashboard.dart';
import 'Superadmin/Forgot_password.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    // Determine layout based on device size
    if (MediaQuery.of(context).size.width > 600) {
      return _buildDesktopLayout(context);
    } else {
      return _buildMobileLayout(context);
    }
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      appBar: null, // Hide the app bar
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromRGBO(244, 247, 251, 1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppConfig.image5Path, // Replace with your image path
                width: 400,
                height: 480, // Match the height of the container
                fit: BoxFit.cover, // Adjust how the image fits the space
              ),
              SizedBox(width: 10,),
              // Container with sign-in content
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: 600,
                    constraints: BoxConstraints(maxWidth: 600),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(133, 189, 215, 0.878),
                          blurRadius: 30.0,
                          offset: Offset(0, 30),
                          spreadRadius: -20.0,
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [Colors.white, Color.fromRGBO(244, 247, 251, 1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      border: Border.all(color: Colors.white, width: 5.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Powered by",style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),),
                            SizedBox(width: 5,),
                            Image.asset(
                              AppConfig.image4Path, // Image above image2Path
                              width: 150,
                              height: 100,
                            ),
                          ],
                        ),
                        Image.asset(
                          AppConfig.image2Path,
                          width: 150,
                          height: 100,
                        ), // Logo image
                        SizedBox(height: 5.0),
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        FormWidget(), // Your Sign In Form Widget
                        SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            'Don\'t have an account? Register here',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Image.asset(
                          AppConfig.image1Path,
                          height: 160,
                          width: 230,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Image on the other side
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Container(
          margin: EdgeInsets.all(20.0),
          constraints: BoxConstraints(maxWidth: 350.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(133, 189, 215, 0.878),
                blurRadius: 30.0,
                offset: Offset(0, 30),
                spreadRadius: -20.0,
              ),
            ],
            gradient: LinearGradient(
              colors: [Colors.white, Color.fromRGBO(244, 247, 251, 1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Colors.white, width: 5.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  AppConfig.image2Path,
                  width: 100,
                  height: 150
              ), // Logo image
              Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 5.0),
              FormWidget(),
              SizedBox(height: 25.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Register here',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Image.asset(
                AppConfig.image1Path,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

// FormWidget and its dependencies

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final _formKey = GlobalKey<FormState>(); // Key for the Form widget
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Track password visibility


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose(); // Dispose the controllers
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Form(
        key: _formKey, // Assigning the form key
        child: Column(
          children: [
            TextFormField(
              controller: _emailController, // Assign controller to email field
              decoration: InputDecoration(
                labelText: 'E-mail',
                suffixIcon: Icon(Icons.email,color: Colors.purple,) ,
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
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController, // Assign controller to password field
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
                    });
                  },
                  child: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.purple,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              obscureText: !_isPasswordVisible, // Use obscureText based on visibility state
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppMessages.passworderror;
                }
                // Password validation rules
                if (!_isValidPassword(value)) {
                  return AppMessages.incorrectpassworderror;

                }
                return null;
              },
            ),
            SizedBox(height: 5.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordRecoveryPage()),
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, handle form submission here
                  // For example, call a function to submit the form data
                  _submitForm();
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0), backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50), // Set the width to match_parent and height to 50
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ), // Change the background color of the button
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to check email validity
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9]{1,}@[a-zA-Z0-9.-]{2,}\.com$');
    return emailRegex.hasMatch(email) && email.length >= 1; // Add length check
  }


  // Helper function to check password validity
  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[!@#$&*])(?=.*?[0-9]).{6,}$');
    return passwordRegex.hasMatch(password);
  }
  // Function to handle form submission
  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Sign in with email and password
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Navigate to the dashboard for authenticated users
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SubmitScreen()),
        );
      } catch (e) {
        // Handle sign-in errors
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password. Please try again.'),
          ),
        );
      }
    }
  }
}

