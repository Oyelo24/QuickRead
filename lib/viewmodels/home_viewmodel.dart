import '../models/book.dart';
import '../services/http_service.dart';
import 'base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final HttpService _httpService = HttpService();
  List<Book> _books = [];

  List<Book> get books => _books;

  Future<void> loadBooks() async {
    setLoading(true);
    clearError();
    
    try {
      final booksData = await _httpService.fetchBooks();
      _books = booksData.map((json) => Book.fromJson(json)).toList();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}