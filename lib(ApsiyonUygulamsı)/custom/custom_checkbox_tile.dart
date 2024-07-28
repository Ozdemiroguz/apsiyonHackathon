import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckboxTile extends StatelessWidget {
  const CustomCheckboxTile({
    required this.label,
    required this.value,
    required this.onChanged,
    this.labelColor,
  });

  final String label;
  final Color? labelColor;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          LimitedBox(
            maxHeight: 16.h,
            maxWidth: 16.w,
            child: Checkbox(
            
              activeColor: Theme.of(context).primaryColor,
              onChanged: onChanged,
              value: value,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: labelColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCheckboxTileCircular extends StatelessWidget {
  const CustomCheckboxTileCircular({
    required this.label,
    required this.value,
    required this.onChanged,
    this.labelColor,
    this.size,
  });
  final String label;
  final Color? labelColor;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Container(
            height:size?.h ?? 16.h,
            width: size?.w ?? 16.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: value
                ? Icon(
                    Icons.check,
                    size: 12.w,
                    color: Theme.of(context).primaryColor,
                  )
                : null,

          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: labelColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
