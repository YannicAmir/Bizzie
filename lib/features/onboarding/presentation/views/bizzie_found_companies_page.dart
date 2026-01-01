import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';

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
            child: Column(
              children: [
                OnboardingHeader(
                  progressIndicator: LinearProgressIndicator(
                    value: 7 / 14,
                    backgroundColor: AppColors.slate200,
                    color: AppColors.primary,
                    minHeight: 4,
                  ),
                  title:
                      'Bizzie found $companyCount ${companyCount == 1 ? 'company' : 'companies'}',
                  subtitle: isSingle
                      ? 'Check out the company that makes the product you love below!'
                      : 'Check out the companies that make the products you love!',
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        // Mascot Image
                        Center(
                          child: Image.asset(
                            AppAssets.onboardingBizzieMascotFoundCompanies,
                            height: 238, // Match WelcomePage
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Companies List/Card
                        if (isSingle) ...[
                          _SingleCompanyCard(company: companies.first),
                          const Spacer(),
                        ] else
                          _MultipleCompaniesList(companies: companies),
                      ],
                    ),
                  ),
                ),
                OnboardingFooter(
                  primaryButton: ElevatedButton(
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
              ],
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
              color: const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                AppAssets.arrowUpIcon,
                width: 24,
                height: 24,
                color: AppColors.primary,
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
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  company.ticker,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
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
    return Expanded(
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
