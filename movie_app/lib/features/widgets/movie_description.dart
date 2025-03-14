import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class MovieDescription extends StatelessWidget {
  final String description;
  final String releaseDate;
  final String language;
  final String duration;

  const MovieDescription({
    Key? key,
    required this.description,
    required this.releaseDate,
    required this.language,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Film Hakkında',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                context,
                Icons.calendar_today,
                'Yayın Tarihi',
                releaseDate,
              ),
              _buildInfoItem(
                context,
                Icons.language,
                'Dil',
                language,
              ),
              _buildInfoItem(
                context,
                Icons.access_time,
                'Süre',
                duration,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppTheme.accentColor,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
