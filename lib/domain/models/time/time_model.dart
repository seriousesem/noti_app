import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class TimeModel extends Equatable {
  const TimeModel({
    this.firstHour = '',
    this.secondHour = '',
    this.secondHourFocusNode,
    this.firstMinute = '',
    this.firstMinuteFocusNode,
    this.secondMinute = '',
    this.secondMinuteFocusNode,
  });

  final String firstHour;
  final String secondHour;
  final FocusNode? secondHourFocusNode;
  final String firstMinute;
  final FocusNode? firstMinuteFocusNode;
  final String secondMinute;
  final FocusNode? secondMinuteFocusNode;

  TimeModel copyWith({
    String? firstHour,
    String? secondHour,
    FocusNode? secondHourFocusNode,
    String? firstMinute,
    FocusNode? firstMinuteFocusNode,
    String? secondMinute,
    FocusNode? secondMinuteFocusNode,
  }) =>
      TimeModel(
        firstHour: firstHour ?? this.firstHour,
        secondHour: secondHour ?? this.secondHour,
        secondHourFocusNode: secondHourFocusNode ?? this.secondHourFocusNode,
        firstMinute: firstMinute ?? this.firstMinute,
        firstMinuteFocusNode: firstMinuteFocusNode ?? this.firstMinuteFocusNode,
        secondMinute: secondMinute ?? this.secondMinute,
        secondMinuteFocusNode:
            secondMinuteFocusNode ?? this.secondMinuteFocusNode,
      );

  @override
  List<Object?> get props => [
        firstHour,
        secondHour,
        secondHourFocusNode,
        firstMinute,
        firstMinuteFocusNode,
        secondMinute,
        secondMinuteFocusNode
      ];

  @override
  String toString() => '$firstHour$secondHour:$firstMinute$secondMinute';

  factory TimeModel.fromString(String time) {
    return TimeModel(
      firstHour: time.characters.elementAt(0),
      secondHour: time.characters.elementAt(1),
      firstMinute: time.characters.elementAt(3),
      secondMinute: time.characters.elementAt(4),
    );
  }
}
