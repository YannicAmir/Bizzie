import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  final String title;
  final String publishedDate;
  final String site;
  final String url;
  final String? image;
  final String? text;

  const NewsArticle({
    required this.title,
    required this.publishedDate,
    required this.site,
    required this.url,
    this.image,
    this.text,
  });

  @override
  List<Object?> get props => [title, publishedDate, site, url, image, text];
}
