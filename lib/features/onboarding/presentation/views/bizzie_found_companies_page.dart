import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class BizzieFoundCompaniesPage extends StatelessWidget {
  const BizzieFoundCompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final companies = state.onboardingData.detectedCompanies;
        final companyCount = companies.length;
        // Default to "Multiple" view logic if 0 (shouldn't happen ideally) or > 1
        // If 1, use Single view logic
        final isSingle = companyCount == 1;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Mascot Image (Placeholder for now, using a container/icon)
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        // color: Colors.blue.withOpacity(0.1), // Placeholder bg
                        // shape: BoxShape.circle,
                      ),
                      // TODO: Replace with actual Mascot asset when available
                      // child: Image.asset(AppAssets.bizzieMascot),
                      child: Image.asset(
                        AppAssets.onboardingBizzieMascotFoundCompanies,
                        height: 180,
                        // width: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Header
                  Text(
                    'Bizzie found $companyCount ${companyCount == 1 ? 'company' : 'companies'}',
                    style: AppTextStyles.h1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isSingle
                        ? 'Check out the company that makes the product you love below!'
                        : 'Check out the companies that make the products you love!',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Companies List/Card
                  if (isSingle)
                    _SingleCompanyCard(company: companies.first)
                  else
                    _MultipleCompaniesList(companies: companies),

                  const Spacer(),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(AppRoutes.onboardingAddingWatchlist);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SingleCompanyCard extends StatelessWidget {
  final Company company;

  const _SingleCompanyCard({required this.company});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: Center(
              child: Text(
                company.ticker.substring(0, 1),
                style: AppTextStyles.h3,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  company.ticker,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Placeholder for Price/Change
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$152.00', // Mock
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '+2.4%', // Mock
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MultipleCompaniesList extends StatelessWidget {
  final List<Company> companies;

  const _MultipleCompaniesList({required this.companies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Constrain height for horizontal or vertical
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: companies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _SingleCompanyCard(company: companies[index]);
        },
      ),
    );
  }
}
