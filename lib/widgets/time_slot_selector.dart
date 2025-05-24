import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vit_spacefinder/models/time_slot.dart';
import 'package:vit_spacefinder/providers/space_provider.dart';

class TimeSlotSelector extends StatefulWidget {
  const TimeSlotSelector({super.key});

  @override
  State<TimeSlotSelector> createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  late String selectedDay;

  @override
  void initState() {
    super.initState();
    // Default to the first day in the list
    final spaceProvider = Provider.of<SpaceProvider>(context, listen: false);
    selectedDay = spaceProvider.timeSlots.first.day;
  }

  @override
  Widget build(BuildContext context) {
    final spaceProvider = Provider.of<SpaceProvider>(context);
    final selectedTimeSlot = spaceProvider.selectedTimeSlot;

    // Get unique days
    final days =
        spaceProvider.timeSlots.map((slot) => slot.day).toSet().toList();
    // Get time slots for the selected day
    final slots = spaceProvider.timeSlots
        .where((slot) => slot.day == selectedDay)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: days.map((day) {
            final isSelected = day == selectedDay;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(day),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    selectedDay = day;
                  });
                },
                selectedColor: Theme.of(context).colorScheme.primary,
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
        const SizedBox(height: 12),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: slots.length,
            itemBuilder: (context, index) {
              final timeSlot = slots[index];
              final isSelected = timeSlot.id == selectedTimeSlot;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      spaceProvider.setSelectedTimeSlot(timeSlot.id);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
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
                          duration: const Duration(milliseconds: 200),
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
      ],
    );
  }
}
