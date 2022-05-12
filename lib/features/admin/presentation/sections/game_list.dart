import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/features/admin/presentation/widgets/dialog_box.dart';
import 'package:esport_flame/features/admin/presentation/widgets/game_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameList extends ConsumerStatefulWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameListState ();
}

class _GameListState extends ConsumerState<GameList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Game List',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('popular_games').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          final gameData = snapshots.data?.docs;
          if (snapshots.data == null) {
            return const Center(
              child: Text('Loading...'),
            );
          } else if (gameData!.isEmpty) {
            return const Center(
              child: Text('No games are registered yet...!'),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: gameData.length,
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
                                    tilte: 'Game Name: ',
                                    detail: '${gameData[index]['popularGamesTitle']}',
                                  ),
                                 
                                ],
                              ),
                              const Spacer(),
                               IconButton(
                                      onPressed: () {
                                        GameDialogBox.showAlert(context,
                                            '${gameData[index]['popularGamesTitle']}',gameData[index].id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
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
