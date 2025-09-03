import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/modules/billing_info/models/billing_info_model.dart';

class TransactionDetailBottomSheet extends StatelessWidget {
  final BillingInfoModel item;

  const TransactionDetailBottomSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.7,
        minChildSize: 0.3,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Share Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      "Transaction Details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Image.asset('assets/images/share.png',height: 25,width: 25,)
                  ],
                ),
                const SizedBox(height: 24),
                // Child name & Title
                _buildDetailRow("Child name", item.patient!.name, "Title", item.assessment!.name),
                 Divider(height: 32, color: AppColors.dividerColor,),
                // Type of Assessment & Paid Amount
                _buildDetailRow("Type of Assessment", item.assessment!.category, "Paid Amount", item.amount),
                const Divider(height: 32),
                // Transaction Time & ID
                _buildDetailRow("Transaction Time", item.createdAt, "Transaction ID", item.sessionId),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title1, String value1, String title2, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                value1,
                style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                value2,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
