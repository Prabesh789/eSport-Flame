import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:esport_flame/app/entitiles/failure.dart';
import 'package:esport_flame/core/base_response/base_response.dart';
import 'package:esport_flame/features/admin/infrastructure/entities/add_ads_request.dart';
import 'package:esport_flame/features/admin/infrastructure/entities/add_tournament_request.dart';
import 'package:esport_flame/features/admin/infrastructure/entities/add_videos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as path;

final adminRepository =
    Provider<IAdminRepository>((ref) => AdminRepository(ref.read));

abstract class IAdminRepository {
  Future<Either<BaseResponse, Failure>> addAds({
    required AddAdsRequest addAdsRequest,
  });

  Future<Either<BaseResponse, Failure>> addTournaments({
    required AddTournament addTournament,
  });

  Future<Either<BaseResponse, Failure>> addPopularGames({
    required AddAdsRequest addAdsRequest,
  });

  Future<Either<BaseResponse, Failure>> addVideos({
    required AddVideoRequest addVideoRequest,
  });

//------------ UPDATE -------//
  Future<Either<void, Failure>> updateTournament({
    required AddTournament addTournament,
    required String docId,
  });
}

class AdminRepository implements IAdminRepository {
  AdminRepository(Reader read) : _read = read;

  // ignore: unused_field
  final Reader _read;
  @override
  Future<Either<BaseResponse, Failure>> addAds({
    required AddAdsRequest addAdsRequest,
  }) async {
    try {
      final fileName = path.basename(addAdsRequest.adsImage.path);
      final reference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('ads_images')
          .child(fileName);
      final uploadImage = reference.putFile(addAdsRequest.adsImage);
      firebase_storage.TaskSnapshot storageTaskSnapshot;
      await uploadImage.then(
        (value) {
          storageTaskSnapshot = value;
          storageTaskSnapshot.ref.getDownloadURL().then(
            (downloadUrl) async {
              await FirebaseFirestore.instance.collection('ads').doc().set(
                <String, dynamic>{
                  'adsTitle': addAdsRequest.adsTitle,
                  'aboutInfo': addAdsRequest.adsDescpription,
                  'image': downloadUrl,
                },
              );
            },
          );
        },
      );
      return const Left(
        BaseResponse(code: 200, data: null, message: 'Success'),
      );
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
  Future<Either<BaseResponse, Failure>> addTournaments({
    required AddTournament addTournament,
  }) async {
    try {
      final fileName = path.basename(addTournament.gamePosterImage.path);
      final reference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('tournaments_poster')
          .child(fileName);
      final uploadImage = reference.putFile(addTournament.gamePosterImage);
      firebase_storage.TaskSnapshot storageTaskSnapshot;
      await uploadImage.then(
        (value) {
          storageTaskSnapshot = value;
          storageTaskSnapshot.ref.getDownloadURL().then(
            (downloadUrl) async {
              await FirebaseFirestore.instance
                  .collection('tournaments')
                  .doc('gameTournaments')
                  .set(
                <String, dynamic>{
                  'gameTitle': addTournament.gameTitle,
                  'gameInfo': addTournament.gameDescpription,
                  'posterImage': downloadUrl,
                  'matchDate': addTournament.matchDate,
                  'winnerPrize': addTournament.winnerPrize,
                  'deadLineDate': addTournament.deadLineDate,
                  'bookingOpenDate': addTournament.bookingOpenDate,
                  'participants': FieldValue.arrayUnion(<String>[]),
                },
              );
            },
          );
        },
      );
      return const Left(
        BaseResponse(code: 200, data: null, message: 'Success'),
      );
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
  Future<Either<BaseResponse, Failure>> addPopularGames({
    required AddAdsRequest addAdsRequest,
  }) async {
    try {
      final fileName = path.basename(addAdsRequest.adsImage.path);
      final reference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('popular_game_images')
          .child(fileName);
      final uploadImage = reference.putFile(addAdsRequest.adsImage);
      firebase_storage.TaskSnapshot storageTaskSnapshot;
      await uploadImage.then(
        (value) {
          storageTaskSnapshot = value;
          storageTaskSnapshot.ref.getDownloadURL().then(
            (downloadUrl) async {
              await FirebaseFirestore.instance
                  .collection('popular_games')
                  .doc()
                  .set(
                <String, dynamic>{
                  'popularGamesTitle': addAdsRequest.adsTitle,
                  'popularGamesInfo': addAdsRequest.adsDescpription,
                  'image': downloadUrl,
                },
              );
            },
          );
        },
      );
      return const Left(
        BaseResponse(code: 200, data: null, message: 'Success'),
      );
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
  Future<Either<BaseResponse, Failure>> addVideos({
    required AddVideoRequest addVideoRequest,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('videos').doc().set(
        <String, dynamic>{
          'videotitle': addVideoRequest.videotitle,
          'videoUrl': addVideoRequest.videoDescpription,
        },
      );
      return const Left(
        BaseResponse(code: 200, data: null, message: 'Success'),
      );
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

  //---------------------------- UPDATE --------------------------------//

  @override
  Future<Either<void, Failure>> updateTournament({
    required AddTournament addTournament,
    required String docId,
  }) async {
    try {
      final CollectionReference tournaments =
          FirebaseFirestore.instance.collection('tournaments');
      final updatedData = tournaments
          .doc(docId)
          .update({
            'gameTitle': addTournament.gameTitle,
            'gameInfo': addTournament.gameDescpription,
            'matchDate': addTournament.matchDate,
            'bookingOpenDate': addTournament.bookingOpenDate,
            'deadLineDate': addTournament.deadLineDate,
            'winnerPrize': addTournament.winnerPrize,
            // 'posterImage':
            //     Image.memory(await addTournament.gamePosterImage.readAsBytes()),
          })
          .then((value) => log('Status Updated'))
          .catchError(
            (dynamic error) => log('Failed to update Status: $error'),
          );
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
