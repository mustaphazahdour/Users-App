import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:users_app/widgets/progress_dialog.dart';


class SignUpScreen extends StatefulWidget
{
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen>
{
  bool isHiddenPassword = true;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if(nameTextEditingController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be atleast 3 Characters.");
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be atleast 6 Characters.");
    }
    else
    {
      saveUserInfoNow();
    }
  }

  saveUserInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      Map userMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference reference = FirebaseDatabase.instance.ref().child("users");
      reference.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xfffac213),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFAC213),
    onPrimaryContainer: Color(0xFFF77E21),
    secondary: Color(0xFFC5A9B4),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFD9E0),
    onSecondaryContainer: Color(0xFF2B151A),
    tertiary: Color(0xFF9299A5),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDCB9),
    onTertiaryContainer: Color(0xFF2C1600),
    error: Color(0xFFBA1B1B),
    errorContainer: Color(0xFFFFDAD4),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410001),
    background: Color(0xFFFCFCFC),
    onBackground: Color(0xFF201A1B),
    surface: Color(0xFFFCFCFC),
    onSurface: Color(0xFF201A1B),
    surfaceVariant: Color(0xFFF3DDE0),
    onSurfaceVariant: Color(0xFF514345),
    outline: Color(0xFF847376),
    onInverseSurface: Color(0xFFFAEEEF),
    inverseSurface: Color(0xFF362F30),
    inversePrimary: Color(0xFFFFB1C3),
    shadow: Color(0xFF000000),
  );


  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            colorScheme: lightColorScheme,
            textTheme: GoogleFonts.openSansTextTheme().apply(
                displayColor: const Color(0xFF383838),
                bodyColor: const Color(0xFF383838)),
            useMaterial3: true),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                  parent: NeverScrollableScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Welcome,',
                                  style: TextStyle(
                                      fontSize: 34, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Sign up as user',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: lightColorScheme.tertiary),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                                borderSide: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.tertiary),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              labelText: 'Email',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: nameTextEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                                borderSide: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.tertiary),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              labelText: 'Name',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: phoneTextEditingController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                                borderSide: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.tertiary),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                                child: Text(
                                  " (+213) ",
                                  style: TextStyle(color: Colors.black, fontSize: 17),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              labelText: 'Phone',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                              controller: passwordTextEditingController,
                              keyboardType: TextInputType.text,
                              obscureText: isHiddenPassword,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(14)),
                                    borderSide: BorderSide(
                                        color:
                                        Theme
                                            .of(context)
                                            .colorScheme
                                            .tertiary),
                                  ),

                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  labelText: 'Password',
                                  hintText: "Password",
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView,
                                    child: Icon(Icons.visibility),

                                  ))

                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                stops: [
                                  0.20,
                                  0.90,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFFF77E21),
                                  Color(0xFFFAC213),
                                ],
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(14)),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                              ),
                              onPressed: () {validateForm();},
                              child: const Text('Sign up'),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      "Already have an Account? Login Here",
                      style: TextStyle(color: Color(0xFF212124)),
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                    },
                  ),

                ],
              ),
            ),
          ),
        ));
  }
  void _togglePasswordView() {
    if(isHiddenPassword==true){
      isHiddenPassword=false;
    }else {
      isHiddenPassword=true;
    }
    setState(() {

    });
  }
}
