import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_appbar.dart';

class AboutNeuroCheckPro extends StatelessWidget {
  const AboutNeuroCheckPro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'About NeuroCheck Pro'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About NeuroCheck Pro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'NeuroCheckPro is a self-assessment app designed to help individuals explore whether they may have traits associated with neurodivergent conditions such as Autism or ADHD. Developed with care and based on behavioral science, the app offers structured, step-by-step assessments to promote early awareness and understanding of cognitive and behavioral patterns.',
              style:  TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'Our goal is to empower users with insight and clarity while offering guidance toward professional support when necessary. NeuroCheckPro is not intended to diagnose or replace clinical evaluation, but rather to serve as a trusted companion in your mental health journey. Whether for yourself or someone you support, we’re here to help you take the first step with confidence',
              style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 4),

            const SizedBox(height: 16),
            // Duplicated text blocks (as per the image)

          ],
        ),
      ),
    );
  }
}
