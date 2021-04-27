import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firenbase_sample/screen/login.dart';
import 'package:flutter_application_firenbase_sample/screen/post.dart';

class ChatPage extends StatelessWidget {
  //引数からユーザ情報を受け取り
  ChatPage(this.user);
  final UserInfo user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }),
                );
              }),
        ],
      ),
      body: Column(
        //User Info View
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text('ユーザー情報 : ${user.email}'),
          ),
          Expanded(
            //非同期処理の結果をwidgetに反映
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('post')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {
                  //データ所得できたら
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data.documents;
                    return ListView(
                      children: documents.map((document) {
                        return Card(
                          child: ListTile(
                            title: Text(document['text']),
                            subtitle: Text(document['email']),
                            trailing: document['email'] == user.email
                                ? IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      //投稿メッセージのドキュメント削除
                                      await Firestore.instance
                                          .collection('post')
                                          .document(document.documentID)
                                          .delete();
                                    },
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return Center(
                    child: Text('読み込み中...'),
                  );
                  //データ読み込み中の場合
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddPostPage(user);
            }),
          );
        },
      ),
    );
  }
}
