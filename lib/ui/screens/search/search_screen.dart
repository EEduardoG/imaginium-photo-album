import 'package:flutter/material.dart';
import '../../widgets/tag_chip.dart';

/// Search screen for finding photos by tags, categories, or dates.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _suggestedTags = [
    'playa', 'perro', 'familia', 'viaje',
    'comida', 'atardecer', 'fiesta', 'montaña',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search by tags, category or date...',
            border: InputBorder.none,
          ),
          onChanged: (_) => setState(() {}),
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() {});
              },
            ),
        ],
      ),
      body: _controller.text.isEmpty ? _buildSuggestions() : _buildResults(),
    );
  }

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suggested tags',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: _suggestedTags.map((tag) {
              return TagChip(
                label: tag,
                onTap: () {
                  _controller.text = tag;
                  setState(() {});
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Searching for "${_controller.text}"…',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          const Text(
            'Results will appear here',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
