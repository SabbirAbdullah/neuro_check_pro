import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';

import '../controllers/bill_info_controller.dart';
import '../models/billing_info_model.dart';
import '../widgets/transection_details.dart';

class BillingPage extends StatelessWidget {
   BillingPage({super.key});


final  BillingController controller = Get.put(BillingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Billing information'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Transaction History",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.billingList.length,
                itemBuilder: (context, index) {
                  final item = controller.billingList[index];
                  return buildTransactionItem(item);
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTransactionItem(BillingInfoModel item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "${item.patient!.name}",
                  style: const TextStyle(fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
    "${item.assessment!.name}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
    "${item.assessment!.category}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "TrxID: ${item.sessionId}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${item.amount}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,color: Color(0xff0A4863)
              ),
            ),
            const SizedBox(height: 8),
            Text(
    "${item.createdAt}",
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: Get.context!,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  builder: (_) => TransactionDetailBottomSheet(item: item),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF0B4A55),
                child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 18),
              ),
            ),

          ],
        ),
      ],
    );
  }
}


