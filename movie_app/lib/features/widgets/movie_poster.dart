import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MoviePoster extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const MoviePoster({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    this.isFavorite = false,
    required this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: Container(
              height: 400,
              width: double.infinity,
              color: Colors.grey[800],
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 400,
            width: double.infinity,
            color: Colors.grey[800],
            child: const Icon(Icons.error),
          ),
        ),
        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
