import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/providers/is_clube_controller.dart';
import 'package:peneiras/services/peneira_enroll_service.dart';
import 'package:peneiras/services/peneira_service.dart';

final peneiraEnrollsProvider =
    FutureProvider<List<PeneiraCardModel>>((ref) async {
  final isClube = ref.watch(isClubeProvider);

  if (isClube) {
    return PeneiraService().getAllByClubeId();
  }

  final inscricoes = await PeneiraEnrollService().getAllEnrollments();
  return inscricoes.map((inscricao) => inscricao.peneira).toList();
});
