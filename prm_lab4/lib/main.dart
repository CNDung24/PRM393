import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/screens/exercise_five_screen.dart';
import 'src/screens/exercise_four_screen.dart';
import 'src/screens/exercise_one_screen.dart';
import 'src/screens/exercise_three_screen.dart';
import 'src/screens/exercise_two_screen.dart';
import 'src/state/app_state.dart';
import 'widgets/spacing.dart';

void main() {
  runApp(const LabFourApp());
}

class LabFourApp extends StatelessWidget {
  const LabFourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => InputDemoState()),
      ],
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lab 4 - Flutter UI Fundamentals',
            themeMode: appState.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
              useMaterial3: true,
              scaffoldBackgroundColor: const Color(0xFFF7F8FC),
              appBarTheme: const AppBarTheme(centerTitle: true),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = <_ExerciseItem>[
      _ExerciseItem(
        title: 'Exercise 1 - Core Widgets',
        subtitle: 'Text, Icon, Image, Card, ListTile',
        screen: const ExerciseOneScreen(),
      ),
      _ExerciseItem(
        title: 'Exercise 2 - Input Widgets',
        subtitle: 'Slider, Switch, RadioListTile, DatePicker',
        screen: const ExerciseTwoScreen(),
      ),
      _ExerciseItem(
        title: 'Exercise 3 - Layout Basics',
        subtitle: 'Column, Row, Padding, ListView',
        screen: const ExerciseThreeScreen(),
      ),
      _ExerciseItem(
        title: 'Exercise 4 - Scaffold & Theme',
        subtitle: 'AppBar, FAB, Dark Mode, ThemeData',
        screen: const ExerciseFourScreen(),
      ),
      _ExerciseItem(
        title: 'Exercise 5 - Debug & Fix UI Errors',
        subtitle: 'Expanded, ScrollView, notifyListeners, context',
        screen: const ExerciseFiveScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 - Flutter UI Fundamentals'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.p16),
        itemCount: exercises.length,
        separatorBuilder: (_, _) => AppSpacing.s12,
        itemBuilder: (context, index) {
          final item = exercises[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(AppSpacing.p16),
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => item.screen),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ExerciseItem {
  const _ExerciseItem({
    required this.title,
    required this.subtitle,
    required this.screen,
  });

  final String title;
  final String subtitle;
  final Widget screen;
}