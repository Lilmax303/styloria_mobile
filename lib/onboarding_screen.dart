// lib/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'services/location_service.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  /// Check if onboarding has been completed
  static Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompleteKey) ?? false;
  }

  /// Mark onboarding as complete
  static Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  /// Reset onboarding (for testing)
  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, false);
  }

  static const String _onboardingCompleteKey = 'onboarding_complete';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _requestingPermission = false;

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _handleEnableLocation() async {
    setState(() => _requestingPermission = true);

    final result = await LocationService.requestLocationPermission();

    if (!mounted) return;
    setState(() => _requestingPermission = false);

    final l10n = AppLocalizations.of(context);

    if (result.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.onboardingLocationEnabled),
          backgroundColor: Colors.green,
        ),
      );
    } else if (result.status == LocationPermissionStatus.permanentlyDenied) {
      _showPermanentlyDeniedDialog();
      return;
    } else if (result.status == LocationPermissionStatus.serviceDisabled) {
      _showServiceDisabledDialog();
      return;
    }

    // Complete onboarding regardless of permission result
    await _completeOnboarding();
  }

  Future<void> _handleSkipLocation() async {
    await _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    await OnboardingScreen.setOnboardingComplete();
    widget.onComplete();
  }

  void _showPermanentlyDeniedDialog() {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.onboardingLocationDeniedTitle),
        content: Text(l10n.onboardingLocationDeniedMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _completeOnboarding();
            },
            child: Text(l10n.onboardingContinueWithoutLocation),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await LocationService.openAppSettings();
            },
            child: Text(l10n.onboardingOpenSettings),
          ),
        ],
      ),
    );
  }

  void _showServiceDisabledDialog() {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.onboardingLocationServicesOffTitle),
        content: Text(l10n.onboardingLocationServicesOffMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _completeOnboarding();
            },
            child: Text(l10n.onboardingContinueWithoutLocation),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await LocationService.openLocationSettings();
            },
            child: Text(l10n.onboardingEnableLocationServices),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (only on first 3 pages)
            if (_currentPage < 3)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () => _pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: Text(l10n.onboardingSkip),
                  ),
                ),
              )
            else
              const SizedBox(height: 56), // Maintain spacing

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _buildWelcomePage(l10n),
                  _buildCustomerPage(l10n),
                  _buildProviderPage(l10n),
                  _buildLocationPage(l10n),
                ],
              ),
            ),

            // Page indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: _buildNavigationButtons(l10n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(AppLocalizations l10n) {
    if (_currentPage == 3) {
      // Location page - special buttons
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _requestingPermission ? null : _handleEnableLocation,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: _requestingPermission
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      l10n.onboardingEnableLocation,
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _requestingPermission ? null : _handleSkipLocation,
            child: Text(
              l10n.onboardingMaybeLater,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      );
    }

    // Other pages - Next/Back buttons
    return Row(
      children: [
        if (_currentPage > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: _previousPage,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(l10n.backButton),
            ),
          ),
        if (_currentPage > 0) const SizedBox(width: 16),
        Expanded(
          flex: _currentPage == 0 ? 1 : 1,
          child: ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              _currentPage == 0 ? l10n.onboardingGetStarted : l10n.nextButton,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomePage(AppLocalizations l10n) {
    return _OnboardingPage(
      icon: Icons.spa,
      iconColor: Theme.of(context).primaryColor,
      title: l10n.onboardingWelcomeTitle,
      subtitle: l10n.onboardingWelcomeSubtitle,
      description: l10n.onboardingWelcomeDescription,
    );
  }

  Widget _buildCustomerPage(AppLocalizations l10n) {
    return _OnboardingPage(
      icon: Icons.calendar_today,
      iconColor: Colors.blue,
      title: l10n.onboardingCustomerTitle,
      subtitle: l10n.onboardingCustomerSubtitle,
      bulletPoints: [
        l10n.onboardingCustomerBullet1,
        l10n.onboardingCustomerBullet2,
        l10n.onboardingCustomerBullet3,
        l10n.onboardingCustomerBullet4,
      ],
    );
  }

  Widget _buildProviderPage(AppLocalizations l10n) {
    return _OnboardingPage(
      icon: Icons.work_outline,
      iconColor: Colors.green,
      title: l10n.onboardingProviderTitle,
      subtitle: l10n.onboardingProviderSubtitle,
      bulletPoints: [
        l10n.onboardingProviderBullet1,
        l10n.onboardingProviderBullet2,
        l10n.onboardingProviderBullet3,
        l10n.onboardingProviderBullet4,
      ],
    );
  }

  Widget _buildLocationPage(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on,
              size: 50,
              color: Colors.orange.shade600,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            l10n.onboardingLocationTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingLocationSubtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Benefits list
          _buildLocationBenefit(
            Icons.search,
            l10n.onboardingLocationBenefit1,
          ),
          _buildLocationBenefit(
            Icons.attach_money,
            l10n.onboardingLocationBenefit2,
          ),
          _buildLocationBenefit(
            Icons.people,
            l10n.onboardingLocationBenefit3,
          ),
          _buildLocationBenefit(
            Icons.navigation,
            l10n.onboardingLocationBenefit4,
          ),
          const SizedBox(height: 24),
          // Privacy note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              children: [
                Icon(Icons.shield, color: Colors.blue.shade700, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.onboardingLocationPrivacyNote,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildLocationBenefit(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.green.shade600, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable onboarding page widget
class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? description;
  final List<String>? bulletPoints;

  const _OnboardingPage({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.description,
    this.bulletPoints,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 50, color: iconColor),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const SizedBox(height: 24),
            Text(
              description!,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (bulletPoints != null) ...[
            const SizedBox(height: 32),
            ...bulletPoints!.map((point) => _buildBulletPoint(point, iconColor)),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}