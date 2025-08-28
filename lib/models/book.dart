class Book {
  final String id;
  final String pages;
  final String title;
  final String author;
  final String cover;
  final String language;
  final String description;
  final String publication;



  Book({
    required this.id,
    required this.pages,
    required this.title,
    required this.author,
    required this.cover,
    required this.description,
    required this.language,
    required this.publication,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      pages: json['pages'],
      title: json['title'],
      author: json['author'],
      cover: _buildCoverUrl(json['id'], json['cover']),
      description: json['description'],
      language: json['language'],
      publication: json['publication'],
    );
  }

  static String _buildCoverUrl(String recordId, String filename) {
    if (filename.isEmpty) return '';
    const baseUrl = 'http://127.0.0.1:8090/api';
    return '$baseUrl/files/books/$recordId/$filename';
  }
}