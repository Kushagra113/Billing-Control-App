import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Variables
  bool emailEdit = true;
  bool otpbutton = true;
  bool otpfield = false;
  bool time_text = false;
  bool isLoading = false;
  bool resendOtp = false;
  bool boxes = false;

  final emailController = TextEditingController();
  int serverotp = 1111;
  final _formKey = GlobalKey<FormState>();

  void sendOtpRequest() {
    print("Sent OTP Request");
    setState(() {
      emailEdit = false;
      time_text = true;
      resendOtp = false;
      isLoading = false;
    });
  }

  // void _error() {
  //   // print("Hello Console");
  // }

  // Text Form Field For Mobile Number And OTP
  // Form _inputTextField(key) {
  //   return Form(
  //     key: _formKey,
  //     child: TextFormField(
  //       key: key,
  //       controller: myController,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(50.0),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(25.0),
  //           borderSide: BorderSide(
  //             // color: Colors.blue[100],
  //             width: 2.0,
  //           ),
  //         ),
  //       ),
  //       onTap: _error,
  //       // validator: (value) {
  //       //   print(key.toString());
  //       //   print(key.runtimeType);
  //       //   print(key==ValueKey(1));
  //       //   if (key == 1 && value.length != 6) {
  //       //     print(value.length);
  //       //     return "Please Enter Valid OTP";
  //       //   } else if (key == 2 && value.length != 10) {
  //       //     return "Please Enter Valid Phone Number";
  //       //   } else {
  //       //     return null;
  //       //   }
  //       // },
  //     ),
  //   );
  // }

  // Login Button
  // ElevatedButton LoginButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //      ,
  //     child: Text("Login"),
  //   );
  // }

  Widget EmailTextField() {
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            autofocus: true,
            enabled: emailEdit,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                suffixIcon: Icon(
                  Icons.email_rounded,
                  color: Colors.blue,
                ),
                hintText: "Email Address",
                hintStyle: TextStyle(color: Colors.blue[300]),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.blue[900])),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.blue[900])),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.red[600], width: 2.0)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        BorderSide(color: Colors.blue[600], width: 2.0)),
                // errorText: "Please Enter Some Text",
                errorStyle: TextStyle(fontSize: 15.0)),
            validator: (value) {
              if (EmailValidator.validate(value)) {
                return null;
              }
              return "Please Enter Valid Email Address";
            },
          ),
        ));
  }

  Widget OTPButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            setState(() {
              emailEdit = false;
              otpbutton = false;
              isLoading = true;
            });
            Future.delayed(const Duration(seconds: 5), () {
              sendOtpRequest();
              setState(() {
                isLoading = false;
                time_text = true;
                boxes = true;
                otpfield = true;
              });
            });
          }
        },
        child: Text("Email The OTP"));
  }

  Widget OTPTextField() {
    return OtpTextField(
        numberOfFields: 4,
        showFieldAsBox:
            true, //set to true to show as box or false to show as dash
        onCodeChanged: (String code) {
          //handle validation or checks here
        },
        enabledBorderColor: Colors.blue,
        onSubmit: (String verificationCode) {
          print(verificationCode);
          print(serverotp);
          if ((verificationCode.toString()).compareTo(serverotp.toString()) ==
              0) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/selection", (Route<dynamic> route) => false);
          } else {
            return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Invalid OTP"),
                    content: Text("Please Try Again"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"))
                    ],
                  );
                });
          }
        });
  }

  Widget OTPTimer() {
    return CountdownFormatted(
      duration: Duration(minutes: 0, seconds: 10),
      builder: (BuildContext ctx, String remaining) {
        return Text(
          "You can resend the OTP after $remaining",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        );
      },
      onFinish: () {
        setState(() {
          time_text = false;
          resendOtp = true;
          emailEdit = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EmailTextField(),
            otpbutton ? OTPButton() : Container(),
            SizedBox(height: 20),
            time_text
                ? Text("OTP Sent",
                    style: TextStyle(color: Colors.green[400], fontSize: 17.0))
                : Container(),
            boxes ? SizedBox(height: 20.0) : Container(),
            otpfield ? OTPTextField() : Container(),
            boxes ? SizedBox(height: 20) : Container(),
            time_text ? OTPTimer() : Container(),
            isLoading ? CircularProgressIndicator() : Container(),
            resendOtp
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        resendOtp = false;
                      });
                      Future.delayed(const Duration(seconds: 5), () {
                        sendOtpRequest();
                      });
                    },
                    child: Text("Resend OTP"))
                : Container(),
            boxes ? SizedBox(height: 20) : Container(),
            // sentotp ? LoginButton() : Container(),
          ],
        ),
      ),
    );
  }
}
