import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {

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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Container(
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
                      child: Text('Create User',style: TextStyle(fontSize: 20.0),),
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
