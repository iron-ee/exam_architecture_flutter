import 'package:exam_architecture_iron/core/utils/date_formatter.dart';
import 'package:exam_architecture_iron/feature/flight/domain/entity/flight_entity.dart';
import 'package:flutter/material.dart';

// 출발 정보 카드 아이템
class FlightListItem extends StatelessWidget {
  final FlightEntity flight;
  final VoidCallback onTap;

  const FlightListItem({super.key, required this.flight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  // 변경된 출발 시간
                  Text(
                    formatHHMM(flight.estimatedDateTime),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  // 기존 예정된 출발 시간
                  if (flight.scheduleDateTime != flight.estimatedDateTime)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        formatHHMM(flight.scheduleDateTime),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              // 운항편명 / 항공사
              Text(
                '${flight.flightId ?? '편명 없음'} / ${flight.airline ?? '항공사 정보 없음'}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              // 목적지, 터미널, 탑승구, 출발 현황 정보
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoColumn(
                    '목적지',
                    '${flight.airport ?? '정보 없음'} ${flight.airportCode != null ? '(${flight.airportCode})' : ''}',
                  ),
                  _buildInfoColumn('터미널', flight.terminalId?.displayName),
                  _buildInfoColumn('탑승구', flight.gatenumber),
                  _buildInfoColumn('출발 현황', flight.remark),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String? value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? '정보 없음',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
