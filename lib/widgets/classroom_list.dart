import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vit_spacefinder/models/classroom.dart';
import 'package:vit_spacefinder/providers/space_provider.dart';

class ClassroomList extends StatelessWidget {
  final List<Classroom> classrooms;

  const ClassroomList({
    super.key,
    required this.classrooms,
  });

  @override
  Widget build(BuildContext context) {
    final spaceProvider = Provider.of<SpaceProvider>(context);
    final selectedTimeSlot =
        spaceProvider.getTimeSlotById(spaceProvider.selectedTimeSlot);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: classrooms.length,
      itemBuilder: (context, index) {
        final classroom = classrooms[index];

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                // Add haptic feedback
                HapticFeedback.lightImpact();
              },
              borderRadius: BorderRadius.circular(12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  'Room ${classroom.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      '${classroom.block} - ${classroom.floor}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.meeting_room),
              ),
            ),
          ),
        );
      },
    );
  }
}
