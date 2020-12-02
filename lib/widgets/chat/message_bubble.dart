import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message;
  final String userName;
  final bool isMe;
  final Key key;
  final userId;

  MessageBubble(
      {this.message, this.userName, this.isMe, this.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          FutureBuilder(
            future: FirebaseFirestore.instance.doc('users/$userId').get(),
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              return CircleAvatar(
                backgroundImage: NetworkImage(snap.data['image_url']),
              );
            },
          ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          padding: EdgeInsets.all(10),
          width:
              min(max((userName.length * 15.0), (message.length * 15.0)), 240),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              topLeft: isMe ? Radius.circular(15) : Radius.circular(0),
              topRight: !isMe ? Radius.circular(15) : Radius.circular(0),
            ),
            color: isMe ? Colors.green[600] : Colors.blueGrey,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if(!isMe)
              Text(
                userName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        if (isMe)
          FutureBuilder(
            future: FirebaseFirestore.instance.doc('users/$userId').get(),
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              return CircleAvatar(
                backgroundImage: NetworkImage(snap.data['image_url']),
              );
            },
          ),
      ],
    );
  }
}
