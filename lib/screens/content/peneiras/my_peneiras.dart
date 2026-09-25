import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:peneiras/layout/screen_frame.dart';

import 'package:peneiras/providers/is_clube_controller.dart';
import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/services/peneira_enroll_service.dart';
import 'package:peneiras/services/peneira_service.dart';

import 'package:peneiras/widgets/peneira_card.dart';

class MyPeneirasScreen extends ConsumerStatefulWidget {
  const MyPeneirasScreen({super.key});

  @override
  ConsumerState<MyPeneirasScreen> createState() => _MyPeneirasScreenState();
}

class _MyPeneirasScreenState extends ConsumerState<MyPeneirasScreen> {
  bool isLoading = true;
  String? errorMessage;
  List<PeneiraCardModel> peneiras = [];

  @override
  void initState() {
    super.initState();
    _carregarPeneiras();
  }

  Future<List<PeneiraCardModel>> _buscarPeneiras(bool isClube) async {
    if (isClube) {
      return PeneiraService().getAllByClubeId();
    }

    final inscricoes = await PeneiraEnrollService().getAllEnrollments();

    return inscricoes.map((inscricao) => inscricao.peneira).toList();
  }

  Future<void> _carregarPeneiras() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final isClube = ref.read(isClubeProvider);

      final listaPeneiras = await _buscarPeneiras(isClube);

      if (mounted) {
        setState(() {
          peneiras = listaPeneiras;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          peneiras = [];
          errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Widget _buildConteudo() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Text(
        'Erro ao carregar: $errorMessage',
        style: const TextStyle(color: Colors.redAccent),
      );
    }

    if (peneiras.isEmpty) {
      return const Text('Nenhuma peneira encontrada');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: peneiras.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: PeneiraCard(
            peneira: peneiras[index],
            isEdit: true,
            onTap: (peneiraId) {
              context.go('/home/edit-peneira/$peneiraId');
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isClube = ref.watch(isClubeProvider);

    ref.listen<bool>(isClubeProvider, (previous, next) {
      if (previous != next) {
        _carregarPeneiras();
      }
    });

    return ScreenFrame(
      title: isClube ? 'Peneiras do clube' : 'Minhas inscrições',
      showBackButton: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const SizedBox(height: 20),
            if (isClube)
              Row(
                spacing: 16,
                children: [
                  const Expanded(
                    child: Text(
                        "Gerencie todas as peneiras que seu clube publicou"),
                  ),
                  _AddPeneiraButton(),
                ],
              ),
            _buildConteudo(),
          ],
        ),
      ),
    );
  }
}

class _AddPeneiraButton extends StatelessWidget {
  const _AddPeneiraButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go("/home/add-peneira");
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.greenAccent, width: 2),
            ),
            child: const Icon(Icons.add, color: Colors.greenAccent, size: 22),
          ),
        ),
      ),
    );
  }
}
