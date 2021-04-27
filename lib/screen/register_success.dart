import 'package:flutter/material.dart';
import 'package:flutter_application_firenbase_sample/screen/login.dart';

class RegisterSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          //User Info View
          child: Column(
        children: <Widget>[
          Container(
            child: Text('登録完了しましたよー。'),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Text('ログイン画面に戻る'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
