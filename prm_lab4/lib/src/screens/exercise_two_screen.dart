import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/page_title.dart';
import '../../widgets/section_card.dart';
import '../../widgets/spacing.dart';
import '../state/app_state.dart';

class ExerciseTwoScreen extends StatelessWidget {
  const ExerciseTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 - Input Widgets')),
      body: Consumer<InputDemoState>(
        builder: (context, state, _) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.p16),
            children: [
              const PageTitle(
                title: 'Interactive controls',
                subtitle: 'Built without a custom StatefulWidget',
              ),
              AppSpacing.s16,
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Slider value: ${state.sliderValue.toStringAsFixed(0)}'),
                    Slider(
                      value: state.sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      label: state.sliderValue.toStringAsFixed(0),
                      onChanged: state.setSliderValue,
                    ),
                  ],
                ),
              ),
              AppSpacing.s12,
              Card(
                child: SwitchListTile(
                  title: const Text('Enable notifications'),
                  subtitle: Text(state.notificationsEnabled ? 'On' : 'Off'),
                  value: state.notificationsEnabled,
                  onChanged: state.setNotificationsEnabled,
                ),
              ),
              AppSpacing.s12,
              SectionCard(
                child: Column(
                  children: [
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Beginner'),
                      value: 'Beginner',
                      groupValue: state.selectedLevel,
                      onChanged: (value) => state.setSelectedLevel(value!),
                    ),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Intermediate'),
                      value: 'Intermediate',
                      groupValue: state.selectedLevel,
                      onChanged: (value) => state.setSelectedLevel(value!),
                    ),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Advanced'),
                      value: 'Advanced',
                      groupValue: state.selectedLevel,
                      onChanged: (value) => state.setSelectedLevel(value!),
                    ),
                  ],
                ),
              ),
              AppSpacing.s12,
              FilledButton.icon(
                onPressed: () => state.pickDate(context),
                icon: const Icon(Icons.date_range),
                label: const Text('Open DatePicker'),
              ),
              AppSpacing.s16,
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selected level: ${state.selectedLevel}'),
                    AppSpacing.s8,
                    Text('Notifications: ${state.notificationsEnabled ? 'Enabled' : 'Disabled'}'),
                    AppSpacing.s8,
                    Text(
                      'Selected date: ${state.selectedDate == null ? 'Not selected' : '${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}'}',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}