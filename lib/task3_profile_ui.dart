import 'package:flutter/material.dart';

/// Task 3: static Profile / Dashboard screen (no state, hard-coded data).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Task 3 - Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- Header ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              color: scheme.primaryContainer,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    child: Icon(Icons.person, size: 56),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Jane Doe',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text('Flutter Developer'),
                ],
              ),
            ),

            // ---------- Stats ----------
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  _StatCard(label: 'Projects', value: '24'),
                  _StatCard(label: 'Followers', value: '1.2k'),
                  _StatCard(label: 'Following', value: '180'),
                ],
              ),
            ),

            // ---------- Contact info ----------
            const Card(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('jane.doe@example.com'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('+1 555 123 4567'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Dhaka, Bangladesh'),
                  ),
                ],
              ),
            ),

            // ---------- Dashboard tiles ----------
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: const [
                  _DashTile(Icons.task_alt, 'Tasks', Colors.orange),
                  _DashTile(Icons.message, 'Messages', Colors.teal),
                  _DashTile(Icons.bar_chart, 'Reports', Colors.purple),
                  _DashTile(Icons.settings, 'Settings', Colors.blueGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Text(
                value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashTile extends StatelessWidget {
  const _DashTile(this.icon, this.label, this.color);

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
