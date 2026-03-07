import 'package:flutter/material.dart';

/// Represents the 6 resource types in Terraforming Mars base game
enum ResourceType {
  megacredits(
    name: 'Megacredits',
    shortName: 'M€',
    icon: Icons.monetization_on,
    color: Color(0xFFFFD700),
    description: 'Main currency for cards and projects',
  ),
  steel(
    name: 'Steel',
    shortName: 'STEEL',
    icon: Icons.build,
    color: Color(0xFF8B4513),
    description: 'Worth 2 M€ for building tags',
  ),
  titanium(
    name: 'Titanium',
    shortName: 'TITANIUM',
    icon: Icons.diamond,
    color: Color(0xFF708090),
    description: 'Worth 3 M€ for space tags',
  ),
  plants(
    name: 'Plants',
    shortName: 'PLANTS',
    icon: Icons.grass,
    color: Color(0xFF228B22),
    description: '8 plants = 1 greenery tile',
  ),
  energy(
    name: 'Energy',
    shortName: 'ENERGY',
    icon: Icons.bolt,
    color: Color(0xFF9C27B0), // Purple
    description: 'Converts to heat at generation end',
  ),
  heat(
    name: 'Heat',
    shortName: 'HEAT',
    icon: Icons.whatshot,
    color: Color(0xFFFF4500),
    description: '8 heat = raise temperature',
  );

  final String name;
  final String shortName;
  final IconData icon;
  final Color color;
  final String description;

  const ResourceType({
    required this.name,
    required this.shortName,
    required this.icon,
    required this.color,
    required this.description,
  });
}
