import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewsArticleForm extends ConsumerStatefulWidget {
  const AddNewsArticleForm({super.key});

  @override
  ConsumerState<AddNewsArticleForm> createState() => _AddNewsArticleFormState();
}

class _AddNewsArticleFormState extends ConsumerState<AddNewsArticleForm> {
  // Controllers for the form fields , you can use or ignore [not mandatory]
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _writerController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String _selectedCategory = 'All'; // Default category
  final List<String> _categories = [
    'All',
    'Business',
    'Politics',
    'Technology',
    'Health',
    'Science'
  ];

  @override
  Widget build(BuildContext context) {
    return const Text("The form goes here");
  }
}
