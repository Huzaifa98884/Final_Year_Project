import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/widgets/img.dart';
import 'package:fyp/widgets/loading_screen.dart';
import 'package:fyp/widgets/my_text.dart';
import '../models/UserModel.dart';
import 'login_screen.dart';
import 'package:email_auth/email_auth.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen();

  @override
  RegistrationScreenState createState() => new RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final otpcontroller = TextEditingController();
  String _dropDownValue = 'Visitor';
  bool isLoading = true;
  EmailAuth emailAuth =  new EmailAuth(sessionName: "Test session");
  
  // sendOPT() async{
  //
  //   var res = await emailAuth.sendOtp(recipientMail: emailController.text);
  //   if(res){
  //     Fluttertoast.showToast(msg: "OTP sent");
  //     return 1;
  //   }
  //   else{
  //     Fluttertoast.showToast(msg: "We could not sent OTP");
  //     return 0;
  //   }
  // }
  //
  // verifyOTP(){
  //   var res = emailAuth.validateOtp(recipientMail: emailController.text, userOtp: otpcontroller.text);
  //   if(res){
  //     return 1;
  //   }
  //   else{
  //     return 0;
  //   }
  // }
  bool check = false;
  @override
  Widget build(BuildContext context) =>
  check?
      Loading_Page():
     new Scaffold(
      backgroundColor: Colors.transparent,
      appBar:
      PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: Stack(
        children: <Widget>[
          Container(
              child: Image.asset(Img.get('bg4.jpeg'),
                  fit: BoxFit.fill),
              height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

          ),
          // Container(
          //   color: Colors.cyan[800]!.withOpacity(0.7),
          // ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(Img.get('LOGO_REDLINE.png'),
                      color: Colors.white,),
                    Text("REDLINE ANIMALIA",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(height: 5),
                    Text("Register",
                        style: MyText.medium(context).copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
//Text field data is stored in emailController
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Enter Valid Email");
                        }
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey[100],
                        focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.white , width: 1.5),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                        filled: false,
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white , width: 0.5),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Enter Valid Username");
                        }
                      },
                      onSaved: (value) {
                        usernameController.text = value!;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white , width: 1.5),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                        filled: false,
                        hintText: "Username",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white , width: 0.5),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
//Text field data is stored in emailController
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Enter Valid Password");
                        }
                      },
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white , width: 1.5),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                        filled: false,
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white , width: 0.5),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: confirmpasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Password doesnot match");
                        }
                      },
                      onSaved: (value) {
                        confirmpasswordController.text = value!;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                        filled: false,
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white , width: 0.5),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                      ),
                    ),
                    Container(height: 15),

                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.white)),
                      elevation: 5,
                      color: Color(0x00000000),
                      child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                          onPressed: () async {
                            setState(() {
                              check = true;
                            });
                            if (passwordController.text !=
                                confirmpasswordController
                                    .text) {
                              Fluttertoast.showToast(
                                  msg: "Password doesnt match",
                                  toastLength: Toast
                                      .LENGTH_SHORT,
                                  gravity: ToastGravity
                                      .BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              signUp(emailController.text,
                                  passwordController.text,
                                  _dropDownValue);
                            }
                            setState(() {
                              check = false;
                            });
                          },
                          child: Text(
                            "SIGNUP",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                      },
                      child: Text("Already Signed Up!"
                        ,style: (
                            TextStyle(
                                color: Colors.white,
                                fontSize: 17
                            )
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );


  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore(String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();


    // writing all the values

    userModel.email = emailController.text;
    userModel.password = passwordController.text;
    userModel.username = usernameController.text;


    await firebaseFirestore
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM").collection(role).doc(user!.uid)
        .set(userModel.toMapRegistrationDetails());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()));
  }

  void signUp(String email, String password , String role) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore(role)})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }


}




// TextFormField(
// keyboardType: TextInputType.text,
// controller: usernameController,
// validator: (value) {
// if (value!.isEmpty) {
// return ("Enter Valid Username");
// }
// },
// onSaved: (value) {
// usernameController.text = value!;
// },
// decoration: InputDecoration(
// labelText: "USERNAME",
// labelStyle: TextStyle(color: Colors.white),
// enabledBorder: UnderlineInputBorder(
// borderSide: BorderSide(color: Colors.white, width: 1),
// ),
// focusedBorder: UnderlineInputBorder(
// borderSide: BorderSide(color: Colors.white, width: 2),
// ),
// ),
// )




// Drop down button Code
// DropdownButton(
// dropdownColor: Colors.teal[800],
// hint: _dropDownValue == 'Visitor'
// ? Text('Visitor',
// style: TextStyle(color: Colors.white),)
// : Text(
// _dropDownValue,
// style: TextStyle(color: Colors.white),
// ),
// isExpanded: true,
// iconSize: 40.0,
// style: TextStyle(color: Colors.white),
// items: ['Visitor', 'Management'].map(
// (val) {
// return DropdownMenuItem<String>(
// value: val,
// child: Text(val),
// );
// },
// ).toList(),
// onChanged: (val) {
// setState(
// () {
// _dropDownValue = val.toString();
// },
// );
// },
// ),