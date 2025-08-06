import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';

class AssessmentReport extends StatelessWidget {
  const AssessmentReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Report'),
        backgroundColor: const Color(0xFF0B4A55),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            child: Text("more",style: textButton_white,),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,

                builder: (BuildContext context) => CupertinoActionSheet(

                  title: const Text(
                    'Full assessment report',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  message: const Text('Choose the action you want to proceed.'),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        Get.snackbar("Download", "Downloading report...");
                      },
                      child: const Text('Download',style: textButton_blue,),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        Get.snackbar("Print", "Printing report...");
                      },
                      child: const Text('Print',style: textButton_blue,),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        Get.snackbar("Share", "Sharing report...");
                      },
                      child: const Text('Share',style: textButton_blue,),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        Get.snackbar("Feedback", "Opening feedback form...");
                      },
                      child: const Text('Feedback',style: textButton_blue,),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(context),
                    isDefaultAction: true,
                    child: const Text('Cancel',style: textButton_red,),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Full Assessment Report',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This report contains your full assessment results, reviewed and finalised by our clinical team. You can explore your scores, clinical notes, and recommended actions in detail',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'ADHD Diagnosis',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFFFE5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Completed',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Details
                    Row(
                      children: const [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Assessment date',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '25th July, 2025',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reviewed by',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Dr. Oliver Bernett',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // View Report button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B4A55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          // Handle view report action here
                        },
                        child: const Text(
                          'View Report',
                          style: textButton_white,
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
    );
  }
}
