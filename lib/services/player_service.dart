import 'package:peneiras/models/requests/cadastro_requests.dart';
import 'package:peneiras/services/api_service.dart';

class PlayerService {
  final ApiService _apiService = ApiService();

  Future<CreateUsersResponse> create(CreatePlayerRequest body) {
    return _apiService.request<CreateUsersResponse>(
        path: "/auth/register",
        method: "POST",
        data: body,
        fromJson: CreateUsersResponse.fromJson,
        showErrorSnackBar: true);
  }
}
