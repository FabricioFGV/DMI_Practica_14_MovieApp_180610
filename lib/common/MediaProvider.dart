import 'dart:async';
import 'package:movieapp_180610/common/HttpHandler.dart';
import 'package:movieapp_180610/model/Cast.dart';
import 'package:movieapp_180610/model/Media.dart';

abstract class MediaProvider {
  Future<List<Media>> fetchMedia(String category);
  Future<List<Cast>> fetchCast(int mediaId);
}

class MediaPrvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  
  int? get mediaId => null;
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchMovies(category: category);
  }
  
  @override
  Future<List<Cast>> fetchCast(int mediaId) {
    // TODO: implement fetchCast
    return _client.fetchCreditMovies(mediaId);
  }
  
}

class ShowProvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  
  int? get mediaId => null;
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchShow(category: category);
  }
  
  @override
  Future<List<Cast>> fetchCast(int mediaId) {
    // TODO: implement fetchCast
    return _client.fetchCreditShows(mediaId);
  }
}

enum Mediatype {movie, show}