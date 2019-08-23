import 'package:envoy_demo_app/data/TwitchService.dart';
import 'package:envoy_demo_app/domain/models/VideoGame.dart';
import 'package:flutter/material.dart';

class TopGamesWidget extends StatefulWidget {
  const TopGamesWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TopGamesState();
  }
}

class TopGamesState extends State<TopGamesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Games'),
      ),
      body: _buildGamesList(),
    );
  }

  Widget _buildGamesList() {
    return Column(
      children: <Widget>[
        Expanded(
          child: SafeArea(
            top: false,
            bottom: false,
            child: FutureTopGamesWidget()
          ),
        ),
      ],
    );
  }
}

class FutureTopGamesWidget extends StatefulWidget {
  final Future<List<VideoGame>> videoGamesFuture;

  FutureTopGamesWidget({Key key, this.videoGamesFuture}) : super(key: key);

  @override
  _FutureTopGamesState createState() => _FutureTopGamesState();
}

class _FutureTopGamesState extends State<FutureTopGamesWidget> {
  Future<List<VideoGame>> videoGamesFuture;

  @override
  void initState() {
    super.initState();
    videoGamesFuture = TwitchService.fetchTopGames();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoGame>>(
      future: videoGamesFuture,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final topGames = snapshot.data;
          return GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 10.0,
            padding: const EdgeInsets.all(4.0),
            childAspectRatio: 0.7,
            children: topGames.map<Widget>((VideoGame item) {
              return VideoGameItemWidget(videoGame: item,);
            }).toList(),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class VideoGameItemWidget extends StatelessWidget {
  final VideoGame videoGame;

  VideoGameItemWidget({Key key, @required this.videoGame});

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
      onTap: () {}, // do something on video game selected
      child: Hero(
        key: Key(videoGame.name),
        tag: videoGame.tag,
        child: Image.network(
          videoGame.formattedURL,
          fit: BoxFit.cover,
        ),
      ),
    );

    return GridTile(
      footer: GestureDetector(
        onTap: () {},
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: _GridDescription(videoGame.name),
        ),
      ),
      child: image,
    );
  }
}

class _GridDescription extends StatelessWidget {
  const _GridDescription(this.description);

  final String description;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(description),
    );
  }
}
