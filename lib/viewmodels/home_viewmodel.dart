import '../models/user.dart';
import '../services/api_service.dart';
import 'base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();
  User? _user;

  User? get user => _user;

  Future<void> loadUser(String id) async {
    setLoading(true);
    clearError();
    
    try {
      _user = await _apiService.getUser(id);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}