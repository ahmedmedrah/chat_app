import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    final user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection('chats').add({
      'text': _enteredMessage,
      'createdTime': Timestamp.now(),
      'uid': user.uid,
    });
    setState(() {
      _enteredMessage = '';
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Write a message'),
              onChanged: (val) {
                setState(() {
                  _enteredMessage = val;
                });
              },
              onSubmitted: (value) {
                if (_enteredMessage.trim().isNotEmpty) _sendMessage();
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
