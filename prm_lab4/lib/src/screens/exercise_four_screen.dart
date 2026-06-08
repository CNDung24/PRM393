import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/page_title.dart';
import '../../widgets/section_card.dart';
import '../../widgets/spacing.dart';
import '../state/app_state.dart';

class ExerciseFourScreen extends StatelessWidget {
  const ExerciseFourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Exercise 4 - Scaffold & Theme'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('FloatingActionButton pressed')),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.p16),
            children: [
              Card(
                child: SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Toggle app theme using ThemeMode'),
                  value: appState.isDarkMode,
                  onChanged: appState.setDarkMode,
                ),
              ),
              AppSpacing.s16,
              const SectionCard(
                child: PageTitle(
                  title: 'Scaffold structure demo',
                  subtitle: 'This screen includes AppBar, Body, FloatingActionButton, and ThemeData customization.',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}