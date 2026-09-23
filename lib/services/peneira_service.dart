import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/models/requests/peneira_requests.dart';
import 'package:peneiras/services/api_service.dart';

class PeneiraService {
  final ApiService _apiService = ApiService();

  Future<void> create(PeneiraRequest body) async {
    return _apiService.request(
      path: "/peneiras",
      data: body,
      method: "POST",
      fromJson: (json) {},
    );
  }

  Future<void> update(PeneiraRequest body, String peneiraId) async {
    return _apiService.request(
      path: "/peneiras/$peneiraId",
      data: body,
      method: "PUT",
      fromJson: (json) => PeneiraRequest.fromJson(json),
    );
  }

  Future<List<PeneiraCardModel>> getAll() async {
    return _apiService.request<List<PeneiraCardModel>>(
      path: "/peneiras",
      method: "GET",
      fromJson: (json) {
        final list = (json is List ? json : (json['data'] as List? ?? []));
        return list.map((item) => PeneiraCardModel.fromJson(item)).toList();
      },
    );
  }

  Future<List<PeneiraCardModel>> getAllByClubeId() async {
    return _apiService.request<List<PeneiraCardModel>>(
      path: "/peneiras/clube",
      method: "GET",
      fromJson: (json) {
        final list = (json is List ? json : (json['data'] as List? ?? []));
        return list.map((item) => PeneiraCardModel.fromJson(item)).toList();
      },
    );
  }

  Future<PeneiraModel> getByPeneiraId(String peneiraId) async {
    return _apiService.request<PeneiraModel>(
        path: "/peneiras/$peneiraId",
        method: "GET",
        fromJson: (json) => PeneiraModel.fromJson(json));
  }
}
