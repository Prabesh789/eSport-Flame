import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/app_colors.dart';
import 'chat_screen.dart';

class ChatService extends ConsumerStatefulWidget {
  const ChatService({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListState();
}

class _UserListState extends ConsumerState<ChatService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message')),
      body: Container(
        color: const Color.fromARGB(255, 234, 252, 235),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: const Text(
                'Chats Heads',
                style: TextStyle(
                  color: Color.fromARGB(255, 19, 16, 16),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 60,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  final userData = snapshots.data?.docs;
                  if (snapshots.data == null) {
                    return const Center(
                      child: Text('Loading...'),
                    );
                  } else if (userData!.isEmpty) {
                    return const Center(
                      child: Text('No user are registered yet...!'),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        final userId = userData[index].id;
                        final username = userData[index]['nickName'] as String;
                        if (index == 0) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.search),
                            ),
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<ChatScreen>(
                                        builder: (context) => ChatScreen(
                                          userid: userId,
                                          username: username,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Text(
                                      '${userData[index]['nickName'][0]}'
                                          .toUpperCase(),
                                      style: GoogleFonts.playball(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.copyWith(
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -12,
                                  bottom: 0,
                                  child: (!(userData[index]['isAdmin'] as bool))
                                      ? IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute<ChatScreen>(
                                                builder: (context) =>
                                                    ChatScreen(
                                                  userid: userId,
                                                  username: username,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.offline_bolt,
                                            color: Colors.black,
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(10),
                                          child:
                                              Icon(Icons.admin_panel_settings),
                                        ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ) //container 2
          ],
        ),
      ),
    );
  }
}

class _UserDetail extends StatelessWidget {
  const _UserDetail({
    Key? key,
    required this.tilte,
    required this.detail,
  }) : super(key: key);

  final String tilte;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Text(
            tilte,
          ),
          Text(detail),
        ],
      ),
    );
  }
}
