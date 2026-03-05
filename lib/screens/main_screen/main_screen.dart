import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/meteo_provider.dart';
import '../../providers/theme_provider.dart';
import 'Liste_Ville.dart';
import 'CityDetailScreen.dart';

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _MainScreenState();
}

class _MainScreenState extends State<main_screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _oldProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    // Lancer le chargement
    context.read<MeteoProvider>().chargerMeteo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(double target) {
    _animation = Tween<double>(begin: _oldProgress, end: target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward(from: 0);
    _oldProgress = target;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MeteoProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Animer la jauge vers la progression actuelle
    if (provider.progression != _oldProgress) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animateTo(provider.progression);
      });
    }

    // Afficher les resultats quand le chargement est termine
    if (provider.etat == EtatChargement.succes) {
      final cities = provider.donneesMeteo
          .map((m) => WeatherData(
                city: m.nomVille,
                temperature: m.temperature,
                tempMin: m.temperature - 3,
                tempMax: m.temperature + 3,
                condition: m.description,
                icon: _iconFromCode(m.icone),
                humidity: m.humidite.toDouble(),
                windSpeed: m.vitesseVent,
                lat: m.latitude,
                lng: m.longitude,
              ))
          .toList();

      return Scaffold(
        body: SafeArea(
          child: ResultsScreen(
            cities: cities,
            onRestart: () {
              _oldProgress = 0.0;
              provider.reinitialiser();
              provider.chargerMeteo();
            },
          ),
        ),
      );
    }

    // Ecran de chargement avec jauge
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Bouton retour
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.arrow_back_ios_new,
                          color: colorScheme.onSurface, size: 18),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Météo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // Toggle theme
                  GestureDetector(
                    onTap: () => context.read<ThemeProvider>().toggleTheme(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        color: colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Jauge animee
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                final value = _controller.isAnimating
                    ? _animation.value
                    : _oldProgress;
                return SizedBox(
                  width: 210,
                  height: 210,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(210, 210),
                        painter: _TrackPainter(
                          color: isDark
                              ? const Color(0xFF111827)
                              : const Color(0xFFE0E0E0),
                        ),
                      ),
                      CustomPaint(
                        size: const Size(210, 210),
                        painter: _ArcPainter(
                          progress: value,
                          color: colorScheme.primary,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(value * 100).toInt()}%',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${provider.donneesMeteo.length} / 5',
                            style: TextStyle(
                              color: colorScheme.onSurface.withAlpha(120),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            // Message d'attente dynamique
            Text(
              provider.messageActuel,
              style: TextStyle(
                color: colorScheme.onSurface.withAlpha(150),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            if (provider.donneesMeteo.isNotEmpty)
              Text(
                '${provider.donneesMeteo.last.nomVille} \u2713',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

            const SizedBox(height: 32),

            // Dots indicateur
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == provider.indexMessage
                        ? colorScheme.primary
                        : colorScheme.primary.withAlpha(60),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),

            const Spacer(),

            // Message d'erreur + retry
            if (provider.etat == EtatChargement.erreur)
              Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                child: Column(
                  children: [
                    Text(
                      provider.messageErreur,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _oldProgress = 0.0;
                          provider.reinitialiser();
                          provider.chargerMeteo();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Réessayer'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _iconFromCode(String code) {
    switch (code) {
      case '01d' || '01n':
        return '\u2600\uFE0F';
      case '02d' || '02n':
        return '\u26C5';
      case '03d' || '03n' || '04d' || '04n':
        return '\u2601\uFE0F';
      case '09d' || '09n':
        return '\uD83C\uDF27\uFE0F';
      case '10d' || '10n':
        return '\uD83C\uDF26\uFE0F';
      case '11d' || '11n':
        return '\u26C8\uFE0F';
      case '13d' || '13n':
        return '\u2744\uFE0F';
      case '50d' || '50n':
        return '\uD83C\uDF2B\uFE0F';
      default:
        return '\uD83C\uDF24\uFE0F';
    }
  }
}

class _TrackPainter extends CustomPainter {
  final Color color;
  _TrackPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2 - 10,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18,
    );
  }

  @override
  bool shouldRepaint(covariant _TrackPainter old) => old.color != color;
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  _ArcPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final rect = Rect.fromLTWH(10, 10, size.width - 20, size.height - 20);

    // Glow
    canvas.drawArc(
      rect,
      -math.pi / 2,
      progress * 2 * math.pi,
      false,
      Paint()
        ..color = color.withAlpha(80)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 26
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Arc principal
    canvas.drawArc(
      rect,
      -math.pi / 2,
      progress * 2 * math.pi,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) =>
      old.progress != progress || old.color != color;
}
