import 'package:peneiras/models/requests/peneira_enroll_requests.dart';
import 'package:peneiras/services/api_service.dart';

class PeneiraEnrollService {
  final ApiService _apiService = ApiService();

  Future<void> enrollPeneira(String peneiraId) async {
    return await _apiService.request(
        path: "/peneiras/$peneiraId/enroll",
        method: "POST",
        fromJson: (json) {});
  }

  Future<List<PeneiraEnrollResponse>> getAllEnrollments() async {
    return await _apiService.request<List<PeneiraEnrollResponse>>(
      path: "/peneiras/enrollments",
      method: "GET",
      fromJson: (json) {
        final list = (json is List ? json : (json['data'] as List? ?? []));

        return list
            .map((item) => PeneiraEnrollResponse.fromJson(item))
            .toList();
      },
    );
  }
}
