import 'package:exam_architecture_iron/core/utils/date_formatter.dart';
import 'package:exam_architecture_iron/feature/flight/domain/entity/flight_entity.dart';
import 'package:flutter/material.dart';

class FlightDetailScreen extends StatelessWidget {
  final FlightEntity flight;

  const FlightDetailScreen({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('항공편 상세 정보')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '항공편 ID: ${flight.flightId ?? '정보 없음'}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(height: 24),
              _buildDetailRow('도착지', flight.airport),
              _buildDetailRow('항공사', flight.airline),
              _buildDetailRow('터미널', flight.terminalId?.displayName),
              _buildDetailRow('탑승 게이트', flight.gatenumber),
              _buildDetailRow('기존 탑승 시간', formatHHMM(flight.scheduleDateTime)),
              _buildDetailRow(
                '변경된 탑승 시간',
                formatHHMM(flight.estimatedDateTime),
              ),
              _buildDetailRow('출발현황', flight.remark),
              _buildDetailRow('운항 타입', flight.typeOfFlight?.displayName),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value ?? '정보 없음')),
        ],
      ),
    );
  }
}
