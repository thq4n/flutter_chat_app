import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _inputController = TextEditingController();
  String? _inputText;

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("chat").add({
      "text": _inputText!.trim(),
      "createdAt": Timestamp.now(),
      "userId": user!.uid,
    });

    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    labelText: "Send a message ...",
                    floatingLabelBehavior: FloatingLabelBehavior.never),
                onChanged: (value) {
                  setState(() {
                    _inputText = value;
                  });
                },
              ),
            ),
          ),
          IconButton(
            onPressed: (_inputText == null || _inputText!.isEmpty)
                ? null
                : _sendMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
