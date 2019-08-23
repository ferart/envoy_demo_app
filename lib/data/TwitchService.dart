import 'package:envoy_demo_app/domain/models/VideoGame.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TwitchService {
  static const String clientId = 'furuqz8348r5cfbg6dxufi8d328x6n';

  static Future<List<VideoGame>> fetchTopGames() async {
    Map<String, String> requestHeaders = {
      'Accept': 'application/vnd.twitchtv.v5+json',
      'Client-ID': clientId,
    };

    final request = http.get('https://api.twitch.tv/helix/games/top',
        headers: requestHeaders);

    final response = await request;
    if(response.statusCode == 200){
      final Map<String, dynamic> parsed = json.decode(response.body);
      final List<dynamic> data = parsed["data"];
      final List<VideoGame> topGames = new List();

      data.forEach((gameEntry){
        topGames.add(VideoGame.fromJson(gameEntry));
      });
      return topGames;
    }else {
      throw Exception('Failed to load top games');
    }
  }
}
