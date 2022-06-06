import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../chat/bubble_message.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, AsyncSnapshot futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('sent at:', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDoc = snapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: chatDoc.length,
                itemBuilder: (context, index) => BubbleMessage(
                  theMessage: chatDoc[index]['text'],
                  isMe: chatDoc[index]['userId'] == futureSnapshot.data!.uid,
                  userName: chatDoc[index]['userName'],
                  imageUrl: chatDoc[index]['imageUrl'],
                  key: ValueKey(
                    chatDoc[index].documentID,
                  ),
                ),
              );
            },
          );
        });
  }
}
