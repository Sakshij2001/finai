import 'package:flutter/material.dart';
import 'current_plan.dart';
import 'models/api_response_model.dart';

class LifestyleScreen extends StatefulWidget {
  final InstagramAnalysisResponse analysisData;

  const LifestyleScreen({super.key, required this.analysisData});

  @override
  State<LifestyleScreen> createState() => _LifestyleScreenState();
}

class _LifestyleScreenState extends State<LifestyleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Set<String> _selectedActivities = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Pre-select health indicators and risk indicators
    _selectedActivities = {
      ...widget.analysisData.lifestyleAnalysis.healthIndicators,
      ...widget.analysisData.lifestyleAnalysis.riskIndicators,
    };
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleActivity(String activity) {
    setState(() {
      if (_selectedActivities.contains(activity)) {
        _selectedActivities.remove(activity);
      } else {
        _selectedActivities.add(activity);
      }
    });
  }

  void _generatePlan() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CurrentPlanScreen()),
    );
  }

  String _formatTag(String tag) {
    return tag
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final analysis = widget.analysisData.lifestyleAnalysis;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text('Lifestyle', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7A9B76),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: Column(
          children: [
            // Header with just back button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
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
                children: [
                  const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                  const SizedBox(height: 12),
                  Text(
                    widget.analysisData.recommendations.summary,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildInfoChip(
                        '${analysis.detectedActivities.length} Activities',
                        Icons.directions_run,
                      ),
                      _buildInfoChip(
                        '${analysis.healthIndicators.length} Health',
                        Icons.favorite,
                      ),
                      _buildInfoChip(
                        '${analysis.riskIndicators.length} Risks',
                        Icons.warning_amber,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF7A9B76),
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF7A9B76).withOpacity(0.1),
                ),
                tabs: const [
                  Tab(icon: Icon(Icons.list), text: 'All'),
                  Tab(icon: Icon(Icons.favorite), text: 'Health'),
                  Tab(icon: Icon(Icons.warning), text: 'Risks'),
                  Tab(icon: Icon(Icons.person), text: 'Others'),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildActivityList(analysis.detectedActivities),
                  _buildActivityList(analysis.healthIndicators),
                  _buildActivityList(analysis.riskIndicators),
                  _buildActivityList(analysis.demographics),
                ],
              ),
            ),

            // Bottom action button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '${_selectedActivities.length} traits selected',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _generatePlan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A9B76),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Generate Personalized Plan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
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

  Widget _buildInfoChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF7A9B76)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7A9B76),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList(List<String> activities) {
    if (activities.isEmpty) {
      return const Center(
        child: Text(
          'No activities detected in this category',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        final isSelected = _selectedActivities.contains(activity);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF7A9B76).withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF7A9B76) : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF7A9B76).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: ListTile(
            onTap: () => _toggleActivity(activity),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF7A9B76) : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconForActivity(activity),
                color: isSelected ? Colors.white : Colors.grey[600],
                size: 24,
              ),
            ),
            title: Text(
              _formatTag(activity),
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF7A9B76) : Colors.black87,
              ),
            ),
            trailing: isSelected
                ? const Icon(
                    Icons.check_circle,
                    color: Color(0xFF7A9B76),
                    size: 28,
                  )
                : Icon(
                    Icons.circle_outlined,
                    color: Colors.grey[400],
                    size: 28,
                  ),
          ),
        );
      },
    );
  }

  IconData _getIconForActivity(String activity) {
    if (activity.contains('exercise') || activity.contains('active')) {
      return Icons.fitness_center;
    } else if (activity.contains('health') || activity.contains('medical')) {
      return Icons.favorite;
    } else if (activity.contains('risk') || activity.contains('stress')) {
      return Icons.warning_amber;
    } else if (activity.contains('work') ||
        activity.contains('desk') ||
        activity.contains('office')) {
      return Icons.work;
    } else if (activity.contains('screen') || activity.contains('digital')) {
      return Icons.phone_android;
    } else if (activity.contains('glasses') || activity.contains('vision')) {
      return Icons.visibility;
    } else if (activity.contains('car') || activity.contains('commut')) {
      return Icons.directions_car;
    } else if (activity.contains('age')) {
      return Icons.cake;
    } else {
      return Icons.label;
    }
  }
}
