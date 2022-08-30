import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ong_nft/test/album.dart';
import 'package:rxdart/rxdart.dart';

class AlbumStreamController {
  List<Album> _albums = [];
  bool _isLoading = true;

  final StreamController<List<Album>> _albumController =
      StreamController.broadcast();
  final StreamController<bool> _loadingController =
      StreamController.broadcast();
  final StreamController<Pair<List<Album>, bool>> _combineController = StreamController.broadcast();

  AlbumStreamController(){
    debugPrint("AlbumStreamController");
    final stream = Rx.combineLatest(
      [_albumController.stream, _loadingController.stream],
          (values) => Pair(
        first: values[0] as List<Album>,
        second: values[1] as bool,
      ),
    ).asBroadcastStream();
    _combineController.addStream(stream);
    _albumController.sink.add(_albums);
    _loadingController.sink.add(_isLoading);
  }

  Stream<Pair<List<Album>, bool>> get combineStream => _combineController.stream;

  void toggle() {
    _isLoading = !_isLoading;
    _loadingController.sink.add(_isLoading);
  }

  void dispose() {
    _combineController.close();
    _albumController.close();
    _loadingController.close();
  }
}
