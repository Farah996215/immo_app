import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ensure the scaffold takes up the whole screen
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Background Image - Stretched to fill the screen
            Image.asset(
              'assets/splash_screen.png', 
              fit: BoxFit.fill, // This makes it cover the whole screen without stretching weirdly
              width: double.infinity, // Forces full width
              height: double.infinity, // Forces full height
            ),
            
            // 2. Purple Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple.withOpacity(0.3),
                    Colors.purple.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // 3. Center Content (Text & Loading)
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  
                  // House Icon
                  const Icon(
                    Icons.home_work_rounded, 
                    size: 80, 
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  
                  // App Name
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: 'Immo', style: TextStyle(color: Colors.black87)),
                        TextSpan(text: 'Finder', style: TextStyle(color: Colors.purple)),
                      ],
                    ),
                  ),
                  
                  // Subtitle
                  const Text(
                    'Trouvez votre bien idéal\nen Tunisie',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87, 
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Loading Spinner
                  const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),

            // 4. The Mascot
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset(
                'assets/home.png',
                width: 0,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}