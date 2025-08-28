import '../services/http_service.dart';
import 'base_viewmodel.dart';

class AuthViewModel extends BaseViewModel {
  final HttpService _httpService = HttpService();
  String? _authToken;
  Map<String, dynamic>? _currentUser;

  String? get authToken => _authToken;
  Map<String, dynamic>? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    // Validation rules
    if (email.isEmpty) {
      setError('Email is required');
      return false;
    }
    if (!_isValidEmail(email)) {
      setError('Please enter a valid email');
      return false;
    }
    if (password.isEmpty) {
      setError('Password is required');
      return false;
    }
    if (password.length < 8) {
      setError('Password must be at least 8 characters');
      return false;
    }

    setLoading(true);
    clearError();
    
    try {
      final response = await _httpService.loginUser(email, password);
      _authToken = response['token'];
      _currentUser = response['record'];
      print('Login successful: ${response['record']['email']}');
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      setLoading(false);
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<bool> signup(String email, String password, String name) async {
    // Validation rules
    if (name.isEmpty) {
      setError('Name is required');
      return false;
    }
    if (email.isEmpty) {
      setError('Email is required');
      return false;
    }
    if (!_isValidEmail(email)) {
      setError('Please enter a valid email');
      return false;
    }
    if (password.isEmpty) {
      setError('Password is required');
      return false;
    }
    if (password.length < 8) {
      setError('Password must be at least 8 characters');
      return false;
    }

    setLoading(true);
    clearError();
    
    try {
      final response = await _httpService.registerUser(email, password, name);
      print('Signup successful: ${response['email']}');
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    _authToken = null;
    _currentUser = null;
    print('User logged out');
    notifyListeners();
  }

  bool get isAuthenticated => _authToken != null && _currentUser != null;
}