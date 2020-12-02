import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdTime', descending: true)
          .snapshots(),
      builder: (ct, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        final data = snapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: data.length,
          itemBuilder: (ctx, i) {
            return MessageBubble(
              message: data[i].data()['text'],
              userName: data[i].data()['username'],
              isMe: data[i].data()['uid'] == user.uid,
              key: ValueKey(data[i].id),
              userId: data[i].data()['uid'],
            );
          },
        );
      },
    );
  }
}
