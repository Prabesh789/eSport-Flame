import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:esport_flame/app/entitiles/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeScreenRepository =
    Provider<IHomeRepository>((ref) => HomeScreenRepository(ref.read));

abstract class IHomeRepository {
  Future<Either<void, Failure>> participantStatus(
    String docID,
    String userId,
  );

  Future<Either<void, Failure>> removeParticipant(String docId);
}

class HomeScreenRepository implements IHomeRepository {
  HomeScreenRepository(Reader read) : _read = read;
  // ignore: unused_field
  final Reader _read;

  @override
  Future<Either<void, Failure>> participantStatus(
      String docId, String userId) async {
    try {
      CollectionReference tournaments =
          FirebaseFirestore.instance.collection('tournaments');
      final updatedData = tournaments
          .doc(docId)
          .update({
            'participants': FieldValue.arrayUnion([userId])
          })
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

  @override
  Future<Either<void, Failure>> removeParticipant(String docId) async {
    try {
      CollectionReference tournaments =
          FirebaseFirestore.instance.collection('tournaments');
      final updatedData = tournaments
          .doc(docId)
          .update({'participants': ''})
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
