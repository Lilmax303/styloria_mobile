// lib/widgets/service_type_selector.dart
// Multi-select chip widget for selecting services during certification upload

import 'package:flutter/material.dart';

class ServiceTypeSelector extends StatefulWidget {
  final List<String> serviceTypes;
  final List<String> selectedServices;
  final Function(List<String>) onSelectionChanged;
  final String? Function(String)? getServiceLabel;

  const ServiceTypeSelector({
    super.key,
    required this.serviceTypes,
    required this.selectedServices,
    required this.onSelectionChanged,
    this.getServiceLabel,
  });

  @override
  State<ServiceTypeSelector> createState() => _ServiceTypeSelectorState();
}

class _ServiceTypeSelectorState extends State<ServiceTypeSelector> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedServices);
  }

  String _getLabel(String serviceId) {
    if (widget.getServiceLabel != null) {
      return widget.getServiceLabel!(serviceId) ?? serviceId;
    }
    
    final labels = {
      'haircut': 'Haircut',
      'braids': 'Braids',
      'shave': 'Shave',
      'color': 'Hair Coloring',
      'manicure': 'Manicure',
      'pedicure': 'Pedicure',
      'nails': 'Nail Art',
      'makeup': 'Makeup',
      'facial': 'Facial',
      'waxing': 'Waxing',
      'massage': 'Massage',
      'tattoo': 'Tattoo',
      'styling': 'Hair Styling',
      'treatment': 'Hair Treatment',
      'extensions': 'Hair Extensions',
      'other': 'Other',
    };
    return labels[serviceId] ?? serviceId;
  }

  void _toggleService(String serviceId) {
    setState(() {
      if (_selected.contains(serviceId)) {
        _selected.remove(serviceId);
      } else {
        _selected.add(serviceId);
      }
    });
    widget.onSelectionChanged(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Which services does this certification qualify for?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select all services that this certification covers. You can select multiple.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.serviceTypes.map((serviceId) {
            final isSelected = _selected.contains(serviceId);
            
            return FilterChip(
              label: Text(_getLabel(serviceId)),
              selected: isSelected,
              onSelected: (_) => _toggleService(serviceId),
              selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
              checkmarkColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey.shade700,
              ),
              side: BorderSide(
                color: isSelected 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            );
          }).toList(),
        ),
        
        if (_selected.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${_selected.length} service${_selected.length > 1 ? 's' : ''} selected',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        
        if (_selected.isEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'No services selected. This certification won\'t unlock any services.',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ==============================================================================
// USAGE EXAMPLE
// ==============================================================================

/*
// In your certifications_section.dart or provider_profile_screen.dart:

class _CertificationUploadDialog extends StatefulWidget {
  final List<String> serviceTypes;
  
  // ...
}

class _CertificationUploadDialogState extends State<_CertificationUploadDialog> {
  List<String> _selectedServices = [];
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Certification'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Certification Name',
                hintText: 'e.g., Licensed Massage Therapist',
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Organization field
            TextField(
              controller: _orgController,
              decoration: const InputDecoration(
                labelText: 'Issuing Organization',
                hintText: 'e.g., State Board',
              ),
            ),
            
            const SizedBox(height: 24),
            
            // SERVICE SELECTOR (NEW!)
            ServiceTypeSelector(
              serviceTypes: widget.serviceTypes,
              selectedServices: _selectedServices,
              onSelectionChanged: (selected) {
                setState(() {
                  _selectedServices = selected;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Document upload button
            // ...
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Upload'),
        ),
      ],
    );
  }
  
  Future<void> _submit() async {
    // Validate
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter certification name')),
      );
      return;
    }
    
    // Prepare data
    final certData = {
      'name': _nameController.text,
      'issuing_organization': _orgController.text,
      'certified_service_types': _selectedServices,  // ← NEW!
      // ... other fields
    };
    
    // Upload via API
    try {
      final response = await _uploadCertification(certData);
      if (response.statusCode == 201) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Certification uploaded successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }
}

*/