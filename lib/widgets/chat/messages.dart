import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chats')
                .orderBy('createdTime', descending: true)
                .snapshots(),
            builder: (ct, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              final data = snapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: data.length,
                itemBuilder: (ctx, i) {
                  return MessageBubble(data[i]['text'],
                      data[i]['uid'] == futureSnapshot.data.uid,ValueKey(data[i].documentID));
                },
              );
            }
        );
      },
    );
  }
}
