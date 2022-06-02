import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/features/menu_nav_bar/Model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import 'message_widget.dart';

class ChatScreen extends StatefulWidget {
  final String userid;
  final String username;

  const ChatScreen({Key? key, required this.userid, required this.username})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  String message = '';

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore messageRef = FirebaseFirestore.instance;
  MessageModel messagemodel = MessageModel();
  late String senderUid = auth.currentUser!.uid;

  //get uid
  @override
  void initState() {
    auth.authStateChanges().listen(
      (User? user) async {
        if (user != null) {
          if (mounted) {
            setState(() {
              senderUid = user.uid;
            });
          }
        }
      },
    );
    getUserDetail();
    super.initState();
  }

  Future getUserDetail() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(senderUid)
        .get()
        .then((value) {
      messagemodel = MessageModel.fromMap(value.data()!);
    });
  }

//sending message
  Future sendMessage() async {
    FocusScope.of(context).unfocus();

    messagemodel.uid = senderUid;
    messagemodel.message = message.trim();
    messagemodel.nickName = messagemodel.nickName;

    await messageRef
        .collection('Chats')
        .doc(widget.userid)
        .collection('messages')
        .doc()
        .set(messagemodel.toMap());
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final inputMessageFeild = CustomTextField(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      labelText: 'Write Message',
      context: context,
      controller: _textController,
      prefixIcon: const Icon(
        Icons.near_me,
        size: 18,
      ),
      onChanged: (value) {
        setState(() {
          message = value!;
        });
      },
    );

    //message send button
    final sendMessageButton = GestureDetector(
      onTap: message.trim().isEmpty ? null : sendMessage,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: const Icon(Icons.send, color: Colors.white),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.call,
            ),
            onPressed: () {
              context.showSnackBar(
                'Audio Call features comming soon!!',
                Icons.warning,
                AppColors.greencolor,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {
              context.showSnackBar(
                'Video Call features comming soon!!',
                Icons.warning,
                AppColors.greencolor,
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Chats')
                      .doc(widget.userid)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                    final messageData = snapshots.data?.docs;
                    switch (snapshots.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                        if (snapshots.hasError) {
                          return buildText('Something Went Wrong Try later');
                        } else {
                          return messageData!.isEmpty
                              ? buildText('Say Hi..')
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  reverse: true,
                                  itemCount: messageData.length,
                                  itemBuilder: (context, index) {
                                    final message = messageData[index];

                                    return MessageWidget(
                                      message: message,
                                      isMe: message['senderUid'] == senderUid,
                                    );
                                  },
                                );
                        }
                    }
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: inputMessageFeild),
                const SizedBox(width: 10),
                sendMessageButton
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
}
