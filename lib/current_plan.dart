import 'package:flutter/material.dart';
import 'models/user_plan_model.dart';

class CurrentPlanScreen extends StatelessWidget {
  final UserCurrentPlan? currentPlan;
  final List<RecommendedBenefit>? recommendations;

  const CurrentPlanScreen({super.key, this.currentPlan, this.recommendations});

  @override
  Widget build(BuildContext context) {
    final plan = currentPlan ?? UserCurrentPlan.basicStarterPackage();
    final recs = recommendations ?? [];

    // Calculate total costs
    double totalRecommendedCost = 0;
    for (var rec in recs) {
      // Extract min cost (e.g., "$12-18" -> 12)
      final match = RegExp(r'\$(\d+)').firstMatch(rec.monthlyCost);
      if (match != null) {
        totalRecommendedCost += double.parse(match.group(1)!);
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      appBar: AppBar(
        title: const Text(
          'Your Benefits Plan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF7A9B76),
        automaticallyImplyLeading: false, // Remove default back button
        // No leading widget - no back button
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Plan Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF7A9B76),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.shield, color: Colors.white, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              plan.monthlyCost,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Current Coverage:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...plan.included.map(
                    (benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Text(
                            benefit.icon,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              benefit.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Missing Coverage Section
            if (recs.isNotEmpty) ...[
              const Text(
                '📋 Recommended Add-ons',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Based on your lifestyle analysis',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),

              ...recs.map((rec) => _buildRecommendationCard(rec, context)),

              const SizedBox(height: 24),

              // Cost Summary
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Current Plan:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          plan.monthlyCost,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recommended Add-ons:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '\$${totalRecommendedCost.toInt()}-\$${(totalRecommendedCost * 1.5).toInt()}/month',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7A9B76),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total with Add-ons:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${totalRecommendedCost.toInt()}-\$${(totalRecommendedCost * 1.5).toInt()}/month',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7A9B76),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'That\'s about \$${(totalRecommendedCost / 30).toStringAsFixed(2)}/day for comprehensive protection',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(
    RecommendedBenefit rec,
    BuildContext context,
  ) {
    Color priorityColor = rec.priority == 'high'
        ? Colors.red[100]!
        : rec.priority == 'medium'
        ? Colors.orange[100]!
        : Colors.green[100]!;

    Color priorityBorder = rec.priority == 'high'
        ? Colors.red[300]!
        : rec.priority == 'medium'
        ? Colors.orange[300]!
        : Colors.green[300]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: priorityBorder, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with priority badge
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rec.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rec.monthlyCost + '/month',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7A9B76),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    rec.priority.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: priorityBorder,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 20,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        rec.reason,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 20,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        rec.coverage,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Text('⚠️', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          rec.whatIf,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red[900],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
