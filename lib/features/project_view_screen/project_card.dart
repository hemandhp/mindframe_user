import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/feature_card.dart';

class ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final int daysToGo;
  final int totalDays; // Total duration of the project
  final String? category; // Optional category text
  final bool needCollab; // Optional: Whether to show "Need Collab" text
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.daysToGo,
    required this.totalDays,
    this.category,
    this.needCollab = false, // Default to false
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (totalDays - daysToGo) / totalDays;
    int progressPercentage = (progress * 100).round(); // Calculate percentage

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:
              BorderRadius.circular(12), // Optional: Add rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12)), // Match container's border radius
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  // Subtitle
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.grey[400], fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Progress Bar and Funded Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        backgroundColor: Colors.grey[800],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      const SizedBox(height: 8),
                      // Days to Go and Funded Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$daysToGo days to go',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey[400]),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '$progressPercentage% funded', // Display percentage
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Collaborator Button (Optional)
                    ],
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FeatureCard(icon: Icons.currency_rupee, text: "Rupees"),
                      FeatureCard(icon: Icons.location_city, text: "address"),
                      FeatureCard(icon: Icons.people, text: "user"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
