import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './CustomShapeClipper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:<Widget>[ Center(
          child: Column(
            children: <Widget>[
              LoginPageTop(),
              LoginPageBottom(),
            ],
          ),
        ),],
      ),
    );
  }
}

class LoginPageTop extends StatefulWidget {
  @override
  _LoginPageTopState createState() => _LoginPageTopState();
}

class _LoginPageTopState extends State<LoginPageTop> {
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

  void validate_submit() async {
    if (validate_save()) {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _username, password: _password);
        print('Signed in: ${user.uid}');
      } catch (e) {
        print('Errr : $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400.0,
            color: Colors.pink,
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                              icon: Icon(Icons.assignment_ind,color: Colors.white,),
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
                              icon: Icon(Icons.lock,color: Colors.white,),
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
                            textColor: Colors.pink,
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            color: Colors.white,
                            splashColor: Colors.transparent,
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class LoginPageBottom extends StatelessWidget {

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
            .createUserWithEmailAndPassword(email: _username, password: _password);
        print('Registered User: ${user.uid}');
      }catch(e){
        print('Errr : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Form(
                key: formkey,
                child: new Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60.0,
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
                      padding: EdgeInsets.only(left: 8.0,right: 8.0),
                      color: Colors.pink,
                      splashColor: Colors.transparent,
                      child: Text('Register',style: TextStyle(fontSize: 20.0),),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    )
                  ],
                )),
          ],
        ),
      );

  }
}

