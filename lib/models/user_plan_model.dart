class UserCurrentPlan {
  final String name;
  final String coverageLevel;
  final String monthlyCost;
  final List<PlanBenefit> included;
  final List<String> notIncluded;

  UserCurrentPlan({
    required this.name,
    required this.coverageLevel,
    required this.monthlyCost,
    required this.included,
    required this.notIncluded,
  });

  // Default "Basic Starter Package" that most employees have
  factory UserCurrentPlan.basicStarterPackage() {
    return UserCurrentPlan(
      name: 'Basic Starter Package',
      coverageLevel: 'Basic',
      monthlyCost: '\$0 (employer-paid)',
      included: [
        PlanBenefit(
          id: 'std',
          name: 'Short-Term Disability',
          summary:
              'Weekly cash benefits if you can\'t work due to injury, illness, or childbirth',
          coverage: 'Partial income replacement after elimination period',
          icon: '🏥',
        ),
        PlanBenefit(
          id: 'ltd',
          name: 'Long-Term Disability',
          summary:
              'Monthly cash benefits for extended absences from serious illness or injury',
          coverage: 'Income protection during long recoveries',
          icon: '🛡️',
        ),
        PlanBenefit(
          id: 'eap',
          name: 'EmployeeConnect Program (EAP)',
          summary: '24/7 confidential counseling and life resources',
          coverage: 'Up to 5 in-person sessions per issue per year',
          icon: '💬',
        ),
        PlanBenefit(
          id: 'life_add',
          name: 'Life & AD&D Insurance',
          summary:
              'Financial protection for loved ones in case of death or severe injury',
          coverage: '1x annual salary lump sum benefit',
          icon: '💰',
        ),
      ],
      notIncluded: [
        'Dental Insurance',
        'Vision Insurance',
        'Accident Insurance',
        'Critical Illness Insurance',
        'Hospital Indemnity Insurance',
      ],
    );
  }

  // Convert to format needed for LLM chat
  Map<String, dynamic> toLLMFormat() {
    return {
      'name': name,
      'coverage_level': coverageLevel,
      'monthly_cost': monthlyCost,
      'included': included
          .map((b) => {'name': b.name, 'summary': b.summary})
          .toList(),
    };
  }
}

class PlanBenefit {
  final String id;
  final String name;
  final String summary;
  final String coverage;
  final String icon;

  PlanBenefit({
    required this.id,
    required this.name,
    required this.summary,
    required this.coverage,
    required this.icon,
  });
}

// Recommended add-ons based on lifestyle analysis
class RecommendedBenefit {
  final String benefitId;
  final String name;
  final String reason;
  final String monthlyCost;
  final String coverage;
  final String priority; // 'high', 'medium', 'low'
  final String whatIf;

  RecommendedBenefit({
    required this.benefitId,
    required this.name,
    required this.reason,
    required this.monthlyCost,
    required this.coverage,
    required this.priority,
    required this.whatIf,
  });

  // Example: Generate recommendations based on traits
  static List<RecommendedBenefit> fromTraits(Set<String> traits) {
    List<RecommendedBenefit> recommendations = [];

    // Check for vision-related traits
    if (traits.any(
      (t) =>
          t.toLowerCase().contains('glass') ||
          t.toLowerCase().contains('vision') ||
          t.toLowerCase().contains('screen') ||
          t.toLowerCase().contains('digital'),
    )) {
      recommendations.add(
        RecommendedBenefit(
          benefitId: 'vision',
          name: 'Vision Insurance',
          reason: 'You wear glasses and spend hours on screens daily',
          monthlyCost: '\$12-18',
          coverage: 'Annual eye exam, \$130 eyewear allowance, lens upgrades',
          priority: 'high',
          whatIf:
              'What if you break your glasses or need new prescription? \$300-500 out of pocket.',
        ),
      );
    }

    // Check for dental needs
    recommendations.add(
      RecommendedBenefit(
        benefitId: 'dental',
        name: 'Dental Insurance',
        reason: 'Regular cleanings prevent expensive problems',
        monthlyCost: '\$35-55',
        coverage: 'Cleanings, fillings, major procedures + reward programs',
        priority: 'high',
        whatIf:
            'What if you need a root canal? \$1,500 out of pocket without insurance.',
      ),
    );

    // Check for active lifestyle/sports
    if (traits.any(
      (t) =>
          t.toLowerCase().contains('sport') ||
          t.toLowerCase().contains('active') ||
          t.toLowerCase().contains('skating') ||
          t.toLowerCase().contains('exercise'),
    )) {
      recommendations.add(
        RecommendedBenefit(
          benefitId: 'accident',
          name: 'Accident Insurance',
          reason: 'Your active lifestyle increases injury risk',
          monthlyCost: '\$20-35',
          coverage: 'Cash benefits for covered accidents, ER visits, fractures',
          priority: 'medium',
          whatIf:
              'What if you break a bone playing sports? Medical bills add up fast.',
        ),
      );
    }

    // Check for stress/health indicators
    if (traits.any(
      (t) =>
          t.toLowerCase().contains('stress') ||
          t.toLowerCase().contains('health') ||
          t.toLowerCase().contains('condition'),
    )) {
      recommendations.add(
        RecommendedBenefit(
          benefitId: 'critical_illness',
          name: 'Critical Illness Insurance',
          reason: 'Risk of serious illness increases with age and stress',
          monthlyCost: '\$25-45',
          coverage: 'Lump sum cash payment for covered diagnosis',
          priority: 'medium',
          whatIf:
              'What if you\'re diagnosed with cancer? Medical bills average \$150K+.',
        ),
      );
    }

    // Check for commuting/car
    if (traits.any(
      (t) =>
          t.toLowerCase().contains('car') ||
          t.toLowerCase().contains('commut') ||
          t.toLowerCase().contains('accident'),
    )) {
      recommendations.add(
        RecommendedBenefit(
          benefitId: 'hospital_indemnity',
          name: 'Hospital Indemnity Insurance',
          reason: 'Commuting and lifestyle increase hospitalization risk',
          monthlyCost: '\$25-35',
          coverage: 'Cash for hospital admission, ICU stays, rehab',
          priority: 'medium',
          whatIf:
              'What if a car accident puts you in the hospital? Bills add up fast.',
        ),
      );
    }

    return recommendations;
  }
}
