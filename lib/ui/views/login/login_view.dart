import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_web_app/ui/views/note/note_view.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text("Login")),
          body: Stack(children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset("images/image_01.png"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                height: 250.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.brown[200]),
                        labelText: 'Username',
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.brown[200]),
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 120.0,
                      height: 40.0,
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NoteView()),
                          );
                        },
                        child: Text('Login'),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ])),
    );
  }
}
