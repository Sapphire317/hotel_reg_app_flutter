import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confpwdController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {
    return Form(
    key: _formKey,
      child:
      Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height:80.0),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Username';
                }
              },
            ),
            SizedBox(height:12.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Password';
                }
              },
              obscureText: true,
            ),
            SizedBox(height:12.0),
            TextFormField(
              controller: _confpwdController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Confirm Password',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Confirm Password';
                }
              },
              obscureText: true,
            ),
            SizedBox(height:12.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email Address',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Email Address';
                }
              },
            ),
            SizedBox(height:12.0),
            ButtonBar(
              children:<Widget>[
                RaisedButton(
                  child:Text('Sign Up'),
                  onPressed:(){
                    if (_formKey.currentState.validate()) {

                    }
                  }
                )
              ]
            )
          ],

        )
      )
    )
    );
  }
}