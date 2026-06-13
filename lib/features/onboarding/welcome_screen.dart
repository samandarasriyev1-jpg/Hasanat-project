import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/gradient_button.dart';

/// Welcome / Onboarding ekrani — premium dizaynda.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  gradient: AppColors.emeraldGradient,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Icon(
                  Icons.volunteer_activism_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Hasanat',
                style: text.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Salovat ayting, ehson qiling, hasharga qatnashing va '
                'yaxshilikda mahalla, tuman, viloyat bo'ylab bellashing.',
                style: text.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              GradientButton(
                label: 'Boshlash',
                icon: Icons.arrow_forward_rounded,
                onPressed: () => context.go('/home'),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
