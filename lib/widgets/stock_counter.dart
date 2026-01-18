import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class StockCounter extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;
  final bool large;

  const StockCounter({
    super.key,
    required this.value,
    this.minValue = 0,
    this.maxValue = 9999,
    required this.onChanged,
    this.large = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(large ? 8 : 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(large ? 20 : 12),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Decrease Button
          _buildCounterButton(
            icon: Icons.remove_rounded,
            onPressed: value > minValue ? () => _decreaseValue() : null,
          ),
          
          // Value Display
          SizedBox(
            width: large ? 100 : 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    '$value',
                    key: ValueKey(value),
                    style: TextStyle(
                      fontSize: large ? 36 : 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
                if (large) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Stock',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Increase Button
          _buildCounterButton(
            icon: Icons.add_rounded,
            onPressed: value < maxValue ? () => _increaseValue() : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    final size = large ? 56.0 : 36.0;
    final iconSize = large ? 28.0 : 20.0;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed != null ? () {
          HapticFeedback.lightImpact();
          onPressed();
        } : null,
        onLongPress: onPressed != null ? () {
          HapticFeedback.mediumImpact();
          _onLongPress(icon == Icons.add_rounded);
        } : null,
        borderRadius: BorderRadius.circular(large ? 16 : 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: onPressed != null
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryGreen, AppTheme.primaryGreenLight],
                  )
                : null,
            color: onPressed == null ? AppTheme.textSecondary.withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(large ? 16 : 10),
            boxShadow: onPressed != null
                ? [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: onPressed != null ? Colors.white : AppTheme.textSecondary,
            size: iconSize,
          ),
        ),
      ),
    );
  }

  void _increaseValue() {
    if (value < maxValue) {
      onChanged(value + 1);
    }
  }

  void _decreaseValue() {
    if (value > minValue) {
      onChanged(value - 1);
    }
  }

  void _onLongPress(bool increase) {
    final step = 10;
    if (increase) {
      final newValue = (value + step).clamp(minValue, maxValue);
      onChanged(newValue);
    } else {
      final newValue = (value - step).clamp(minValue, maxValue);
      onChanged(newValue);
    }
  }
}
