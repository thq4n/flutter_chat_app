import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userId;
  final bool isMe;
  const MessageBubble(this.message, this.isMe, this.userId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: FirebaseFirestore.instance.collection("users").doc(userId).get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Waiting...");
        }

        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isMe)
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data["image_url"]),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.grey[300]
                              : Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: !isMe
                                ? Radius.circular(0)
                                : Radius.circular(15),
                            bottomRight:
                                isMe ? Radius.circular(0) : Radius.circular(15),
                          ),
                        ),
                        width: 140,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: isMe
                                  ? Colors.black
                                  : Theme.of(context)
                                      .accentTextTheme
                                      .headline6!
                                      .color),
                        ),
                      ),
                      if (!isMe)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(snapshot.data["username"]),
                        )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
