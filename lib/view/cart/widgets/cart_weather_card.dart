import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/themes/colors.dart';
import '../../../res/models/weather_model.dart';
import '../provider/cart_weather_provider.dart';

class CartWeatherCard extends ConsumerWidget {
  const CartWeatherCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(cartWeatherProvider);
    final textTheme = Theme.of(context).textTheme;

    return weatherAsync.when(
      loading: () => _WeatherCardShell(
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.main,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (_, _) => _WeatherCardShell(
        child: Row(
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              color: AppColors.grey,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Weather unavailable',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.grey),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => ref.invalidate(cartWeatherProvider),
              child: Text(
                'Retry',
                style: textTheme.labelSmall?.copyWith(color: AppColors.main),
              ),
            ),
          ],
        ),
      ),
      data: (weather) => _WeatherCardContent(weather: weather),
    );
  }
}

// ── Shell ──────────────────────────────────────────────────────────────────────

class _WeatherCardShell extends StatelessWidget {
  const _WeatherCardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.main.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.greyBorder),
      ),
      child: child,
    );
  }
}

// ── Content ────────────────────────────────────────────────────────────────────

class _WeatherCardContent extends StatelessWidget {
  const _WeatherCardContent({required this.weather});

  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1565C0), AppColors.main],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.main.withValues(alpha: 0.30),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Icon + description ─────────────────────────────────────────
          Image.network(
            weather.iconUrl,
            width: 52,
            height: 52,
            errorBuilder: (_, _, _) => const Icon(
              Icons.wb_cloudy_rounded,
              color: AppColors.white,
              size: 40,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${weather.cityName}, ${weather.country}',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  _capitalize(weather.description),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.80),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // ── Temp + details ─────────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${weather.temp.round()}°C',
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(
                    Icons.water_drop_outlined,
                    size: 11,
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${weather.humidity}%',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.85),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.air_rounded,
                    size: 11,
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${weather.windSpeed} m/s',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.85),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
