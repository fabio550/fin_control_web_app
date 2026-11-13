import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  const SidebarButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.selected = false,
    this.indented = false,
    this.trailing,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;
  final bool indented;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => ListTile(
    selected: selected,
    selectedTileColor: const Color(0xFFEFF6FF),
    selectedColor: const Color(0xFF1D4ED8),
    shape: const Border(),
    contentPadding: EdgeInsets.only(left: indented ? 44 : 28, right: 20),
    leading: Icon(icon, size: 21),
    title: Text(label, style: const TextStyle(fontSize: 13)),
    trailing: trailing,
    onTap: onTap,
  );
}
