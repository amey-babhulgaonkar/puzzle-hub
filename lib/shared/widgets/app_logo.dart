import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double widthFactor;
  final bool glow;

  const AppLogo({
    super.key,
    this.widthFactor = 0.55,
    this.glow = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(
      'assets/branding/logo_full.png',
      width: MediaQuery.of(context).size.width * widthFactor,
    );

    if (!glow) return logo;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 80,
            spreadRadius: 10,
          ),
        ],
      ),
      child: logo,
    );
  }
}