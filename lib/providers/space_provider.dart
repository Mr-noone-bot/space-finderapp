import 'package:flutter/material.dart';
import 'package:vit_spacefinder/models/classroom.dart';
import 'package:vit_spacefinder/models/time_slot.dart';

class SpaceProvider extends ChangeNotifier {
  // Selected values
  String _selectedBlock = 'SJT';
  String _selectedFloor = 'Ground Floor';
  String _selectedTimeSlot = '';

  // Getters
  String get selectedBlock => _selectedBlock;
  String get selectedFloor => _selectedFloor;
  String get selectedTimeSlot => _selectedTimeSlot;

  // Lists of available blocks, floors, and time slots
  final List<String> blocks = ['SJT', 'TT', 'PRP'];

  final Map<String, List<String>> floors = {
    'SJT': ['Ground Floor', '1st Floor', '2nd Floor', '3rd Floor', '4th Floor'],
    'TT': ['Ground Floor', '1st Floor', '2nd Floor', '3rd Floor'],
    'PRP': ['Ground Floor', '1st Floor', '2nd Floor'],
  };

  // Time slots
  final List<TimeSlot> timeSlots = [
    // Monday
    TimeSlot(
        id: 'mon_1',
        startTime: '08:00',
        endTime: '08:50',
        displayName: '8:00 AM - 8:50 AM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_2',
        startTime: '09:00',
        endTime: '09:50',
        displayName: '9:00 AM - 9:50 AM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_3',
        startTime: '10:00',
        endTime: '10:50',
        displayName: '10:00 AM - 10:50 AM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_4',
        startTime: '11:00',
        endTime: '11:50',
        displayName: '11:00 AM - 11:50 AM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_5',
        startTime: '13:00',
        endTime: '13:50',
        displayName: '1:00 PM - 1:50 PM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_6',
        startTime: '14:00',
        endTime: '14:50',
        displayName: '2:00 PM - 2:50 PM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_7',
        startTime: '15:00',
        endTime: '15:50',
        displayName: '3:00 PM - 3:50 PM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_8',
        startTime: '16:00',
        endTime: '16:50',
        displayName: '4:00 PM - 4:50 PM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_9',
        startTime: '17:00',
        endTime: '17:50',
        displayName: '5:00 PM - 5:50 PM',
        day: 'Monday'),
    TimeSlot(
        id: 'mon_10',
        startTime: '18:00',
        endTime: '18:50',
        displayName: '6:00 PM - 6:50 PM',
        day: 'Monday'),

    // Tuesday
    TimeSlot(
        id: 'tue_1',
        startTime: '08:00',
        endTime: '08:50',
        displayName: '8:00 AM - 8:50 AM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_2',
        startTime: '09:00',
        endTime: '09:50',
        displayName: '9:00 AM - 9:50 AM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_3',
        startTime: '10:00',
        endTime: '10:50',
        displayName: '10:00 AM - 10:50 AM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_4',
        startTime: '11:00',
        endTime: '11:50',
        displayName: '11:00 AM - 11:50 AM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_5',
        startTime: '13:00',
        endTime: '13:50',
        displayName: '1:00 PM - 1:50 PM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_6',
        startTime: '14:00',
        endTime: '14:50',
        displayName: '2:00 PM - 2:50 PM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_7',
        startTime: '15:00',
        endTime: '15:50',
        displayName: '3:00 PM - 3:50 PM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_8',
        startTime: '16:00',
        endTime: '16:50',
        displayName: '4:00 PM - 4:50 PM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_9',
        startTime: '17:00',
        endTime: '17:50',
        displayName: '5:00 PM - 5:50 PM',
        day: 'Tuesday'),
    TimeSlot(
        id: 'tue_10',
        startTime: '18:00',
        endTime: '18:50',
        displayName: '6:00 PM - 6:50 PM',
        day: 'Tuesday'),

    // Wednesday
    TimeSlot(
        id: 'wed_1',
        startTime: '08:00',
        endTime: '08:50',
        displayName: '8:00 AM - 8:50 AM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_2',
        startTime: '09:00',
        endTime: '09:50',
        displayName: '9:00 AM - 9:50 AM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_3',
        startTime: '10:00',
        endTime: '10:50',
        displayName: '10:00 AM - 10:50 AM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_4',
        startTime: '11:00',
        endTime: '11:50',
        displayName: '11:00 AM - 11:50 AM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_5',
        startTime: '13:00',
        endTime: '13:50',
        displayName: '1:00 PM - 1:50 PM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_6',
        startTime: '14:00',
        endTime: '14:50',
        displayName: '2:00 PM - 2:50 PM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_7',
        startTime: '15:00',
        endTime: '15:50',
        displayName: '3:00 PM - 3:50 PM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_8',
        startTime: '16:00',
        endTime: '16:50',
        displayName: '4:00 PM - 4:50 PM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_9',
        startTime: '17:00',
        endTime: '17:50',
        displayName: '5:00 PM - 5:50 PM',
        day: 'Wednesday'),
    TimeSlot(
        id: 'wed_10',
        startTime: '18:00',
        endTime: '18:50',
        displayName: '6:00 PM - 6:50 PM',
        day: 'Wednesday'),

    // Thursday
    TimeSlot(
        id: 'thu_1',
        startTime: '08:00',
        endTime: '08:50',
        displayName: '8:00 AM - 8:50 AM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_2',
        startTime: '09:00',
        endTime: '09:50',
        displayName: '9:00 AM - 9:50 AM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_3',
        startTime: '10:00',
        endTime: '10:50',
        displayName: '10:00 AM - 10:50 AM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_4',
        startTime: '11:00',
        endTime: '11:50',
        displayName: '11:00 AM - 11:50 AM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_5',
        startTime: '13:00',
        endTime: '13:50',
        displayName: '1:00 PM - 1:50 PM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_6',
        startTime: '14:00',
        endTime: '14:50',
        displayName: '2:00 PM - 2:50 PM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_7',
        startTime: '15:00',
        endTime: '15:50',
        displayName: '3:00 PM - 3:50 PM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_8',
        startTime: '16:00',
        endTime: '16:50',
        displayName: '4:00 PM - 4:50 PM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_9',
        startTime: '17:00',
        endTime: '17:50',
        displayName: '5:00 PM - 5:50 PM',
        day: 'Thursday'),
    TimeSlot(
        id: 'thu_10',
        startTime: '18:00',
        endTime: '18:50',
        displayName: '6:00 PM - 6:50 PM',
        day: 'Thursday'),

    // Friday
    TimeSlot(
        id: 'fri_1',
        startTime: '08:00',
        endTime: '08:50',
        displayName: '8:00 AM - 8:50 AM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_2',
        startTime: '09:00',
        endTime: '09:50',
        displayName: '9:00 AM - 9:50 AM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_3',
        startTime: '10:00',
        endTime: '10:50',
        displayName: '10:00 AM - 10:50 AM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_4',
        startTime: '11:00',
        endTime: '11:50',
        displayName: '11:00 AM - 11:50 AM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_5',
        startTime: '13:00',
        endTime: '13:50',
        displayName: '1:00 PM - 1:50 PM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_6',
        startTime: '14:00',
        endTime: '14:50',
        displayName: '2:00 PM - 2:50 PM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_7',
        startTime: '15:00',
        endTime: '15:50',
        displayName: '3:00 PM - 3:50 PM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_8',
        startTime: '16:00',
        endTime: '16:50',
        displayName: '4:00 PM - 4:50 PM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_9',
        startTime: '17:00',
        endTime: '17:50',
        displayName: '5:00 PM - 5:50 PM',
        day: 'Friday'),
    TimeSlot(
        id: 'fri_10',
        startTime: '18:00',
        endTime: '18:50',
        displayName: '6:00 PM - 6:50 PM',
        day: 'Friday'),
  ];

