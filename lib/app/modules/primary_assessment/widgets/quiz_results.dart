// result_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'dart:math' as math;

class PrimaryQuizResultView extends StatelessWidget {
  final int score;

  const PrimaryQuizResultView({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Your Assessment Score",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: 102, // Adjust size as needed
              height: 100, // Adjust size as needed
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: CircularProgressPainter(
                      currentProgress: score,
                      totalValue: 10,
                      // Colors closely matching the image
                      backgroundColor: const Color(0x8c98c1e4), // Lighter, desaturated blue
                      progressGradientColors: const [
                        Color(0xFF3F6675),
                        Color(0xFF66B0CC),
                        Color(0x8066B0CC),
                      ],
                      strokeWidth:11.0,
                      // Define the gradient direction
                      gradientBegin: Alignment.topCenter,
                      gradientEnd: Alignment.centerLeft,
                      // Adjust thickness
                    ),
                    child: Container(), // Empty container as child for CustomPaint
                  ),
                  Text(
                    '$score/10',
                    style: const TextStyle(
                      color: Color(0xFF8F9BAD), // Dark grey for the text
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildResultBox(score),
            ),
            const SizedBox(height: 30),
            if (score > 5)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline, color: Colors.grey),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Score greater than 5 may have significant insights to share with our professional clinicians.",
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF104E59),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  minimumSize: const Size.fromHeight(55),
                ),
                onPressed: () {
                  if (score <= 5) {
                    // Navigate to Dashboard
                    Get.offAllNamed("/bottom_navigation_view");
                  } else {
                    // Navigate to full assessment
                    Get.toNamed("/fullAssessment");
                  }
                },
                child: Text(
                  score <= 5 ? "Return to Dashboard" : "Proceed to full assessment",
                  style: textButton_white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResultBox(int score) {
    if (score <= 5) {
      return Column(
        children:  [
          Text(
            "Great news!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Image.asset('assets/images/heart.png',height: 100,),
          SizedBox(height: 16),
          Text(
            "Your responses don’t indicate strong signs of neurodevelopmental concerns at this time.\n\nNo further assessment is needed, but we’re here if you ever need support.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      );
    } else {
      return Column(
        children: const [
          Text(
            "Thanks for completing the initial screening.",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            "Your responses suggest it may be helpful to explore things further. We recommend taking a full assessment for clearer insights.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      );
    }
  }
}
class CircularProgressPainter extends CustomPainter {
  final int currentProgress;
  final int totalValue;
  final Color backgroundColor;
  final List<Color> progressGradientColors; // Now a list of colors
  final double strokeWidth;
  final AlignmentGeometry gradientBegin; // Start point for the linear gradient
  final AlignmentGeometry gradientEnd;   // End point for the linear gradient

  CircularProgressPainter({
    required this.currentProgress,
    required this.totalValue,
    required this.backgroundColor,
    required this.progressGradientColors,
    required this.strokeWidth,
    this.gradientBegin = Alignment.centerLeft, // Default to left
    this.gradientEnd = Alignment.centerRight,   // Default to right
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2) - strokeWidth / 2;

    // The bounding box for the entire circle, used to define the area for the gradient shader
    Rect drawRect = Rect.fromCircle(center: center, radius: radius);

    // Create the LinearGradient shader and apply it to the progressPaint
    progressPaint.shader = LinearGradient(
      colors: progressGradientColors,
      begin: gradientBegin,
      end: gradientEnd,
    ).createShader(drawRect); // The shader will apply across the bounding box of the circle

    // Draw the background circle
    canvas.drawArc(
      drawRect,
      -math.pi / 2, // Start from top
      math.pi * 2,  // Full circle
      false,
      backgroundPaint,
    );

    // Calculate the sweep angle for the progress
    double progressAngle = (currentProgress / totalValue) * math.pi * 2;

    // Draw the progress arc with the applied gradient
    canvas.drawArc(
      drawRect,
      -math.pi / 2, // Start from top
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is CircularProgressPainter) {
      return oldDelegate.currentProgress != currentProgress ||
          oldDelegate.totalValue != totalValue ||
          oldDelegate.backgroundColor != backgroundColor ||
          oldDelegate.progressGradientColors != progressGradientColors ||
          oldDelegate.strokeWidth != strokeWidth ||
          oldDelegate.gradientBegin != gradientBegin ||
          oldDelegate.gradientEnd != gradientEnd;
    }
    return true;
  }
}
class ScoreCircle extends StatelessWidget {
  final int score;

  const ScoreCircle({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percentage = score / 10;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: percentage),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, _) {
        return SizedBox(
          height: 140,
          width: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
              ),
              CircularProgressIndicator(
                value: value,
                strokeWidth: 10,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  score > 5 ? const Color(0xFF104E59) : const Color(0xFFB4D9EF),
                ),
              ),
              Text(
                '$score/10',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
