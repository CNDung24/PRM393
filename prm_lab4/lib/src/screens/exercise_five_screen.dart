import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/section_card.dart';
import '../../widgets/spacing.dart';
import '../state/app_state.dart';

class ExerciseFiveScreen extends StatelessWidget {
  const ExerciseFiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 - Debug & Fix UI Errors')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _FixCard(
              title: '1. Fix ListView inside Column',
              explanation: 'Use Expanded so ListView receives bounded height inside a Column.',
              example: 'Column(children: [header, Expanded(child: ListView(...))])',
            ),
            AppSpacing.s12,
            _FixCard(
              title: '2. Fix overflow on small screens',
              explanation: 'Wrap long content with SingleChildScrollView to avoid bottom overflow.',
              example: 'SingleChildScrollView(child: Column(...))',
            ),
            AppSpacing.s12,
            _NotifyListenersDemo(),
            AppSpacing.s12,
            _DatePickerContextDemo(),
          ],
        ),
      ),
    );
  }
}

class _FixCard extends StatelessWidget {
  const _FixCard({
    required this.title,
    required this.explanation,
    required this.example,
  });

  final String title;
  final String explanation;
  final String example;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          AppSpacing.s8,
          Text(explanation),
          AppSpacing.s8,
          Text(example, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}

class _NotifyListenersDemo extends StatelessWidget {
  const _NotifyListenersDemo();

  @override
  Widget build(BuildContext context) {
    return Consumer<InputDemoState>(
      builder: (context, state, _) {
        return SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '3. Fix state update issue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              AppSpacing.s8,
              const Text('In StatefulWidget, this is usually fixed with setState(). Here we use notifyListeners() in ChangeNotifier.'),
              AppSpacing.s12,
              Text('Current slider value: ${state.sliderValue.toStringAsFixed(0)}'),
              Slider(
                value: state.sliderValue,
                min: 0,
                max: 100,
                onChanged: state.setSliderValue,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DatePickerContextDemo extends StatelessWidget {
  const _DatePickerContextDemo();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<InputDemoState>();

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '4. Fix DatePicker context error',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          AppSpacing.s8,
          const Text('Call showDatePicker from a valid widget tree context, such as inside a button onPressed callback.'),
          AppSpacing.s12,
          OutlinedButton.icon(
            onPressed: () => state.pickDate(context),
            icon: const Icon(Icons.calendar_month),
            label: const Text('Pick date safely'),
          ),
          AppSpacing.s8,
          Text(
            state.selectedDate == null
                ? 'No date selected yet.'
                : 'Selected date: ${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}',
          ),
        ],
      ),
    );
  }
}