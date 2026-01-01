import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';

import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';

class FeatureHighlightsPage extends StatefulWidget {
  const FeatureHighlightsPage({super.key});

  @override
  State<FeatureHighlightsPage> createState() => _FeatureHighlightsPageState();
}

class _FeatureHighlightsPageState extends State<FeatureHighlightsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<_CarouselItem> _getExpertItems(
    String? companyName,
    List<Brand> selectedBrands,
  ) {
    // Default fallback if no company found (though flow usually ensures one)
    final company = companyName ?? 'Apple';
    return [
      _CarouselItem(
        title: 'Expert investors will love',
        description:
            'View the full financial history of $company and other companies',
        illustration: const _HistoricalDataCard(),
      ),
      _CarouselItem(
        title: 'Expert investors will love',
        description:
            'Never miss quarterly or annual report releases from your watchlist',
        illustration: _FinancialReportAlertsCard(companies: selectedBrands),
      ),
      const _CarouselItem(
        title: 'Expert investors will love',
        description:
            'Deep dive into 10-K and 10-Q reports with AI-powered summaries',
        illustration: _SummaryIllustration(),
      ),
    ];
  }

  List<_CarouselItem> _getIntermediateItems(List<Brand> selectedBrands) {
    return [
      const _CarouselItem(
        title: 'Experienced investors will love',
        description: 'Visualize Apple and other company financials at a glance',
        illustration: _VisualFinancialsCard(),
      ),
      _CarouselItem(
        title: 'Experienced investors will love',
        description: 'Easily find stocks by searching for your favorite brands',
        illustration: _BrandSearchCard(brands: selectedBrands),
      ),
      const _CarouselItem(
        title: 'Experienced investors will love',
        description:
            'Bizzie analyzes full reports and summarizes with quick insights',
        illustration: _SummaryIllustration(),
      ),
    ];
  }

  List<_CarouselItem> _getBeginnerItems(
    List<Brand> selectedBrands,
    Sector? selectedSector,
  ) {
    return [
      const _CarouselItem(
        title: 'Beginners will love',
        description: 'Bizzie makes complex topics easy to understand',
        illustration: _EasyToUnderstandCard(),
      ),
      _CarouselItem(
        title: 'Beginners will love',
        description:
            'Easily find stocks by searching for your favorite brands & products',
        illustration: _BrandSearchCard(brands: selectedBrands),
      ),
      _CarouselItem(
        title: 'Beginners will love',
        description:
            'Get a daily list of stocks to explore--personalized just for you',
        illustration: _DailyPicksCard(
          selectedSector: selectedSector,
          selectedBrands: selectedBrands,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final experience = state.onboardingData.investingExperience;
        // Fetch the first detected company logic:
        // We look at detectedCompanies. If empty, maybe fallback to 'Apple' or specific logic.
        // Assuming `detectedCompanies` is populated by previous steps.
        final companyName =
            state.onboardingData.detectedCompanies.firstOrNull?.name;

        List<_CarouselItem> items;
        switch (experience) {
          case InvestingExperience.expert:
            items = _getExpertItems(companyName, state.selectedBrands);
            break;
          case InvestingExperience.intermediate:
            items = _getIntermediateItems(state.selectedBrands);
            break;
          case InvestingExperience.beginner:
          default:
            items = _getBeginnerItems(
              state.selectedBrands,
              state.onboardingData.selectedSector,
            );
            break;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Top Bar with Skip
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            AppAssets.backArrowIcon,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.go(AppRoutes.createAccount),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Color(0xFF314158),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: Column(
                    children: [
                      // Illustration Carousel
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: items.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: double.infinity,
                              child: items[index].illustration,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Numbered Indicators (Left Aligned)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(items.length, (index) {
                            final isSelected = _currentPage == index;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 12),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.slate200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                // Footer with Content and Button
                OnboardingFooter(
                  shiftDown: true,
                  fixedTextHeight: 160,
                  title: items[_currentPage].title,
                  subtitle: items[_currentPage].description,
                  primaryButton: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < items.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        context.go(AppRoutes.createAccount);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage < items.length - 1 ? 'Next' : 'Continue',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CarouselItem {
  final String title;
  final String description;
  final Widget illustration;

  const _CarouselItem({
    required this.title,
    required this.description,
    required this.illustration,
  });
}

// --- Illustration Widgets ---

class _HistoricalDataCard extends StatelessWidget {
  const _HistoricalDataCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity, // Ensure consistent height
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEFF6FF), // rgb(239, 246, 255)
            Color(0xFFEEF2FF), // rgb(238, 242, 255)
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Full historical data',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                height: 30 / 24,
                letterSpacing: 0.07,
                color: Color(0xFF0F172B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'View complete financial history over time',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF45556C),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 10),
                    blurRadius: 15,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header removed as requested
                  const Text(
                    'Yearly Revenue',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172B),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Chart Area
                  SizedBox(
                    height: 140,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _barItem('17', 60),
                            _barItem('18', 75),
                            _barItem('19', 70),
                            _barItem('20', 78),
                            _barItem('21', 95),
                            _barItem('22', 100),
                            _barItem('23', 95),
                            _barItem('24', 110),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 16),

                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '5-Year CAGR',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'HIGH',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF166534),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '+7.1%',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF166534),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barItem(String label, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _FinancialReportAlertsCard extends StatelessWidget {
  const _FinancialReportAlertsCard({this.companies = const []});

  final List<Brand> companies;

  @override
  Widget build(BuildContext context) {
    // Determine which companies to show
    // Use first 2 selected brands if available, otherwise fallback placeholders
    final firstCompany = companies.isNotEmpty ? companies[0] : null;
    final secondCompany = companies.length > 1 ? companies[1] : null;

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEFF6FF), // rgb(239, 246, 255)
            Color(0xFFEEF2FF), // rgb(238, 242, 255)
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Financial report alerts',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                height: 30 / 24,
                letterSpacing: 0.07,
                color: Color(0xFF0F172B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Get notified when reports are released',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF45556C),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 10),
                    blurRadius: 15,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // New Header based on Node 15:13293
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2B7FFF), Color(0xFF4F39F6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Image.asset(AppAssets.bellIcon),
                        ),
                        const SizedBox(width: 8),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upcoming Reports',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172B),
                              ),
                            ),
                            Text(
                              'From your watchlist',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF62748E),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  _alertItem(
                    companyName: firstCompany?.company ?? 'Netflix',
                    ticker: firstCompany?.ticker ?? 'NFLX',
                    status: 'Q1 Earnings',
                    timeAgo: '1 week',
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 16),
                  _alertItem(
                    companyName: secondCompany?.company ?? 'Microsoft',
                    ticker: secondCompany?.ticker ?? 'MSFT',
                    status: 'Q1 Earnings',
                    timeAgo: 'Today',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _alertItem({
    required String companyName,
    required String ticker,
    required String status,
    required String timeAgo,
    String? badgeText,
  }) {
    return Row(
      children: [
        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    companyName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172B),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFFCBD5E1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    ticker,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  if (badgeText != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badgeText,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        // Time Ago
        Text(
          timeAgo,
          style: const TextStyle(
            color: Color(0xFF155DFC),
            fontFamily: 'Inter',
            fontSize: 12,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            height: 18 / 12, // line-height: 18px
          ),
        ),
      ],
    );
  }
}

class _SummaryIllustration extends StatelessWidget {
  const _SummaryIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEFF6FF), // rgb(239, 246, 255)
            Color(0xFFEEF2FF), // rgb(238, 242, 255)
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AI analysis of financial reports',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                height: 30 / 24,
                letterSpacing: 0.07,
                color: Color(0xFF0F172B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Deep insights from quarterly and annual reports',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF45556C),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 10),
                    blurRadius: 15,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFF1F5F9)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2B7FFF), Color(0xFF4F39F6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Image.asset(
                            AppAssets.sparkleIcon,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '10-K Annual Report',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172B),
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              'FY ${DateTime.now().year}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF62748E),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Bullets
                  const SizedBox(height: 8),
                  _bulletPoint(
                    'Revenue grew 13% YoY to \$24.2B, driven by increased in units sold',
                    isPositive: true,
                  ),
                  const SizedBox(height: 8),
                  _bulletPoint(
                    'Free cash flow of \$5.5B, up 7% YoY',
                    isPositive: true,
                  ),
                  const SizedBox(height: 8),
                  _bulletPoint(
                    'Net income declined 2% YoY due to increased COGS and R&D expenses',
                    isPositive: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bulletPoint(String text, {required bool isPositive}) {
    // Styles
    final Color bgColor = isPositive
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFFFE2E2);
    final Color iconColor = isPositive
        ? const Color(0xFF166534)
        : const Color(0xFFB91C1C);
    final String iconAsset = isPositive
        ? AppAssets.arrowUpIcon
        : AppAssets.arrowDownIcon;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            padding: const EdgeInsets.all(5),
            child: Image.asset(iconAsset, color: iconColor),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5, // 21px / 14px
              letterSpacing: -0.15,
              color: Color(0xFF314158),
            ),
          ),
        ),
      ],
    );
  }
}

