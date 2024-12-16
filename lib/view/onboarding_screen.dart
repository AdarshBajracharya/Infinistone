import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to PawPal",
      "description": "Your ultimate companion for pet care and management.",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "For Pet Owners",
      "description":
          "Find trusted pet sitters and ensure your furry friends are in good hands.",
      "image": "assets/images/onboarding2.png",
    },
    {
      "title": "For Pet Sitters",
      "description":
          "Connect with pet owners and grow your pet-sitting business.",
      "image": "assets/images/onboarding3.png",
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F3),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => _buildOnboardingPage(
                onboardingData[index]["title"]!,
                onboardingData[index]["description"]!,
                onboardingData[index]["image"]!,
              ),
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(String title, String description, String image) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB55C50),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              // Navigate to Registration View
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFB55C50),
              ),
            ),
          ),
          Row(
            children: List.generate(
              onboardingData.length,
              (index) => Container(
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFFB55C50)
                      : Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (_currentPage == onboardingData.length - 1) {
                // Navigate to Registration View
                Navigator.pushReplacementNamed(context, '/login');
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            icon: Icon(
              _currentPage == onboardingData.length - 1
                  ? Icons.check
                  : Icons.arrow_forward,
              color: const Color(0xFFB55C50),
            ),
          ),
        ],
      ),
    );
  }
}
