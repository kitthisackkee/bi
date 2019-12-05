import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bi/Form/register.dart';
import 'package:bi/Form/Payment.dart';


class Bilogin extends StatefulWidget {
  @override
  _BiloginState createState() => _BiloginState();
}

class _BiloginState extends State<Bilogin> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _email;
  String _password;

  void _submitCommand() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _loginCommand();
    }
  }

  void _loginCommand() {
    // This is just a demo, so no actual login here.
    final snackbar = SnackBar(
      content: Text('Email: $_email, password: $_password'),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  String msg = '';
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();



  Future<List> _login() async{
    final response= await http.post("http://192.168.0.119:1111/api/v1/login", body: {
      "username" : controllerUser.text,
      "password" : controllerPassword.text,
    });

    var datauser = json.decode(response.body);
    var status = datauser["status"];
    var status_error = datauser["status_error"];
    print("Reponse status:  ${response.statusCode}");
    print("Reponse body:  ${status}");
    print("Reponse status_error:  ${status_error}");

    if (status == 'succsess'){
      print("in if:  ${status}");
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Payment(),
      ));
    }


//    if(status_error == 'error'){
//      setState(() {
//        msg = "ຊື່ໃຊ້ ຫຼື ລະຫັດບໍ່ຖືກຕ້ອງ";
//      });
//    }else{
//      setState(() {
//        msg = "ຊື່ໃຊ້ ຫຼື ລະຫັດບໍ່ຖືກຕ້ອງ";
//      });
//    }

  }

  _onClear() {
    setState(() {
      controllerUser.text = "";
      controllerPassword.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 80.0,
        child: Image.asset('images/download.png'),
      ),
    );

    final email = TextFormField(

      validator: (val) => !EmailValidator.validate(val, true)
          ? 'Not a valid email.'
          : null,
      onSaved: (val) => _email = val,

      controller: controllerUser,
      keyboardType: TextInputType.text,
      autofocus: false,

      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),


    );

    final password = TextFormField(

      validator: (val) =>
      val.length < 4 ? 'Password too short..' : null,
      onSaved: (val) => _password = val,
      obscureText: true,

      controller: controllerPassword,
      autofocus: false,

      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'ລະຫັດຜ່ານ',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),


    );

    final loginButton = MaterialButton(
      // color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            setState(() {
              _login();
              _submitCommand;
              _onClear();
            });
          },
          padding: EdgeInsets.only(left: 50.0, right: 50.0),
          color: Colors.redAccent,
          child:  Center(
            child: Text('ເຂົ້າສູ່ລະບົບ', style: TextStyle(color: Colors.white, fontSize: 16,
                fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );


    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body:
          Form(
            key: formKey,
            child: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("images/Untitled-1.png"),
//            fit: BoxFit.cover,
//          ),
//        ),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    logo,
                    SizedBox(height: 15.0,),
                    Text("ລະບົບລົງທະບຽນ", style: TextStyle(color: Colors.redAccent, fontSize: 30.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),
                    Text("ສະຖາບັນການທະນາຄານ", style: TextStyle(color: Colors.redAccent, fontSize: 30.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),
                    Center(
                      child: Text(msg),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
//                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                    elevation: 4.0,
                          child: Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Column(
                              children: <Widget>[ListTile(
//                          leading:  const Icon(Icons.person),
                                title: email,
                              ),
                                SizedBox(height: 10.0,),
                                ListTile(

//                            leading:  const Icon(Icons.lock),
                                  title: password,
                                ),

                                SizedBox(height: 10.0,),
                                loginButton,
                                SizedBox(height: 20.0,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 180.0),
                                  child: Text(
                                    "ລືມລະຫັດຜ່ານ",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.grey,
                                        fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                        ),
                      ],
                    ),
                  ],
                ),

              ),

            ),
          ),


          );





  }
}






