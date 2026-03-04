import 'dart:math' as math;
import 'package:flutter/material.dart';

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _MainScreenState();
}


class _MainScreenState extends State<main_screen>
    with SingleTickerProviderStateMixin {


  double _progress = 0.0;
  int _cityLoadedCount = 0;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;


  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOut,
      ),
    );


    Future.delayed(const Duration(seconds: 1), () {
      _animateTo(0.8, 4);
    });
  }


  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }


  void _animateTo(double newProgress, int cityCount) {
    _progressAnimation = Tween<double>(
      begin: _progress,
      end: newProgress,
    ).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOut,
      ),
    );
    _progressController.forward(from: 0);
    setState(() {
      _progress = newProgress;
      _cityLoadedCount = cityCount;
    });
  }


  Widget _buildGauge() {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, _) {
        final value = _progressController.isAnimating
            ? _progressAnimation.value
            : _progress;
        return SizedBox(
          width: 210,
          height: 210,
          child: Stack(
            alignment: Alignment.center,
            children: [

              CustomPaint(
                size: const Size(210, 210),
                painter: _TrackPainter(),
              ),

              CustomPaint(
                size: const Size(210, 210),
                painter: _ArcPainter(progress: value),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(value * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$_cityLoadedCount / 5',
                    style: const TextStyle(
                      color: Color(0xFF7A8FAD),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildMessage() {
    return const Column(
      children: [
        Text(
          'Analyse des températures...',
          style: TextStyle(
            color: Color(0xFF7A8FAD),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Dakar ✓',
          style: TextStyle(
            color: Color(0xFF4FC3F7),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }


  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF4FC3F7),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2035),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Météo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2035),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),


            const Spacer(),
            _buildGauge(),
            const SizedBox(height: 40),
            _buildMessage(),
            const SizedBox(height: 32),
            _buildDots(),
            const Spacer(),

          ],
        ),
      ),
    );
  }

}

class _TrackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2 - 10,
      Paint()
        ..color = const Color(0xFF111827)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _ArcPainter extends CustomPainter {
  final double progress;
  _ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final rect = Rect.fromLTWH(
      10, 10,
      size.width - 20,
      size.height - 20,
    );


    canvas.drawArc(
      rect,
      -math.pi / 2,
      progress * 2 * math.pi,
      false,
      Paint()
        ..color = const Color(0xFF4FC3F7).withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 26
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );


    canvas.drawArc(
      rect,
      -math.pi / 2,
      progress * 2 * math.pi,
      false,
      Paint()
        ..color = const Color(0xFF4FC3F7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) =>
      old.progress != progress;
}