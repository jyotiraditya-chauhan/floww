import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:floww/config/constants/app_sizes.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.greeting,
    required this.userName,
    required this.streakCount,
    this.avatarUrl,
  });

  final String greeting;
  final String userName;
  final int streakCount;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting,',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colors.backgroundPrimary,
                ),
              ),
              Text(
                userName,
                style: context.textTheme.displaySmall?.copyWith(
                  color: context.colors.backgroundPrimary,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: AppSpacing.lg),
        _StreakBadge(count: streakCount),
        SizedBox(width: AppSpacing.md),
        _UserAvatar(avatarUrl: avatarUrl),
      ],
    );
  }
}

class _StreakBadge extends StatelessWidget {
  const _StreakBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: AppSizes.s40,
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_fire_department,
                color: context.colors.accentOrange,
                size: AppSizes.s20,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                '$count',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.backgroundPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.s40,
      width: AppSizes.s40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.backgroundPrimary.withValues(alpha: 0.35),
        border: Border.all(
          color: context.colors.textPrimary.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: avatarUrl == null
            ? Icon(
                Icons.person,
                color: context.colors.textPrimary,
                size: AppSizes.s24,
              )
            : Image.network(
                avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.person,
                  color: context.colors.textPrimary,
                  size: AppSizes.s24,
                ),
              ),
      ),
    );
  }
}