  // Mock data for classrooms
  List<Classroom> _classrooms = [];

  // Initialize with some mock data
  SpaceProvider() {
    _initializeClassrooms();
  }

  void _initializeClassrooms() {
    // SJT Ground Floor
    _classrooms.addAll([
      Classroom(
        id: 'sjt_g01',
        name: 'G01',
        block: 'SJT',
        floor: 'Ground Floor',
        availableSlots: ['mon_1', 'mon_2', 'mon_5', 'mon_8'],
      ),
      Classroom(
        id: 'sjt_g02',
        name: 'G02',
        block: 'SJT',
        floor: 'Ground Floor',
        availableSlots: ['mon_3', 'mon_4', 'mon_7', 'mon_9'],
      ),
      Classroom(
        id: 'sjt_g03',
        name: 'G03',
        block: 'SJT',
        floor: 'Ground Floor',
        availableSlots: ['mon_2', 'mon_6', 'mon_10'],
      ),
    ]);

    // SJT 1st Floor
    _classrooms.addAll([
      Classroom(
        id: 'sjt_101',
        name: '101',
        block: 'SJT',
        floor: '1st Floor',
        availableSlots: ['tue_1', 'tue_3', 'tue_5', 'tue_7'],
      ),
      Classroom(
        id: 'sjt_102',
        name: '102',
        block: 'SJT',
        floor: '1st Floor',
        availableSlots: ['tue_2', 'tue_4', 'tue_6', 'tue_8'],
      ),
      Classroom(
        id: 'sjt_103',
        name: '103',
        block: 'SJT',
        floor: '1st Floor',
        availableSlots: ['tue_1', 'tue_5', 'tue_9'],
      ),
    ]);

    // TT Ground Floor
    _classrooms.addAll([
      Classroom(
        id: 'tt_g01',
        name: 'G01',
        block: 'TT',
        floor: 'Ground Floor',
        availableSlots: ['wed_2', 'wed_4', 'wed_6', 'wed_8'],
      ),
      Classroom(
        id: 'tt_g02',
        name: 'G02',
        block: 'TT',
        floor: 'Ground Floor',
        availableSlots: ['wed_1', 'wed_3', 'wed_5', 'wed_7'],
      ),
    ]);

    // PRP Ground Floor
    _classrooms.addAll([
      Classroom(
        id: 'prp_g01',
        name: 'G01',
        block: 'PRP',
        floor: 'Ground Floor',
        availableSlots: ['thu_1', 'thu_4', 'thu_7', 'thu_10'],
      ),
      Classroom(
        id: 'prp_g02',
        name: 'G02',
        block: 'PRP',
        floor: 'Ground Floor',
        availableSlots: ['thu_2', 'thu_5', 'thu_8'],
      ),
    ]);
  }

