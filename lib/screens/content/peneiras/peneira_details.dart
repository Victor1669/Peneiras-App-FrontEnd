import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:peneiras/layout/screen_frame.dart';

import 'package:peneiras/models/enums.dart';
import 'package:peneiras/models/peneira_model.dart';

import 'package:peneiras/providers/is_clube_controller.dart';
import 'package:peneiras/providers/peneira_enroll_controller.dart';

import 'package:peneiras/services/peneira_enroll_service.dart';
import 'package:peneiras/services/peneira_service.dart';

class PeneiraDetailsScreen extends ConsumerStatefulWidget {
  final String peneiraId;

  const PeneiraDetailsScreen({super.key, required this.peneiraId});

  @override
  ConsumerState<PeneiraDetailsScreen> createState() =>
      _PeneiraDetailsScreenState();
}

class _PeneiraDetailsScreenState extends ConsumerState<PeneiraDetailsScreen> {
  late Future<PeneiraModel> _peneiraFuture;

  @override
  void initState() {
    super.initState();
    _getPeneiras();
  }

  Future<void> _getPeneiras() async {
    _peneiraFuture = PeneiraService().getByPeneiraId(widget.peneiraId);
  }

  Future<void> _handleEnrollPeneira(String peneiraId) async {
    if (peneiraId.isNotEmpty) {
      await PeneiraEnrollService().enrollPeneira(peneiraId);
      ref.invalidate(peneiraEnrollsProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isClube = ref.watch(isClubeProvider);
    final peneirasAsync = ref.watch(peneiraEnrollsProvider);

    return ScreenFrame(
      title: "Peneira",
      headerFontSize: 20,
      child: FutureBuilder<PeneiraModel>(
        future: _peneiraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Peneira não encontrada'));
          }

          final peneira = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            "Peneira ${peneira.category.value}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('Data', peneira.date),
                    _buildInfoBox('Horário', peneira.hour),
                    _buildInfoBox(
                      'Local',
                      peneira.modality.value,
                    ),
                  ],
                ),
                _buildSection(
                  'Sobre a peneira',
                  peneira.about,
                  Icons.info,
                ),
                _buildUniformsSection(peneira.uniforms),
                _buildSection(
                  'O que levar',
                  peneira.documents.value,
                  Icons.folder,
                ),
                _buildSection(
                  'Endereço',
                  'CT Peneira fc',
                  Icons.location_on,
                ),
                if (!isClube)
                  peneirasAsync.when(
                    loading: () => const SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: null,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (error, stackTrace) => const SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: null,
                        child: Text('Erro ao carregar'),
                      ),
                    ),
                    data: (peneiras) {
                      final isEnrolled =
                          peneiras.any((p) => p.id == peneira.id);

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isEnrolled
                              ? null
                              : () => _handleEnrollPeneira(peneira.id),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            isEnrolled ? 'Inscrito' : 'Inscrever-se',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildUniformsSection(List<UniformType> uniforms) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checkroom, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text(
              'Uniformes',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            uniforms.length > 3 ? 3 : uniforms.length,
            (index) => Expanded(
              child: Container(
                height: 32,
                margin: EdgeInsets.only(
                  right: index < 2 ? 8 : 0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    uniforms[index].value,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.white12,
          height: 24,
        ),
      ],
    );
  }

  Widget _buildSection(
    String title,
    String content,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
        const Divider(
          color: Colors.white12,
          height: 24,
        ),
      ],
    );
  }
}
