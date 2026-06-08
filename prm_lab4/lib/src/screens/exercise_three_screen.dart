import 'package:flutter/material.dart';

import '../../widgets/page_title.dart';
import '../../widgets/spacing.dart';

class ExerciseThreeScreen extends StatelessWidget {
  const ExerciseThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const movies = [
      'Inception',
      'Interstellar',
      'The Dark Knight',
      'Avengers: Endgame',
      'Spider-Man: No Way Home',
      'Dune',
      'The Matrix',
      'Top Gun: Maverick',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 - Layout Basics')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(
              title: 'Home Screen Layout',
              subtitle: 'Column, Row, Padding, SizedBox, and ListView.builder',
            ),
            AppSpacing.s12,
            const Text('Featured categories'),
            AppSpacing.s12,
            Row(
              children: const [
                Expanded(child: _CategoryCard(title: 'Movies', icon: Icons.movie)),
                SizedBox(width: 12),
                Expanded(child: _CategoryCard(title: 'Music', icon: Icons.music_note)),
                SizedBox(width: 12),
                Expanded(child: _CategoryCard(title: 'Books', icon: Icons.book)),
              ],
            ),
            AppSpacing.s16,
            const Text(
              'Recommended titles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            AppSpacing.s12,
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.p12),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text(movies[index]),
                        subtitle: const Text('Sample item from ListView.builder'),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.p16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon),
          AppSpacing.s8,
          Text(title),
        ],
      ),
    );
  }
}