import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  Set<String> selectedGenres = {};
  String selectedSort = 'A-Z';

  final List<String> sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  void _clearFilters() {
    setState(() {
      searchQuery = '';
      selectedGenres.clear();
      selectedSort = 'A-Z';
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Filter movies
    List<Movie> visibleMovies = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenre = selectedGenres.isEmpty || selectedGenres.any((g) => movie.genres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    // 2. Sort movies
    visibleMovies.sort((a, b) {
      if (selectedSort == 'A-Z') return a.title.compareTo(b.title);
      if (selectedSort == 'Z-A') return b.title.compareTo(a.title);
      if (selectedSort == 'Year') return b.year.compareTo(a.year); // Descending (newest first)
      if (selectedSort == 'Rating') return b.rating.compareTo(a.rating); // Descending (highest rating first)
      return 0;
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & Clear Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Find a Movie',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  if (selectedGenres.isNotEmpty || searchQuery.isNotEmpty || selectedSort != 'A-Z')
                    TextButton.icon(
                      onPressed: _clearFilters,
                      icon: const Icon(Icons.clear_all),
                      label: const Text('Clear'),
                    )
                ],
              ),
              const SizedBox(height: 16),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search by title...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Genres Title and Badge
              Row(
                children: [
                  const Text('Genres', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  if (selectedGenres.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${selectedGenres.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Genre Chips via Wrap
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: allGenres.map((genre) {
                  final isSelected = selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedGenres.add(genre);
                        } else {
                          selectedGenres.remove(genre);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Sort Bar
              Row(
                children: [
                  const Text('Sort By:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: selectedSort,
                    items: sortOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedSort = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Responsive Movie List Area
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (visibleMovies.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    }

                    if (constraints.maxWidth < 800) {
                      // Phone Mode: Single Column ListView
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return MovieCard(movie: visibleMovies[index]);
                        },
                      );
                    } else {
                      // Tablet/Web Mode: GridView
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return MovieCard(movie: visibleMovies[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}