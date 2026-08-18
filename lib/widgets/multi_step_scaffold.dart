import 'package:flutter/material.dart';

class MultiStepScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final int totalSteps;
  final int currentStep;
  final VoidCallback onBack;
  final Widget child;

  const MultiStepScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.totalSteps,
    required this.currentStep,
    required this.onBack,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BackButton(
                          onPressed: onBack,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        title,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  StepIndicator(
                    totalSteps: totalSteps,
                    currentStep: currentStep,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: KeyedSubtree(
                      key: ValueKey(currentStep),
                      child: child,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isEven) {
          final stepIndex = index ~/ 2;
          final isActive = stepIndex <= currentStep;
          final isCompleted = stepIndex < currentStep;
          return Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.green : Colors.transparent,
              border: Border.all(
                color: isActive ? Colors.green : Colors.white54,
              ),
            ),
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : Text(
                    "${stepIndex + 1}",
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.white54,
                      fontSize: 12,
                    ),
                  ),
          );
        } else {
          final lineIndex = index ~/ 2;
          final isActive = lineIndex < currentStep;
          return Container(
            width: 40,
            height: 2,
            color: isActive ? Colors.green : Colors.white24,
          );
        }
      }),
    );
  }
}
