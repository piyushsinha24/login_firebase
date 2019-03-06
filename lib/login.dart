import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = new GlobalKey<FormState>();
  String _username;
  String _password;

  bool validate_save() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validate_submit()async{
    if(validate_save()){
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _username, password: _password);
        print('Signed in: ${user.uid}');
      }catch(e){
        print('Errr : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Form(
                key: formkey,
                child: new Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                             // alignment: Alignment.topCenter,
                              image: AssetImage(
                                'assets/monkey.gif',
                              ),
                              fit: BoxFit.cover),
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        hintText: 'Username',
                        icon: Icon(Icons.assignment_ind),
                      ),
                      validator: (value) => value.isEmpty
                          ? "Username field can't be empty"
                          : null,
                      onSaved: (value) => _username = value,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        hintText: 'Password',
                        icon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) => value.isEmpty
                          ? "Password field can't be empty"
                          : null,
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: validate_submit,
                      textColor: Colors.white,
                      padding: EdgeInsets.only(left: 5.0,right: 5.0),
                      color: Colors.pink,
                      splashColor: Colors.transparent,
                      child: Text('Login',style: TextStyle(fontSize: 20.0),),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
