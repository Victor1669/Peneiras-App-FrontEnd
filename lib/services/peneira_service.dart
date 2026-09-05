import 'package:peneiras/models/requests/peneira_requests.dart';
import 'package:peneiras/services/api_service.dart';

class PeneiraService {
  final ApiService _apiService = ApiService();

  Future<CreatePeneiraResponse> createPeneira(CreatePeneiraRequest body) async {
    return _apiService.request<CreatePeneiraResponse>(
      path: "/peneiras",
      data: body,
      method: "POST",
      fromJson: (json) => CreatePeneiraResponse.fromJson(json),
    );
  }
}