class _VisualFinancialsCard extends StatelessWidget {
  const _VisualFinancialsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFF6FF), Color(0xFFEEF2FF)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Visual financials',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                height: 30 / 24,
                letterSpacing: 0.07,
                color: Color(0xFF0F172B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Understand company performance with charts',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF45556C),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 10),
                    blurRadius: 15,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quarterly Revenue',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172B),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 140, // Chart area height
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _chartBar('Q1', 0.6),
                        _chartBar('Q2', 0.75),
                        _chartBar('Q3', 0.85),
                        _chartBar('Q4', 1.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'YoY Growth',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.trending_up,
                        size: 16,
                        color: Color(0xFF00732B),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '+8.2%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF00732B),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chartBar(String label, double heightFactor) {
    const double maxBarHeight = 100.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: maxBarHeight * heightFactor,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFF2B7FFF), Color(0xFF51A2FF)],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}

class _BrandSearchCard extends StatelessWidget {
  final List<Brand> brands;

  const _BrandSearchCard({required this.brands});

  @override
  Widget build(BuildContext context) {
    // Show only the first selected brand, or a fallback if none
    final displayBrand = brands.isNotEmpty
        ? brands.first
        : const Brand(
            name: 'Apple',
            company: 'Apple',
            ticker: 'AAPL',
            description: '',
            imageUrl: null,
          );

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFF6FF), Color(0xFFEEF2FF)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Search brands, get stocks',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 30 / 24,
                letterSpacing: 0.07,
                color: Color(0xFF0F172B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Search products to see if they're owned by stock market companies",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // Search Bar Visual
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.searchIcon,
                    width: 20,
                    height: 20,
                    color: const Color(0xFF64748B),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      displayBrand.name, // Show only the selected brand name
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        color: Color(
                          0xFF0F172B,
                        ), // Darker text to simulate typed input
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 1),
                  Container(
                    width: 1.5,
                    height: 18,
                    color: const Color(0xFF3B82F6), // Blue cursor
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Single Brand Card Result
            Container(
              padding: const EdgeInsets.all(
                12,
              ), // 16px padding on design, maybe less here
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Logo Container
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFDBEAFE), Color(0xFFE0E7FF)],
                      ),
                    ),
                    child: Center(
                      child: displayBrand.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                displayBrand.imageUrl!,
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _buildFallbackLogo(displayBrand.name),
                              ),
                            )
                          : _buildFallbackLogo(displayBrand.name),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayBrand.company,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          displayBrand.ticker,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Trend Icon
                  const Icon(
                    Icons.trending_up,
                    color: Color(0xFF16A34A),
                    size: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ), // Right padding visual adjustment if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackLogo(String name) {
    return Text(
      name.isNotEmpty ? name[0] : 'B',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }
}

