
import 'package:demo_login/api.dart';
import 'package:demo_login/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  bool remember = false;
  bool _passwordVisible = false;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _fromKey=GlobalKey<FormState>();
  String message='';
@override
  void dispose(){
  emailController.dispose();
  passController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 100, top: 150),
                        child: Column(
                          children: [
                            Text('Welcome back!', style: TextStyle(
                                fontSize: 35,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                            Text('Log back into your account             ',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                              ),)
                          ],
                        ),

                      ),
                    ),
                    height: 300,
                    decoration: BoxDecoration(
                        color: Color(0xff404F66),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70))
                    ),
                  ),
                  Positioned(
                      bottom: 30,
                      right: 15,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text('LOGIN', style:
                        TextStyle(fontSize: 70, color: Color(0xff46546B)),),)
                  )
                ],
              ),
              Stack(
                children: [
                  Positioned(
                      top: 10,
                      right: 15,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text('NOW', style:
                        TextStyle(fontSize: 70, color: Color(0xffF7F7F7)),),)),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 40,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 20),
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .always,
                              labelText: "Your Email",
                              labelStyle: TextStyle(
                                  color: Colors.black, fontSize: 20),
                              hintText: "Enter your your Email",
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: passController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 20),
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .always,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme
                                        .of(context)
                                        .primaryColorDark,
                                  )),
                              // suffixIcon: GestureDetector(
                              //   child: Icon(
                              //     Icons.visibility,
                              //     color: Colors.black,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              CupertinoSwitch(
                                activeColor: Colors.blueGrey,
                                value: remember,
                                onChanged: (value) {
                                  setState(() {
                                    remember = value;
                                  });
                                },
                              ),
                              Text("Remember", style: TextStyle(
                                fontSize: 15,
                              )),
                              Spacer(),
                              GestureDetector(
                                child: Text(
                                  "Forgot?",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),),
                ],
              ),
              SizedBox(height: 40,),
              Container(
                color: Colors.black,
                height: 50,
                width: 250,
                child: TextButton(
                  onPressed: () async {
                    if(_fromKey.currentState.validate()) {
                      var email = emailController.text;
                      var password = passController.text;
                      setState(() {
                        message='Please Wait....';
                      });
                      var rsp = await loginUser(email, password);
                      print(rsp);
                      if(rsp.contansKey('success')){
                        setState(() {
                          message=rsp['data'] ['name'];
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Login Success'),
                                content: Text(message),
                              )
                          );
                        });
                      } else{
                        setState(() {
                          message='Login Failed';
                        });
                      }
                    }
                  },
                  child: Text('LOG IN', style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  /*Future<void> login() async {
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response =
      await http.post(Uri("https://reqres.in/api/login"),
          body: ({
            'email': emailController.text,
            'password': passController.text}));
      if (response.statusCode == 200){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Second()));
      } else{
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(content: Text("Invalid Credentials.")));
      }
    } else{
    ScaffoldMessenger.of(context).
                showSnackBar(SnackBar(content: Text("Back Feild Not allowed ")));
    }

  }*/
}

