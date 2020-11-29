import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final _message;
  final bool _isMe;
  final Key _key;

  MessageBubble(this._message, this._isMe,this._key);

  @override
  Widget build(BuildContext context) {
    return Row(
      key: _key,
      mainAxisAlignment: _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomLeft: _isMe ?Radius.circular(15):Radius.circular(0),
              bottomRight: !_isMe ?Radius.circular(15):Radius.circular(0),
            ),
            color: _isMe ? Colors.green : Colors.blueGrey,
          ),
          child: Text(
            _message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
