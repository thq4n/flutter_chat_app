
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String image;
  final bool isMe;
  const MessageBubble(this.message, this.isMe, this.username, this.image,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe)
                CircleAvatar(
                  backgroundImage: NetworkImage(image),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 30, maxWidth: 200),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.grey[300]
                          : Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft:
                            !isMe ? const Radius.circular(0) : const Radius.circular(15),
                        bottomRight:
                            isMe ? const Radius.circular(0) : const Radius.circular(15),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                          fontSize: 18,
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
                      child: Text(
                        username,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
