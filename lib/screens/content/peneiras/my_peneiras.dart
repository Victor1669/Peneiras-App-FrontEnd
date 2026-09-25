import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:peneiras/layout/screen_frame.dart';

import 'package:peneiras/providers/is_clube_controller.dart';
import 'package:peneiras/providers/peneira_enroll_controller.dart';

import 'package:peneiras/widgets/peneira_card.dart';

class MyPeneirasScreen extends ConsumerWidget {
  const MyPeneirasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClube = ref.watch(isClubeProvider);
    final peneirasAsync = ref.watch(peneiraEnrollsProvider);

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
            peneirasAsync.when(
              data: (peneiras) {
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
                        isEdit: isClube,
                        onTap: (peneiraId) {
                          context.go(isClube
                              ? '/home/edit-peneira/$peneiraId'
                              : "/home/peneira-details/$peneiraId");
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text(
                'Erro ao carregar: $error',
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
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
