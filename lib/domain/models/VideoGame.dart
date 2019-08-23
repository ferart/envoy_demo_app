class VideoGame {
  final String id;
  final String name;
  final String imageURL;

  const VideoGame(this.id, this.name, this.imageURL);

  String get tag => id; //replace for a real unique id

  String get formattedURL {
    if (imageURL != null && imageURL.isNotEmpty) {
      return imageURL
          .replaceAll('{width}', '200')
          .replaceAll('{height}', '250');
    }
    return '';
  }

  factory VideoGame.fromJson(Map<String, dynamic> json) {
    return VideoGame(
      json['id'],
      json['name'],
      json['box_art_url'],
    );
  }
}

const List<VideoGame> topGamesList = <VideoGame>[
  VideoGame('1', 'Metal Gear Solid 3', 'assets/metal_gear3.jpg'),
  VideoGame('2', 'Metal gear solid', 'assets/metal_gear3.jpg'),
  VideoGame('3', 'God of War 4', 'assets/god_of_war4.jpg'),
  VideoGame('4', 'Castlevania', 'assets/metal_gear3.jpg'),
  VideoGame('5', 'Shadow of the Colossus', 'assets/metal_gear3.jpg'),
  VideoGame('6', 'Call of Duty MW:2', 'assets/god_of_war4.jpg'),
  VideoGame('7', 'Street Fighter II', 'assets/metal_gear3.jpg'),
  VideoGame('8', 'Tetris', 'assets/metal_gear3.jpg'),
  VideoGame('9', 'Resident Evil 2', 'assets/god_of_war4.jpg'),
  VideoGame('10', 'Puyo puyo', 'assets/metal_gear3.jpg'),
  VideoGame('11', 'Fifa 1999', 'assets/metal_gear3.jpg'),
  VideoGame('12', 'Resident Evil 4', 'assets/god_of_war4.jpg'),
];
