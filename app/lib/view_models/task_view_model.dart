import 'package:app/models/task_model.dart';

class MovieViewModel {
  final Task task;

  MovieViewModel({required this.movie});

  String get title {
    return movie.title;
  }

  String get poster {
    return movie.posterUrl;
  }
}
