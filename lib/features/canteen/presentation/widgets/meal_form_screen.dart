import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/utils/permission_helper.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/menu_item.dart';
import '../../data/providers/canteen_repository_provider.dart';

class MealFormScreen extends ConsumerStatefulWidget {
  final MenuItem? editingMeal;

  const MealFormScreen({super.key, this.editingMeal});

  @override
  ConsumerState<MealFormScreen> createState() => _MealFormScreenState();
}

class _MealFormScreenState extends ConsumerState<MealFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _ingredientController = TextEditingController();

  final List<String> _ingredients = [];
  String _selectedCategory = 'Main Course';
  File? _selectedImage;
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();

  final List<String> _categories = [
    'Main Course',
    'Soup',
    'Salad',
    'Dessert',
    'Beverage',
    'Snack',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.editingMeal != null) {
      _nameController.text = widget.editingMeal!.name;
      _priceController.text = widget.editingMeal!.price.toString();
      _caloriesController.text = widget.editingMeal!.calories.toString();
      _descriptionController.text = widget.editingMeal!.description ?? '';
      _quantityController.text =
          widget.editingMeal!.quantityAvailable.toString();
      _ingredients.addAll(widget.editingMeal!.ingredients);
      _selectedDate = widget.editingMeal!.availableDate;
      if (widget.editingMeal!.tags.isNotEmpty) {
        _selectedCategory = widget.editingMeal!.tags.first;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _caloriesController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _ingredientController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final result = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (result == null || !mounted) return;

    try {
      bool hasPermission = false;
      if (result == ImageSource.camera) {
        hasPermission = await PermissionHelper.requestCameraPermission(context);
      } else {
        hasPermission = await PermissionHelper.requestPhotosPermission(context);
      }
      
      if (!hasPermission) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permission denied. Cannot access camera/photos.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Text(result == ImageSource.camera ? 'Opening camera...' : 'Opening gallery...'),
              ],
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      
      final image = await picker.pickImage(
        source: result,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      ).catchError((error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to open ${result == ImageSource.camera ? "camera" : "gallery"}: $error'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return null;
      });
      
      if (image != null && mounted) {
        setState(() {
          _selectedImage = File(image.path);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image selected successfully!'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _addIngredient() {
    if (_ingredientController.text.trim().isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text.trim());
        _ingredientController.clear();
      });
    }
  }

  Future<void> _selectDate() async {
    try {
      final now = DateTime.now();
      final firstDate = DateTime(now.year, now.month, now.day);
      final lastDate = firstDate.add(const Duration(days: 30));

      DateTime initialDate = _selectedDate;
      if (initialDate.isBefore(firstDate)) {
        initialDate = firstDate;
      } else if (initialDate.isAfter(lastDate)) {
        initialDate = lastDate;
      }

      final picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        helpText: 'Select Available Date',
      );

      if (picked != null && mounted) {
        setState(() {
          _selectedDate = picked;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening date picker: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  Future<void> _saveMeal() async {
    if (!_formKey.currentState!.validate()) return;
    if (_ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one ingredient')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dataSource = ref.read(canteenFirestoreDataSourceProvider);

      final mealId = widget.editingMeal?.id ?? const Uuid().v4();

      String imageUrl = widget.editingMeal?.imageUrl ?? '';
      if (_selectedImage != null) {
        imageUrl = 'https://via.placeholder.com/400x300?text=Meal+Image';
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image selected but not uploaded (Storage not enabled)'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }

      final quantity = int.parse(_quantityController.text);
      final meal = MenuItem(
        id: mealId,
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text),
        calories: int.parse(_caloriesController.text),
        tags: [_selectedCategory],
        description: _descriptionController.text.trim(),
        imageUrl: imageUrl,
        availableDate: _selectedDate,
        ingredients: _ingredients,
        quantityAvailable: quantity,
        isAvailable: quantity > 0,
      );

      if (widget.editingMeal == null) {
        await dataSource.addMenuItem(meal);
      } else {
        await dataSource.updateMenuItem(meal);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.editingMeal == null
                  ? 'Meal added successfully'
                  : 'Meal updated successfully',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteMeal() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Meal'),
        content: const Text('Are you sure you want to delete this meal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.editingMeal != null) {
      setState(() => _isLoading = true);
      try {
        final dataSource = ref.read(canteenFirestoreDataSourceProvider);

        await dataSource.deleteMenuItem(widget.editingMeal!.id);

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Meal deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingMeal == null ? 'Add Meal' : 'Edit Meal'),
        actions: [
          if (widget.editingMeal != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _isLoading ? null : _deleteMeal,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GestureDetector(
              onTap: _isLoading ? null : _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                  ),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_selectedImage!, fit: BoxFit.cover),
                      )
                    : widget.editingMeal?.imageUrl?.isNotEmpty == true
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.editingMeal!.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 64,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to add photo',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
              ),
            ),
            const SizedBox(height: 24),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Meal Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value?.trim().isEmpty == true ? 'Required' : null,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price (UZS)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.trim().isEmpty == true) return 'Required';
                      if (double.tryParse(value!) == null) return 'Invalid';
                      return null;
                    },
                    enabled: !_isLoading,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _caloriesController,
                    decoration: const InputDecoration(
                      labelText: 'Calories',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.trim().isEmpty == true) return 'Required';
                      if (int.tryParse(value!) == null) return 'Invalid';
                      return null;
                    },
                    enabled: !_isLoading,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat));
                    }).toList(),
                    onChanged: _isLoading
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => _selectedCategory = value);
                            }
                          },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.trim().isEmpty == true) return 'Required';
                      if (int.tryParse(value!) == null) return 'Invalid';
                      return null;
                    },
                    enabled: !_isLoading,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Available Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: TextEditingController(text: _selectedDate.formattedDateLong),
              onTap: _isLoading ? null : _selectDate,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 24),

            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientController,
                    decoration: const InputDecoration(
                      hintText: 'Add ingredient',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addIngredient(),
                    enabled: !_isLoading,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: _isLoading ? null : _addIngredient,
                  iconSize: 32,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_ingredients.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _ingredients.asMap().entries.map((entry) {
                  return Chip(
                    label: Text(entry.value),
                    onDeleted: _isLoading ? null : () => _removeIngredient(entry.key),
                  );
                }).toList(),
              ),
            const SizedBox(height: 32),

            AppButton(
              text: widget.editingMeal == null ? 'Add Meal' : 'Save Changes',
              onPressed: _isLoading ? null : _saveMeal,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
