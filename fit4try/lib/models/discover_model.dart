class DiscoverPost {
  final String imageUrl;
  final String username;
  final String userImage;
  final String description;
  final int views;
  final int likes;
  final int shares;
  final List<String> tags;
  final bool saved;
  final String id;
  final bool isFavorited;

  DiscoverPost({
    required this.imageUrl,
    required this.username,
    required this.userImage,
    required this.description,
    required this.views,
    required this.likes,
    required this.shares,
    required this.tags,
    required this.id,
    required this.saved,
    required this.isFavorited,
  });

  factory DiscoverPost.fromMap(Map<String, dynamic> map) {
    return DiscoverPost(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      username: map['username'] ?? '',
      userImage: map['userImage'] ?? '',
      description: map['description'] ?? '',
      views: map['views'] ?? 0,
      likes: map['likes'] ?? 0,
      shares: map['shares'] ?? 0,
      tags: List<String>.from(map['tags'] ?? []),
      saved: map['saved'] ?? false,
      isFavorited: map['isFavorited'] ?? false,
    );
  }
}