class _EasyToUnderstandCard extends StatelessWidget {
  const _EasyToUnderstandCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFF6FF), Color(0xFFEEF2FF)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Easy to understand',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 30 / 24,
                letterSpacing: 0.07,
                color: Color(0xFF0F172B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "See if metrics are high or low at a glance",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // The Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // P/FCF Ratio
                  _MetricRow(
                    label: 'P/FCF Ratio',
                    valueWidget: const Text(
                      '35.5',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172B),
                      ),
                    ),
                    badgeText: 'HIGH',
                    badgeColor: const Color(0xFFFFEDD5), // Orange-100
                    badgeTextColor: const Color(0xFFC2410C), // Orange-700
                  ),
                  const SizedBox(height: 8),
                  // P/E Ratio
                  _MetricRow(
                    label: 'P/E Ratio',
                    valueWidget: const Text(
                      '34.5',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172B),
                      ),
                    ),
                    badgeText: 'HIGH',
                    badgeColor: const Color(0xFFFFEDD5), // Orange-100
                    badgeTextColor: const Color(0xFFC2410C), // Orange-700
                  ),
                  const SizedBox(height: 8),
                  // Revenue Growth
                  _MetricRow(
                    label: 'Revenue Growth',
                    valueWidget: Row(
                      children: const [
                        Text(
                          '+8.2%',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172B),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'YoY',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    badgeText: 'HIGH',
                    badgeColor: const Color(0xFFDCFCE7), // Green-100
                    badgeTextColor: const Color(0xFF15803D), // Green-700
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label;
  final Widget valueWidget;
  final String badgeText;
  final Color badgeColor;
  final Color badgeTextColor;

  const _MetricRow({
    required this.label,
    required this.valueWidget,
    required this.badgeText,
    required this.badgeColor,
    required this.badgeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // Slate-50
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 4),
              valueWidget,
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              badgeText,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: badgeTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyPicksCard extends StatelessWidget {
  final Sector? selectedSector;
  final List<Brand> selectedBrands;

  const _DailyPicksCard({this.selectedSector, this.selectedBrands = const []});

  String _getMascotAsset() {
    switch (selectedSector) {
      case Sector.informationTechnology:
        return AppAssets.bizzieMascotIT;
      case Sector.financials:
        return AppAssets.bizzieMascotFinancials;
      case Sector.communicationServices:
        return AppAssets.bizzieMascotCommunicationServices;
      case Sector.consumerDiscretionary:
        return AppAssets.bizzieMascotConsumerDiscretionary;
      case Sector.consumerStaples:
        return AppAssets.bizzieMascotConsumerStaples;
      case Sector.energy:
        return AppAssets.bizzieMascotEnergy;
      case Sector.healthCare:
        return AppAssets.bizzieMascotHealthcare;
      case Sector.industrials:
        return AppAssets.bizzieMascotIndustrials;
      case Sector.materials:
        return AppAssets.bizzieMascotMaterials;
      case Sector.realEstate:
        return AppAssets.bizzieMascotRealEstate;
      case Sector.utilities:
        return AppAssets.bizzieMascotUtilities;
      default:
        return AppAssets.onboardingBizzieMascot;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Logic to pick list items: take top 2 from selectedBrands, or fallback
    final List<Brand> displayBrands = [];
    if (selectedBrands.isNotEmpty) {
      displayBrands.addAll(selectedBrands.take(2));
    }
    // Ideally we want 2 items. If user has < 2, we could add fallbacks,
    // but the request said "show 2 companies only that correspond...".
    // If list is empty, let's show default fallbacks to avoid empty card.
    if (displayBrands.isEmpty) {
      displayBrands.add(
        const Brand(
          name: 'Apple Inc.',
          company: 'Apple Inc.',
          ticker: 'AAPL',
          description: '',
        ),
      );
      displayBrands.add(
        const Brand(
          name: 'Microsoft',
          company: 'Microsoft',
          ticker: 'MSFT',
          description: '',
        ),
      );
    } else if (displayBrands.length == 1) {
      // If only 1 selected, add a fallback to maintain layout balance (or just show 1? Request said "show 2 companies")
      displayBrands.add(
        const Brand(
          name: 'Microsoft',
          company: 'Microsoft',
          ticker: 'MSFT',
          description: '',
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFF6FF), Color(0xFFEEF2FF)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Get Bizzie's research lists",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 30 / 24,
                letterSpacing: 0.07,
                color: Color(0xFF0F172B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Curated research picks just for you",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // The Card
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header with Icon
                    Row(
                      children: [
                        Image.asset(_getMascotAsset(), width: 40, height: 40),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Today's Review",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172B),
                              ),
                            ),
                            Text(
                              'See what Bizzie is researching today!',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    const SizedBox(height: 16),
                    // Stock Items
                    ...displayBrands.map((brand) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _StockPickItem(
                          symbol: brand.ticker,
                          name: brand.company,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StockPickItem extends StatelessWidget {
  final String symbol;
  final String name;

  const _StockPickItem({required this.symbol, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              symbol,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172B),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'See products',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: Color(0xFF64748B), // Slate 400
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              size: 16,
              color: Color(0xFF94A3B8), // Slate 400
            ),
          ],
        ),
      ],
    );
  }
}
