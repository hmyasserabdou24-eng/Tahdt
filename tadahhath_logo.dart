import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Renders the official TADAHHATH AI brand mark and wordmark.
///
/// Supports both the high-resolution extracted brand sheet asset (`app_icon.png`)
/// and a precision vector CustomPainter fallback matching the speech-bubble
/// neural circuit crest and split 'T' emblem.
class TadahhathLogo extends StatelessWidget {
  const TadahhathLogo({
    super.key,
    this.size = 72,
    this.showWordmark = true,
    this.isMonochrome = false,
  });

  final double size;
  final bool showWordmark;
  final bool isMonochrome;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color wordmarkPrimary = isMonochrome
        ? (isDark ? Colors.white : AppColors.primaryNavy)
        : (isDark ? Colors.white : AppColors.primaryNavy);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primaryNavy,
            borderRadius: BorderRadius.circular(size * 0.24),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.primaryNavy.withOpacity(0.22),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'app_icon.png',
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return CustomPaint(
                size: Size.square(size),
                painter: _TadahhathEmblemPainter(isMonochrome: isMonochrome),
              );
            },
          ),
        ),
        if (showWordmark) ...<Widget>[
          const SizedBox(height: 14),
          RichText(
            textDirection: TextDirection.ltr,
            text: TextSpan(
              style: TextStyle(
                fontSize: size * 0.34,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: wordmarkPrimary,
              ),
              children: const <InlineSpan>[
                TextSpan(text: 'TADAHHATH '),
                TextSpan(
                  text: 'AI',
                  style: TextStyle(color: AppColors.accentGold),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _TadahhathEmblemPainter extends CustomPainter {
  const _TadahhathEmblemPainter({required this.isMonochrome});

  final bool isMonochrome;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width * 0.34;

    final Paint goldPaint = Paint()
      ..color = isMonochrome ? Colors.white : AppColors.accentGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055
      ..strokeCap = StrokeCap.round;

    final Paint bluePaint = Paint()
      ..color = isMonochrome ? Colors.white70 : AppColors.secondaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055
      ..strokeCap = StrokeCap.round;

    // Left gold arc and right blue arc forming the speech-bubble ring
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      1.8,
      2.6,
      false,
      goldPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.2,
      2.6,
      false,
      bluePaint,
    );

    // Central T stem & crossbar
    final Paint tGoldFill = Paint()
      ..color = isMonochrome ? Colors.white : AppColors.accentGold
      ..style = PaintingStyle.fill;
    final Paint tWhiteFill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx - size.width * 0.08, center.dy - size.height * 0.12),
          width: size.width * 0.16,
          height: size.height * 0.07,
        ),
        const Radius.circular(3),
      ),
      tGoldFill,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx + size.width * 0.05, center.dy + size.height * 0.02),
          width: size.width * 0.08,
          height: size.height * 0.28,
        ),
        const Radius.circular(4),
      ),
      tWhiteFill,
    );
  }

  @override
  bool shouldRepaint(covariant _TadahhathEmblemPainter oldDelegate) {
    return oldDelegate.isMonochrome != isMonochrome;
  }
}
