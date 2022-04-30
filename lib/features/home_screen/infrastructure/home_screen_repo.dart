import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:esport_flame/app/entitiles/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeScreenRepository =
    Provider<IHomeRepository>((ref) => HomeScreenRepository(ref.read));

abstract class IHomeRepository {
  Future<Either<void, Failure>> updateTournamantsStatus(
      String docID, int status);
}

class HomeScreenRepository implements IHomeRepository {
  HomeScreenRepository(Reader read) : _read = read;
  // ignore: unused_field
  final Reader _read;

  @override
  Future<Either<void, Failure>> updateTournamantsStatus(
      String docId, int status) async {
    try {
      CollectionReference tournaments =
          FirebaseFirestore.instance.collection('tournaments');
      final updatedData = tournaments
          .doc(docId)
          .update({'tournamentStatus': status})
          .then((value) => log("Status Updated"))
          .catchError((error) => log("Failed to update Status: $error"));
      return Left(updatedData);
    } on FirebaseAuthException catch (e) {
      return Right(
        Failure(
          errorMessage:
              e.message ?? 'Something went wrong, try in few moments !',
        ),
      );
    } catch (e) {
      return Right(
        Failure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
