import 'package:peneiras/models/requests/cadastro_requests.dart';
import 'package:peneiras/services/api_service.dart';

class ClubService {
  final ApiService _apiService = ApiService();

  Future<CreateUsersResponse> create(CreateClubRequest body) async {
    return _apiService.request<CreateUsersResponse>(
      path: "/api/auth/clube/register",
      data: body,
      method: "POST",
      fromJson: CreateUsersResponse.fromJson,
    );
  }
}
