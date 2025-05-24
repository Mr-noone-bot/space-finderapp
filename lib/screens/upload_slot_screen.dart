import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vit_spacefinder/models/classroom.dart';
import 'package:vit_spacefinder/providers/space_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vit_spacefinder/widgets/animated_background.dart';

class UploadSlotScreen extends StatefulWidget {
  const UploadSlotScreen({super.key});

  @override
  State<UploadSlotScreen> createState() => _UploadSlotScreenState();
}

class _UploadSlotScreenState extends State<UploadSlotScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedBlock = 'SJT';
  String _selectedFloor = 'Ground Floor';
  String _selectedDay = 'Monday';
  String _selectedTimeSlot = '';
  String _classroomNumber = '';
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SpaceProvider>(context, listen: false);
      setState(() {
        _selectedBlock = provider.selectedBlock;
        _selectedFloor = provider.selectedFloor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final spaceProvider = Provider.of<SpaceProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Upload Free Slot'),
        backgroundColor: Colors.white.withOpacity(0.85),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: AnimatedBackground()),
          SafeArea(
            top: true,
            bottom: true,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 1500),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add a new free classroom slot',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Block Selection
                        const Text(
                          'Block',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedBlock,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          items: spaceProvider.blocks.map((block) {
                            return DropdownMenuItem<String>(
                              value: block,
                              child: Text(block),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedBlock = value;
                                _selectedFloor =
                                    spaceProvider.floors[value]![0];
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        // Floor Selection
                        const Text(
                          'Floor',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedFloor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          items: spaceProvider.floors[_selectedBlock]!
                              .map((floor) {
                            return DropdownMenuItem<String>(
                              value: floor,
                              child: Text(floor),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedFloor = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        // Classroom Number
                        const Text(
                          'Classroom Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: _getPlaceholderText(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a classroom number';
                            }

                            // Validate room number format based on floor
                            if (_selectedFloor == 'Ground Floor') {
                              if (!RegExp(r'^G\d{2}$').hasMatch(value)) {
                                return 'Ground floor rooms must be in format G01, G02, etc.';
                              }
                            } else {
                              // For other floors (1st, 2nd, etc.)
                              final floorNumber = _selectedFloor
                                  .split(' ')[0]
                                  .replaceAll(RegExp(r'[^\d]'), '');
                              if (!RegExp(r'^\d{3}$').hasMatch(value)) {
                                return 'Room number must be 3 digits (e.g., 101, 102)';
                              }
                              if (!value.startsWith(floorNumber)) {
                                return 'Room number must start with $floorNumber for ${_selectedFloor}';
                              }
                            }

                            // Check if room already exists
                            final existingClassrooms =
                                spaceProvider.getClassroomsByBlockAndFloor(
                              _selectedBlock,
                              _selectedFloor,
                            );

                            final existingClassroom = existingClassrooms
                                .where((c) =>
                                    c.name.toLowerCase() == value.toLowerCase())
                                .toList();

                            if (existingClassroom.isNotEmpty) {
                              return 'This room number already exists. Please choose a different one.';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _classroomNumber = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Day of the Week Selection
                        const Text(
                          'Day of the Week',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedDay,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          items: [
                            'Monday',
                            'Tuesday',
                            'Wednesday',
                            'Thursday',
                            'Friday'
                          ]
                              .map((day) => DropdownMenuItem<String>(
                                    value: day,
                                    child: Text(day),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedDay = value;
                                _selectedTimeSlot = '';
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        // Time Slot Selection
                        const Text(
                          'Time Slot',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedTimeSlot.isEmpty
                              ? null
                              : _selectedTimeSlot,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          items: spaceProvider.timeSlots
                              .where((slot) => slot.day == _selectedDay)
                              .map((slot) => DropdownMenuItem<String>(
                                    value: slot.id,
                                    child: Text(slot.displayName),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedTimeSlot = value;
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a time slot';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final spaceProvider = Provider.of<SpaceProvider>(context, listen: false);

      // Check if classroom already exists
      final existingClassrooms = spaceProvider.getClassroomsByBlockAndFloor(
          _selectedBlock, _selectedFloor);

      final existingClassroom = existingClassrooms
          .where((c) => c.name.toLowerCase() == _classroomNumber.toLowerCase())
          .toList();

      if (existingClassroom.isNotEmpty) {
        // Add time slot to existing classroom
        spaceProvider.addAvailableSlot(
            existingClassroom[0].id, _selectedTimeSlot);
      } else {
        // Create new classroom
        final newClassroom = Classroom(
          id: '${_selectedBlock.toLowerCase()}_${_classroomNumber.toLowerCase()}_${_uuid.v4().substring(0, 8)}',
          name: _classroomNumber,
          block: _selectedBlock,
          floor: _selectedFloor,
          availableSlots: [_selectedTimeSlot],
        );

        spaceProvider.addClassroom(newClassroom);
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Free slot added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to home screen
      Navigator.pop(context);
    }
  }

  String _getPlaceholderText() {
    if (_selectedFloor == 'Ground Floor') {
      return 'e.g. G01, G02';
    } else {
      final floorNumber =
          _selectedFloor.split(' ')[0].replaceAll(RegExp(r'[^\d]'), '');
      return 'e.g. ${floorNumber}01, ${floorNumber}02';
    }
  }
}
