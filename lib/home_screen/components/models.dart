import 'package:cloud_firestore/cloud_firestore.dart';

class EngineSessionModel {
  final String id;
  final String status;
  final DateTime? startTime;
  final DateTime? endTime;
  final double? combustionIn;
  final double? combustionOut;
  final double? exhaust;
  final double? turbine;
  final double? oilIn;
  final double? oilOut;
  final double? rpm;

  EngineSessionModel({
    required this.id,
    required this.status,
    this.startTime,
    this.endTime,
    this.combustionIn,
    this.combustionOut,
    this.exhaust,
    this.turbine,
    this.oilIn,
    this.oilOut,
    this.rpm,
  });

  factory EngineSessionModel.fromFirestore(
    Map<String, dynamic> data,
    String id,
  ) {
    return EngineSessionModel(
      id: id,
      status: data['status'] ?? '',
      startTime: (data['start_time'] as Timestamp?)?.toDate(),
      endTime: (data['end_time'] as Timestamp?)?.toDate(),
      combustionIn: (data['combustion_in'] as num?)?.toDouble(),
      combustionOut: (data['combustion_out'] as num?)?.toDouble(),
      exhaust: (data['exhaust'] as num?)?.toDouble(),
      turbine: (data['turbine'] as num?)?.toDouble(),
      oilIn: (data['oil_in'] as num?)?.toDouble(),
      oilOut: (data['oil_out'] as num?)?.toDouble(),
      rpm: (data['rpm'] as num?)?.toDouble(),
    );
  }
}
