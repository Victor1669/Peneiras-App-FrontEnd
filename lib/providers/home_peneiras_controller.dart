import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/services/peneira_service.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

final allPeneirasProvider = FutureProvider<List<PeneiraCardModel>>((ref) async {
  return PeneiraService().getAll();
});

final homePeneirasProvider =
    Provider<AsyncValue<List<PeneiraCardModel>>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final asyncPeneiras = ref.watch(allPeneirasProvider);

  String normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9àáâãäåèéêëìíîïòóôõöùúûüçñ]'), '');
  }

  return asyncPeneiras.whenData((todas) {
    final cleanQuery = normalize(query);
    if (cleanQuery.length < 2) return todas;

    return todas.where((p) {
      final nome = normalize(p.clubeNome);
      final about = normalize(p.about);

      return nome.contains(cleanQuery) || about.contains(cleanQuery);
    }).toList();
  });
});
