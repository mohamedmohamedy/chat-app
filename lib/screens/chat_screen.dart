import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   final fbm = FirebaseMessaging();
  //   fbm.requestNotificationPermissions();
  //   fbm.configure(
  //     onMessage: (message) {
  //       print(message);
  //       return;
  //     },
  //     onLaunch: (message) {
  //       print(message);
  //       return;
  //     },
  //     onResume: (message) {
  //       print(message);
  //       return;
  //     },
  //     // onBackgroundMessage: (message) {
  //     //   print(message);
  //     //   return;
  //     // },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat app'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      const Text('Logout'),
                    ],
                  ),
                ),
                value: 'Logout',
              ),
            ],
            onChanged: (value) {
              if (value == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
