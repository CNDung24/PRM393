import 'package:flutter/material.dart';

import '../../widgets/page_title.dart';
import '../../widgets/section_card.dart';
import '../../widgets/spacing.dart';

class ExerciseOneScreen extends StatelessWidget {
  const ExerciseOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 - Core Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.p16),
        children: const [
          PageTitle(
            title: 'Flutter UI Fundamentals',
            subtitle: 'Core widgets: Text, Image, Icon, Card, ListTile',
          ),
          AppSpacing.s16,
          Icon(
            Icons.phone_android,
            size: 72,
            color: Colors.indigo,
          ),
          AppSpacing.s16,
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Image(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?auto=format&fit=crop&w=1200&q=80',
              ),
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
          AppSpacing.s16,
          SectionCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Icon(Icons.school, color: Colors.white),
              ),
              title: Text('PRM393 - Lab 4'),
              subtitle: Text('Core widgets: Text, Image, Icon, Card, ListTile'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}