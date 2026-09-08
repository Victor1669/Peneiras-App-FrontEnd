import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/models/requests/peneira_requests.dart';
import 'package:peneiras/services/api_service.dart';

class PeneiraService {
  final ApiService _apiService = ApiService();

  Future<void> create(CreatePeneiraRequest body) async {
    return _apiService.request(
      path: "/peneiras",
      data: body,
      method: "POST",
      fromJson: (json) {},
    );
  }

  Future<List<PeneiraModel>> getAll() async {
    return _apiService.request<List<PeneiraModel>>(
      path: "/peneiras",
      method: "GET",
      fromJson: (json) {
        final list = (json is List ? json : (json['data'] as List? ?? []));
        return list.map((item) => PeneiraModel.fromJson(item)).toList();
      },
    );
  }
}
