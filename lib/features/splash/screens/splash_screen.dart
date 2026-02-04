import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../calculator/screens/calculator_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late AnimationController _particleController;
  late AnimationController _waveController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Gradient animation controller
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Pulse animation for microphone
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Scale animation for icon entrance
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Fade-in animation for text
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // Particle animation
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    // Wave animation for sound wave rings
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    // Start animations
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _scaleController.forward();
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _fadeController.forward();
      }
    });

    // Navigate to calculator after delay
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CalculatorScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    _particleController.dispose();
    _waveController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _gradientController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        const Color(0xFF0F172A),
                        const Color(0xFF1E1B4B),
                        const Color(0xFF312E81),
                        const Color(0xFF581C87),
                      ]
                    : [
                        const Color(0xFF5B21B6),
                        const Color(0xFF7C3AED),
                        const Color(0xFF8B5CF6),
                        const Color(0xFFA78BFA),
                      ],
                stops: [
                  0.0,
                  0.3 + (_gradientController.value * 0.2),
                  0.6 + (_gradientController.value * 0.2),
                  1.0,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Background glow effects
                Positioned(
                  top: -100,
                  left: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.purple.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -150,
                  right: -150,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.blue.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Particle effects
                ...List.generate(25, (index) => _buildParticle(index)),

                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Sound wave rings + App icon
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Animated sound wave rings
                          ...List.generate(3, (index) => _buildWaveRing(index)),

                          // App icon with multi-layer glassmorphism
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(38),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(0.25),
                                          Colors.white.withOpacity(0.05),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.1),
                                          blurRadius: 30,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(34),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white.withOpacity(0.3),
                                            Colors.white.withOpacity(0.15),
                                          ],
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.4),
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: isDark
                                                ? Colors.purple.withOpacity(0.4)
                                                : Colors.white.withOpacity(0.5),
                                            blurRadius:
                                                50 * _pulseAnimation.value,
                                            spreadRadius:
                                                15 * _pulseAnimation.value,
                                          ),
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.25,
                                            ),
                                            blurRadius: 30,
                                            offset: const Offset(0, 15),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Container(
                                          width: 140,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white.withOpacity(
                                                  0.6,
                                                ),
                                                blurRadius: 25,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Image.asset(
                                            'assets/icon/app_icon.png',
                                            width: 140,
                                            height: 140,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  // Fallback to microphone icon
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          const Color(
                                                            0xFF7C3AED,
                                                          ),
                                                          const Color(
                                                            0xFF9333EA,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.mic_rounded,
                                                      size: 90,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // App name with slide-in and fade
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _fadeController,
                                  curve: Curves.easeOut,
                                ),
                              ),
                          child: Column(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white.withOpacity(0.95),
                                      Colors.white,
                                    ],
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  'Voice Calc',
                                  style: GoogleFonts.outfit(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.15),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'Calculate with your voice',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.95),
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom branding
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Powered by Voice Recognition',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWaveRing(int index) {
    final delay = index * 0.33;
    final baseSize = 250.0 + (index * 60.0);

    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        final progress = (_waveController.value + delay) % 1.0;
        final scale = 1.0 + (progress * 0.4);
        final opacity = 1.0 - progress;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: baseSize,
            height: baseSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(opacity * 0.3),
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildParticle(int index) {
    final random = Random(index);
    final startX = random.nextDouble();
    final startY = random.nextDouble();
    final size = 1.5 + random.nextDouble() * 5;
    final speed = 0.3 + random.nextDouble() * 0.4;
    final horizontalDrift = (random.nextDouble() - 0.5) * 0.2;

    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        final progress = (_particleController.value + (index * 0.05)) % 1.0;
        final opacity = sin(progress * pi);

        // Floating effect
        final yPos = (startY + progress * speed) % 1.0;
        final xOffset = sin(progress * pi * 2) * 0.03;

        return Positioned(
          left:
              MediaQuery.of(context).size.width *
              (startX + horizontalDrift * progress + xOffset),
          top: MediaQuery.of(context).size.height * yPos,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(opacity * 0.8),
                  Colors.white.withOpacity(opacity * 0.3),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(opacity * 0.5),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
