// lib/widgets/profile_card.dart

import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String? profilePictureUrl;
  final String userName;
  final String userRole;
  final String? tier;
  final int? completionPercent;
  final VoidCallback? onViewProfile;
  final VoidCallback? onProfilePictureTap;

  const ProfileCard({
    super.key,
    this.profilePictureUrl,
    required this.userName,
    required this.userRole,
    this.tier,
    this.completionPercent,
    required this.onViewProfile,
    this.onProfilePictureTap,
  });

  Color _getTierColor() {
    if (tier == null) return Colors.grey;
    
    switch (tier!.toLowerCase()) {
      case 'platinum':
        return const Color(0xFFE5E4E2);
      case 'gold':
        return const Color(0xFFD4AF37);
      case 'silver':
        return const Color(0xFFC0C0C0);
      case 'bronze':
        return const Color(0xFFCD7F32);
      default:
        return Colors.grey;
    }
  }

  List<Widget> _buildTierStars() {
    if (tier == null) return [];
    
    int starCount;
    switch (tier!.toLowerCase()) {
      case 'platinum':
        starCount = 5;
        break;
      case 'gold':
        starCount = 4;
        break;
      case 'silver':
        starCount = 3;
        break;
      case 'bronze':
        starCount = 2;
        break;
      default:
        starCount = 1;
    }
    
    return List.generate(
      starCount,
      (index) => Icon(
        Icons.star,
        color: _getTierColor(),
        size: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cs.primaryContainer.withOpacity(0.3),
              cs.secondaryContainer.withOpacity(0.2),
            ],
          ),
        ),
        child: Row(
          children: [
            // Profile Picture (80x80)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: cs.primary,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: cs.primary.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: onProfilePictureTap,
                child: CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: profilePictureUrl != null && profilePictureUrl!.isNotEmpty
                      ? NetworkImage(profilePictureUrl!)
                      : null,
                  child: profilePictureUrl == null || profilePictureUrl!.isEmpty
                      ? Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey.shade600,
                        )
                      : null,
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Role + Tier
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: cs.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          userRole,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      
                      if (tier != null) ...[
                        const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: _buildTierStars(),
                        ),
                      ],
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Completion Progress (if available)
                  if (completionPercent != null) ...[
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: completionPercent! / 100,
                              minHeight: 6,
                              backgroundColor: isDark 
                                  ? Colors.grey.shade800 
                                  : Colors.grey.shade300,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                completionPercent! >= 80
                                    ? Colors.green
                                    : completionPercent! >= 50
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$completionPercent%',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Profile completion',
                      style: TextStyle(
                        fontSize: 10,
                        color: cs.onSurfaceVariant.withOpacity(0.7),
                      ),
                    ),
                  ],
                  
                  // View Profile Button
                  if (onViewProfile != null) ...[
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: onViewProfile,
                      icon: const Icon(Icons.visibility, size: 14),
                      label: const Text(
                        'View Profile',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}