  // Setters
  void setSelectedBlock(String block) {
    _selectedBlock = block;
    _selectedFloor =
        floors[block]![0]; // Reset to first floor of selected block
    notifyListeners();
  }

  void setSelectedFloor(String floor) {
    _selectedFloor = floor;
    notifyListeners();
  }

  void setSelectedTimeSlot(String timeSlotId) {
    _selectedTimeSlot = timeSlotId;
    notifyListeners();
  }

  // Get available classrooms based on selected block, floor, and time slot
  List<Classroom> getAvailableClassrooms() {
    if (_selectedTimeSlot.isEmpty) {
      return [];
    }
    // Only return classrooms that have the exact slot (day+time) in their availableSlots
    return _classrooms.where((classroom) {
      return classroom.block == _selectedBlock &&
          classroom.floor == _selectedFloor &&
          classroom.availableSlots.contains(_selectedTimeSlot);
    }).toList();
  }

  // Add a new available slot for a classroom
  void addAvailableSlot(String classroomId, String timeSlotId) {
    final index =
        _classrooms.indexWhere((classroom) => classroom.id == classroomId);
    if (index != -1) {
      final classroom = _classrooms[index];
      if (!classroom.availableSlots.contains(timeSlotId)) {
        final updatedSlots = List<String>.from(classroom.availableSlots)
          ..add(timeSlotId);
        _classrooms[index] = classroom.copyWith(availableSlots: updatedSlots);
        notifyListeners();
      }
    }
  }

  // Add a new classroom with available slots
  void addClassroom(Classroom classroom) {
    // Check if classroom already exists
    final existingIndex = _classrooms.indexWhere((c) => c.id == classroom.id);

    if (existingIndex != -1) {
      // Update existing classroom
      _classrooms[existingIndex] = classroom;
    } else {
      // Add new classroom
      _classrooms.add(classroom);
    }

    notifyListeners();
  }

  // Get time slot by ID
  TimeSlot? getTimeSlotById(String id) {
    try {
      return timeSlots.firstWhere((slot) => slot.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get all classrooms for a specific block and floor
  List<Classroom> getClassroomsByBlockAndFloor(String block, String floor) {
    return _classrooms
        .where(
            (classroom) => classroom.block == block && classroom.floor == floor)
        .toList();
  }
}
