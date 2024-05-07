import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Configfile.dart';
import 'Superadmin/Dashboard.dart';
import 'Superadmin/Forgot_password.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:
        Stack(
            fit: StackFit.expand,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return _buildDesktopLayout(context);
                  } else {
                    return _buildMobileLayout(context);
                  }
                },
              ),
            ]
        ),
      ),
    );
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
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppConfig.image5Path, // Replace with your image path
                width: 600,
                height: double.infinity, // Match the height of the container
                fit: BoxFit.cover, // Adjust how the image fits the space
              ),
              SizedBox(width: 20,),
              // Container with sign-in content
              SingleChildScrollView(
                child: Container(
                  width: 700,
                  height: 800,
                  padding: EdgeInsets.all(5.0),
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
              Image.asset(AppConfig.image2Path, width: 100, height: 150), // Logo image
              SizedBox(height: 10.0),
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
                  return 'Please enter your email';
                }
                // Email validation rules
                if (!_isValidEmail(value)) {
                  return 'Invalid email format';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController, // Assign controller to password field
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                // Password validation rules
                if (!_isValidPassword(value)) {
                  return 'Password must be at least 6 characters long, contain at least one uppercase letter, and one special character.';
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
    final emailRegex = RegExp(r'^[a-zA-Z0-9._]{1,}@[a-zA-Z0-9.-]{2,}\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email) && email.length >= 1; // Add length check
  }

  // Helper function to check password validity
  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[!@#$&*])(?=.*?[0-9]).{6,}$');
    return passwordRegex.hasMatch(password);
  }

  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Sign in with email and password
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Check if the user is a superadmin
        bool isSuperadmin = await _checkSuperadminCredentials(userCredential.user!);

        if (isSuperadmin) {
          // Navigate to the dashboard for superadmins
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SubmitScreen()),
          );
        } else {
          // Not a superadmin, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid credentials for superadmin access.'),
            ),
          );
        }
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

  Future<bool> _checkSuperadminCredentials(User user) async {
    // Get the superadmin document from Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('super_admins')
        .doc(user.email)
        .get();

    if (snapshot.exists) {
      // Check if the email and password match the stored credentials
      return snapshot.get('password') == _passwordController.text;
    } else {
      return false; // Superadmin document not found
    }
  }

}


class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Text('Registration Form Goes Here'),
      ),
    );
  }
}