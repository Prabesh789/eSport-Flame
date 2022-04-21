import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/features/admin/presentation/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListState();
}

class _UserListState extends ConsumerState<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User List',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
              shrinkWrap: true,
              itemCount: userData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.cyan[50],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _UserDetail(
                                    tilte: 'Stage Name: ',
                                    detail: '${userData[index]['nickName']}',
                                  ),
                                  _UserDetail(
                                    tilte: 'Email: ',
                                    detail: '${userData[index]['email']}',
                                  ),
                                  _UserDetail(
                                    tilte: 'contact number: ',
                                    detail: '${userData[index]['contactNo']}',
                                  ),
                                ],
                              ),
                              const Spacer(),
                              (!userData[index]['isAdmin'])
                                  ? IconButton(
                                      onPressed: () {
                                        DialogBox.showAlert(context,
                                            '${userData[index]['nickName']}');
                                      },
                                      icon: const Icon(
                                        Icons.task,
                                        color: Colors.black,
                                      ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(Icons.admin_panel_settings),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
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
      padding: const EdgeInsets.all(4.0),
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
