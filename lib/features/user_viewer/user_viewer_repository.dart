// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_public_api/instagram_public_api.dart';
import 'package:instagram_user_viewer/core/failure.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final flutterInstaProvider = Provider<FlutterInsta>((ref) {
  return FlutterInsta();
});

final userViewerRepositoryProvider = Provider<UserViewerRepository>((ref) {
  return UserViewerRepository(flutterInsta: ref.watch(flutterInstaProvider), dio: ref.watch(dioProvider));
});

class UserViewerRepository {
  final FlutterInsta flutterInsta;
  final Dio dio;
  UserViewerRepository({
    required this.flutterInsta,
    required this.dio,
  });

  Future<InstaProfileData> getProfileByUsername(String username) async {
    try {
      log('Repository invoked with Username $username');
      final result = await dio.request(
        'https://www.instagram.com/$username/?__a=1',
        options: Options(
          responseType: ResponseType.plain,
          method: 'GET',
          headers: {
            'User-Agent':
                'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_1 like Mac OS X; sl-SI) AppleWebKit/532.50.5 (KHTML, like Gecko) Version/4.0.5 Mobile/8B114 Safari/6532.50.5',
            // 'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
            // 'Accept-Encoding': 'gzip, deflate, br',
            'DNT': '1',
            'Alt-Used': 'www.instagram.com',
            'Connection': 'keep-alive',
            'Cookie':
                'ig_did=DAF58C76-26A7-4772-B404-B593E743A297; csrftoken=LzQQ4E8aQZO8eiRqJtEW186aLw8InmHs; mid=XokFygALAAHSGTPnDOXXtGa2P2Ru; ds_user_id=44840686583; sessionid=44840686583%3ATSVFLqUeD8LgMU%3A28; shbid="8772\05444840686583\0541667054936:01f7ecbfbb904278a879169863ff7fc26c6444f9dc7347f21ab7156e4f2eb4999d8c8950"; shbts="1635518936\05444840686583\0541667054936:01f7430448dcaacfe7c2db77c9ae050b0266c081d6ae103f396e49c8376e7a2c32a79683"; rur="NAO\05444840686583\0541667075522:01f71871433658f22be23caa1aa74bf1ac6d59b3853eb02d1cbc552b2b50a4c47fb84da8"',
            'Upgrade-Insecure-Requests': '1',
            'Sec-Fetch-Dest': 'document',
            'Sec-Fetch-Mode': 'navigate',
            'Sec-Fetch-Site': 'none',
            'Sec-Fetch-User': '?1',
            'Cache-Control': 'max-age=0',
          },
        ),
      );
      log(result.data.toString());

      final profile = jsonDecode(result.data.toString())["graphql"]["user"];

      InstaProfileData userProfile = InstaProfileData(
        bio: profile["biography"],
        following: profile["edge_follow"]["count"].toString(),
        followers: profile["edge_followed_by"]["count"].toString(),
        externalURL: profile["external_url"],
        isPrivate: profile["is_private"],
        isVerified: profile["is_verified"],
        profilePicURL: profile["profile_pic_url_hd"],
        username: username,
      );
      return userProfile;
    } on DioError catch (dioError) {
      throw Failure(
          message: dioError.response?.statusMessage ?? 'Something went wrong', code: dioError.response?.statusCode);
    } on NoSuchMethodError {
      throw Failure(message: 'Data returned was empty , perhaps a private account ?');
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
