import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/service/database_repo.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/service/storage_repo.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class AdsController {
  FirestoreDatabase _databaseRepo = locator.get<FirestoreDatabase>();

  StorageRepo _storageRepo = locator.get<StorageRepo>();

  Future<void> createAds(Ads data) async {
    try {
      var uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});
      if (data.listImage.length > 0) {
        for (int i = 0; i < data.listImage.length; i++) {
          String path = "ads/${uuid.v1()}";
          data.listImage[i] =
              await _storageRepo.uploadFile(File(data.listImage[i]), path);
        }
        data.urlThumb = data.listImage[0];
      }
      _databaseRepo.createAds(data.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateAds(Ads data) async {
    try {
      var uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});
      if (data.listImage.length > 0) {
        for (int i = 0; i < data.listImage.length; i++) {
          var urlPattern =
              r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
          var match = new RegExp(urlPattern, caseSensitive: false);
          if (match.hasMatch(data.listImage[i]) == false) {
            String path = "ads/${uuid.v1()}";
            data.listImage[i] =
                await _storageRepo.uploadFile(File(data.listImage[i]), path);
          }
        }
        data.urlThumb = data.listImage[0];
      }
      _databaseRepo.createAds(data.toJson(), id: data.id);
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readAds() =>
      _databaseRepo.readAds();

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserAds(String id) =>
      _databaseRepo.getUserAds(id);

  Future<void> soldAds(String id) async {
    await _databaseRepo.solidAds(id);
  }
}
