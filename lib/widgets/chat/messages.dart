import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/splash_screen.dart';
import 'package:flutter_chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        final chatData =
            chatSnapshot.data as QuerySnapshot<Map<String, dynamic>>;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) {
            return MessageBubble(
              chatData.docs[index]["text"],
              chatData.docs[index]["userId"] == user!.uid,
              key: ValueKey(chatData.docs[index].id),
            );
          },
          itemCount: chatData.docs.length,
        );
      },
    );
  }
}
