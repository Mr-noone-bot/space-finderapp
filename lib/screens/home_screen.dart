import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vit_spacefinder/providers/space_provider.dart';
import 'package:vit_spacefinder/screens/upload_slot_screen.dart';
import 'package:vit_spacefinder/widgets/animated_background.dart';
import 'package:vit_spacefinder/widgets/block_selector.dart';
import 'package:vit_spacefinder/widgets/classroom_list.dart';
import 'package:vit_spacefinder/widgets/floor_selector.dart';
import 'package:vit_spacefinder/widgets/time_slot_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedDay = 'Monday';

  @override
  Widget build(BuildContext context) {
    final spaceProvider = Provider.of<SpaceProvider>(context);
    final selectedTimeSlot = spaceProvider.selectedTimeSlot;
    final availableClassrooms = spaceProvider.getAvailableClassrooms();

    // Filter time slots for the selected day
    final dayTimeSlots = spaceProvider.timeSlots
        .where((slot) => slot.day == _selectedDay)
        .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('VIT SpaceFinder'),
        backgroundColor: Colors.white.withOpacity(0.85),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadSlotScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.upload),
              label: const Text('Upload Slot'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: AnimatedBackground()),
          SafeArea(
            top: true,
            bottom: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 1500),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          'Select Block',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const BlockSelector(),
                      const SizedBox(height: 16),
                      // Floor Selector
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          'Select Floor',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const FloorSelector(),
                      const SizedBox(height: 16),
                      // Day of the Week Selector
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          'Day of the Week',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          'Monday',
                          'Tuesday',
                          'Wednesday',
                          'Thursday',
                          'Friday'
                        ].map((day) {
                          final isSelected = _selectedDay == day;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(day),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  _selectedDay = day;
                                  spaceProvider.setSelectedTimeSlot('');
                                });
                              },
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      // Time Slot Selector
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          'Select Time Slot',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          itemCount: dayTimeSlots.length,
                          itemBuilder: (context, index) {
                            final timeSlot = dayTimeSlots[index];
                            final isSelected = timeSlot.id == selectedTimeSlot;
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                child: InkWell(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    spaceProvider
                                        .setSelectedTimeSlot(timeSlot.id);
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 140,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primaryContainer
                                          : Theme.of(context)
                                              .colorScheme
                                              .surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(0.2),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: AnimatedDefaultTextStyle(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                        ),
                                        child: Text(timeSlot.displayName),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Available Classrooms
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          selectedTimeSlot.isEmpty
                              ? 'Select a time slot to see available classrooms'
                              : 'Available Classrooms',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Classroom List
                      SizedBox(
                        height: 300,
                        child: selectedTimeSlot.isEmpty
                            ? const Center(
                                child: Text(
                                  'No time slot selected',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : availableClassrooms.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No available classrooms for this time slot',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : ClassroomList(
                                    classrooms: availableClassrooms),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
