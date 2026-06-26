class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

const List<Movie> allMovies = [
  Movie(title: "Inception", year: 2010, genres: ["Action", "Sci-Fi", "Thriller"], posterUrl: "https://via.placeholder.com/150/0000FF/808080?text=Inception", rating: 8.8),
  Movie(title: "The Dark Knight", year: 2008, genres: ["Action", "Crime", "Drama"], posterUrl: "https://via.placeholder.com/150/FF0000/FFFFFF?text=The+Dark+Knight", rating: 9.0),
  Movie(title: "Interstellar", year: 2014, genres: ["Adventure", "Drama", "Sci-Fi"], posterUrl: "https://via.placeholder.com/150/FFFF00/000000?text=Interstellar", rating: 8.6),
  Movie(title: "The Matrix", year: 1999, genres: ["Action", "Sci-Fi"], posterUrl: "https://via.placeholder.com/150/008000/FFFFFF?text=The+Matrix", rating: 8.7),
  Movie(title: "Avengers: Endgame", year: 2019, genres: ["Action", "Adventure", "Sci-Fi"], posterUrl: "https://via.placeholder.com/150/800080/FFFFFF?text=Avengers", rating: 8.4),
  Movie(title: "Parasite", year: 2019, genres: ["Drama", "Thriller"], posterUrl: "https://via.placeholder.com/150/FFA500/000000?text=Parasite", rating: 8.6),
  Movie(title: "Spirited Away", year: 2001, genres: ["Animation", "Adventure", "Family"], posterUrl: "https://via.placeholder.com/150/00FFFF/000000?text=Spirited+Away", rating: 8.6),
  Movie(title: "Joker", year: 2019, genres: ["Crime", "Drama", "Thriller"], posterUrl: "https://via.placeholder.com/150/FFC0CB/000000?text=Joker", rating: 8.4),
];

final List<String> allGenres = [
  "Action", "Sci-Fi", "Drama", "Adventure", "Thriller", "Crime", "Animation", "Family"
];