import 'package:flutter/material.dart';

class LocationChip extends StatelessWidget {
  const LocationChip({
    super.key,
    required this.location,
    this.inverse = false,
  });
  final bool inverse;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: inverse == true
            ? Colors.black.withOpacity(0.2)
            : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        location,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: inverse == true ? Colors.black : Colors.white,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
