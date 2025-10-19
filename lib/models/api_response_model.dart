class InstagramAnalysisResponse {
  final List<AnalyzedImage> analyzedImages;
  final CostSummary costSummary;
  final CoverageGaps coverageGaps;
  final CurrentPlan currentPlan;
  final int imagesAnalyzed;
  final LifestyleAnalysis lifestyleAnalysis;
  final ProfileInfo profileInfo;
  final Recommendations recommendations;
  final bool success;
  final String timestamp;
  final String username;
  final List<String> whatIfScenarios;

  InstagramAnalysisResponse({
    required this.analyzedImages,
    required this.costSummary,
    required this.coverageGaps,
    required this.currentPlan,
    required this.imagesAnalyzed,
    required this.lifestyleAnalysis,
    required this.profileInfo,
    required this.recommendations,
    required this.success,
    required this.timestamp,
    required this.username,
    required this.whatIfScenarios,
  });

  factory InstagramAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return InstagramAnalysisResponse(
      analyzedImages: (json['analyzed_images'] as List)
          .map((i) => AnalyzedImage.fromJson(i))
          .toList(),
      costSummary: CostSummary.fromJson(json['cost_summary']),
      coverageGaps: CoverageGaps.fromJson(json['coverage_gaps']),
      currentPlan: CurrentPlan.fromJson(json['current_plan']),
      imagesAnalyzed: json['images_analyzed'],
      lifestyleAnalysis: LifestyleAnalysis.fromJson(json['lifestyle_analysis']),
      profileInfo: ProfileInfo.fromJson(json['profile_info']),
      recommendations: Recommendations.fromJson(json['recommendations']),
      success: json['success'],
      timestamp: json['timestamp'],
      username: json['username'],
      whatIfScenarios: List<String>.from(json['what_if_scenarios'] ?? []),
    );
  }
}

class AnalyzedImage {
  final int likes;
  final String postUrl;
  final List<String> tags;
  final String url;

  AnalyzedImage({
    required this.likes,
    required this.postUrl,
    required this.tags,
    required this.url,
  });

  factory AnalyzedImage.fromJson(Map<String, dynamic> json) {
    return AnalyzedImage(
      likes: json['likes'],
      postUrl: json['post_url'],
      tags: List<String>.from(json['tags']),
      url: json['url'],
    );
  }
}

class CostSummary {
  final String currentMonthly;
  final String recommendedAnnual;
  final String recommendedMonthly;
  final String valueProp;

  CostSummary({
    required this.currentMonthly,
    required this.recommendedAnnual,
    required this.recommendedMonthly,
    required this.valueProp,
  });

  factory CostSummary.fromJson(Map<String, dynamic> json) {
    return CostSummary(
      currentMonthly: json['current_monthly'],
      recommendedAnnual: json['recommended_annual'],
      recommendedMonthly: json['recommended_monthly'],
      valueProp: json['value_prop'],
    );
  }
}

class CoverageGaps {
  final List<String> basePlanCovers;
  final List<BasePlanMissing> basePlanMissing;
  final String gapMessage;

  CoverageGaps({
    required this.basePlanCovers,
    required this.basePlanMissing,
    required this.gapMessage,
  });

  factory CoverageGaps.fromJson(Map<String, dynamic> json) {
    return CoverageGaps(
      basePlanCovers: List<String>.from(json['base_plan_covers']),
      basePlanMissing: (json['base_plan_missing'] as List)
          .map((i) => BasePlanMissing.fromJson(i))
          .toList(),
      gapMessage: json['gap_message'],
    );
  }
}

class BasePlanMissing {
  final String monthlyCost;
  final String name;
  final String reason;

  BasePlanMissing({
    required this.monthlyCost,
    required this.name,
    required this.reason,
  });

  factory BasePlanMissing.fromJson(Map<String, dynamic> json) {
    return BasePlanMissing(
      monthlyCost: json['monthly_cost'],
      name: json['name'],
      reason: json['reason'],
    );
  }
}

