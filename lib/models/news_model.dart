class NewsModel {
  final String? title;
  final String? description;
  final String? author;
  final String? urlToImage;
  final String? publishedAt;
  final String? url;
  final NewsSource? source;
  final String? content;

  NewsModel({
    this.title,
    this.description,
    this.author,
    this.urlToImage,
    this.publishedAt,
    this.url,
    this.source,
    this.content,
  });

  // Create from JSON (News API response)
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      author: json['author'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      url: json['url'] as String?,
      content: json['content'] as String?,
      source: json['source'] != null
          ? NewsSource.fromJson(json['source'] as Map<String, dynamic>)
          : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'url': url,
      'content': content,
      'source': source?.toJson(),
    };
  }

  // Get formatted published date
  String getFormattedDate() {
    if (publishedAt == null) return '';
    try {
      final date = DateTime.parse(publishedAt!);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '';
    }
  }
}

class NewsSource {
  final String? id;
  final String? name;

  NewsSource({this.id, this.name});

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(id: json['id'] as String?, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
