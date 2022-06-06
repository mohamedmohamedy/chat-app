import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  final String theMessage;
  final bool isMe;
  final String userName;
  final String imageUrl;

  const BubbleMessage({
    required this.isMe,
    required this.theMessage,
    required this.userName,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                ),
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6!.color,
                    ),
                  ),
                  Text(
                    theMessage,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6!
                                .color),
                    textAlign: isMe ? TextAlign.right : TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