class CurrentPlan {
  final String coverageLevel;
  final String description;
  final List<Included> included;
  final String monthlyCost;
  final String name;

  CurrentPlan({
    required this.coverageLevel,
    required this.description,
    required this.included,
    required this.monthlyCost,
    required this.name,
  });

  factory CurrentPlan.fromJson(Map<String, dynamic> json) {
    return CurrentPlan(
      coverageLevel: json['coverage_level'],
      description: json['description'],
      included: (json['included'] as List)
          .map((i) => Included.fromJson(i))
          .toList(),
      monthlyCost: json['monthly_cost'],
      name: json['name'],
    );
  }
}

class Included {
  final String coverage;
  final String icon;
  final String name;
  final String summary;
  final String whySelected;

  Included({
    required this.coverage,
    required this.icon,
    required this.name,
    required this.summary,
    required this.whySelected,
  });

  factory Included.fromJson(Map<String, dynamic> json) {
    return Included(
      coverage: json['coverage'],
      icon: json['icon'],
      name: json['name'],
      summary: json['summary'],
      whySelected: json['why_selected'],
    );
  }
}

class LifestyleAnalysis {
  final List<String> demographics;
  final List<String> detectedActivities;
  final List<String> healthIndicators;
  final List<String> riskIndicators;

  LifestyleAnalysis({
    required this.demographics,
    required this.detectedActivities,
    required this.healthIndicators,
    required this.riskIndicators,
  });

  factory LifestyleAnalysis.fromJson(Map<String, dynamic> json) {
    return LifestyleAnalysis(
      demographics: List<String>.from(json['demographics'] ?? []),
      detectedActivities: List<String>.from(json['detected_activities'] ?? []),
      healthIndicators: List<String>.from(json['health_indicators'] ?? []),
      riskIndicators: List<String>.from(json['risk_indicators'] ?? []),
    );
  }
}

class ProfileInfo {
  final int followers;
  final bool isPrivate;
  final bool isVerified;
  final int postsCount;
  final String username;

  ProfileInfo({
    required this.followers,
    required this.isPrivate,
    required this.isVerified,
    required this.postsCount,
    required this.username,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) {
    return ProfileInfo(
      followers: json['followers'],
      isPrivate: json['is_private'],
      isVerified: json['is_verified'],
      postsCount: json['posts_count'],
      username: json['username'],
    );
  }
}

class Recommendations {
  final List<CriticalGap> criticalGaps;
  final List<CriticalGap> lifestyleUpgrades;
  final List<CriticalGap> preventativeCare;
  final String summary;

  Recommendations({
    required this.criticalGaps,
    required this.lifestyleUpgrades,
    required this.preventativeCare,
    required this.summary,
  });

  factory Recommendations.fromJson(Map<String, dynamic> json) {
    return Recommendations(
      criticalGaps: (json['critical_gaps'] as List)
          .map((i) => CriticalGap.fromJson(i))
          .toList(),
      lifestyleUpgrades: (json['lifestyle_upgrades'] as List)
          .map((i) => CriticalGap.fromJson(i))
          .toList(),
      preventativeCare: (json['preventative_care'] as List)
          .map((i) => CriticalGap.fromJson(i))
          .toList(),
      summary: json['summary'],
    );
  }
}

class CriticalGap {
  final String benefitId;
  final String coverage;
  final String gap;
  final String monthlyCost;
  final String name;
  final String priority;
  final String reason;
  final String whatIf;

  CriticalGap({
    required this.benefitId,
    required this.coverage,
    required this.gap,
    required this.monthlyCost,
    required this.name,
    required this.priority,
    required this.reason,
    required this.whatIf,
  });

  factory CriticalGap.fromJson(Map<String, dynamic> json) {
    return CriticalGap(
      benefitId: json['benefit_id'],
      coverage: json['coverage'],
      gap: json['gap'],
      monthlyCost: json['monthly_cost'],
      name: json['name'],
      priority: json['priority'],
      reason: json['reason'],
      whatIf: json['what_if'],
    );
  }
}
