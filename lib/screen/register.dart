import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_firenbase_sample/screen/register_success.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Message View
  String infoText = '';
  //Mail,PW
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                //Message View
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                //Register button
                child: ElevatedButton(
                  child: Text('ユーザー登録'),
                  onPressed: () async {
                    try {
                      //Register with email and PW
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      //Success
                      //チャット画面に遷移＋ログイン画面破棄
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return RegisterSuccess();
                        }),
                      );
                    } catch (e) {
                      //Failed
                      setState(() {
                        infoText = '登録に失敗しました : ${e.toString()}';
                      });
                    }
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('ログインに戻る'),
                  onPressed: () {
                    // 1つ前に戻る
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
