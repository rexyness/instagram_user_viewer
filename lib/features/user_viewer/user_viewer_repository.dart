// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_public_api/instagram_public_api.dart';
import 'package:instagram_user_viewer/core/dio_error_handling.dart';
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
    final List<String> userAgents = [
      'Mozilla/5.0 (Linux; Android 7.0; TECNO K7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Mobile Safari/537.36',
      'Mozilla/5.0 (Linux; Android 8.1.0; SM-T580) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
      'Mozilla/5.0 (Linux; Android 4.4; BQS-5005 Build/BQS) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/30.0.0.0 Mobile Safari/537.36',
      'Mozilla/5.0 (Linux; Android 6.0.1; Rombica_Cinema4K_v01 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/33.0.0.0 Safari/537.36',
      'Mozilla/5.0 (Linux; Android 7.0; ASUS_X008D) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.83 Mobile Safari/537.36',
      'Mozilla/5.0 (Linux; Android 5.0.2; P023 Build/LRX22G) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Safari/537.36',
      'Mozilla/5.0 (Linux; Android 8.1.0; ASUS_X00TDB) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Mobile Safari/537.36',
      'Mozilla/5.0 (Linux; Android 7.1.2; V-BOX Build/NHG47K; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/55.0.2883.91 Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.80 Safari/537.36,gzip(gfe)',
      'Mozilla/5.0 (BlackBerry; U; BlackBerry 9800; en-US) AppleWebKit/534.1+ (KHTML, like Gecko) Version/6.0.0.201 Mobile Safari/534.1+',
      'Mozilla/5.0 (Linux; Android 8.1.0; SAMSUNG SM-T585 Build/M1AJQ) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/7.4 Chrome/59.0.3071.125 Safari/537.36',
      'Mozilla/5.0 (Linux; Android 4.4.4; reeder_A8i_Quad Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/33.0.0.0 Safari/537.36',
      'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 OPR/57.0.3098.91 (Edition Campaign 34)',
      'AndroidDownloadManager/7.0 (Linux; U; Android 7.0; BQru-1081G Build/NRD90M)',
      'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 OPR/57.0.3098.91',
      'Mozilla/5.0 (Linux; Android 6.0; CAM-L21) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.83 Mobile Safari/537.36',
      'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3650.1 Iron Safari/537.36',
      'Mozilla/5.0 (Linux; Android 4.4.2; LG-D802) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.83 Mobile Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3634.2 Safari/537.36',
      'Mozilla/5.0 (Linux; Android 6.0.1; ASUS_Z00AD) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.83 Mobile Safari/537.36',
    ];
    final randomUserAgent = (userAgents..shuffle()).first;
    try {
      log('Repository invoked with Username $username');
      final result = await dio.request(
        'https://www.instagram.com/$username/?__a=1',
        options: Options(
          responseType: ResponseType.plain,
          method: 'GET',
          headers: {
            'User-Agent': randomUserAgent,
            // 'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
            // 'Accept-Encoding': 'gzip, deflate, br',
            'DNT': '1',
            'Alt-Used': 'www.instagram.com',
            'Connection': 'keep-alive',
            'Cookie':
                'ig_did=DAF58C76-26A7-4772-B404-B593E743A297; csrftoken=LzQQ4E8aQZO8eiRqJtEW186aLw8InmHs; mid=XokFygALAAHSGTPnDOXXtGa2P2Ru; ds_user_id=44840686583; sessionid=44840686583%3ATSVFLqUeD8LgMU%3A28; shbid="8772\05444840686583\0541667054936:01f7ecbfbb904278a879169863ff7fc26c6444f9dc7347f21ab7156e4f2eb4999d8c8950"; shbts="1635518936\05444840686583\0541667054936:01f7430448dcaacfe7c2db77c9ae050b0266c081d6ae103f396e49c8376e7a2c32a79683"; rur="FRC\05444840686583\0541667118604:01f7b5378837be9ba5f8918559c149cd0367c62d4eb7e0d980abeaaad6d033a90425ae8e"',
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
      log(dioError.response?.statusCode.toString() ?? '');
      final error = DioCustomException.fromDioError(dioError);

      throw Failure(message: error.message, code: dioError.response?.statusCode);
    } on NoSuchMethodError {
      throw Failure(message: 'Data returned was empty , perhaps a private account ?');
    } 
  }
}
