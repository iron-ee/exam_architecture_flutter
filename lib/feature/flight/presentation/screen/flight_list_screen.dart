import 'package:exam_architecture_iron/core/constants/airport_data.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/bloc/flight_bloc.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/bloc/flight_event.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/bloc/flight_state.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/widget/flight_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FlightListScreen extends StatefulWidget {
  const FlightListScreen({super.key});

  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  final _flightIdController = TextEditingController();
  String? _selectedFromTime;
  String? _selectedToTime;
  String? _selectedAirportCode;
  String? _selectedAirlineCode;

  final List<String> _fromTimeOptions = List.generate(24, (index) {
    final hour = index.toString().padLeft(2, '0');
    return '$hour:00';
  });

  final List<String> _toTimeOptions = List.generate(24, (index) {
    final hour = index.toString().padLeft(2, '0');
    return '$hour:59';
  });

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final currentHour = now.hour;
    _selectedFromTime = '${currentHour.toString().padLeft(2, '0')}:00';
    _selectedToTime = '${(currentHour % 24).toString().padLeft(2, '0')}:59';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onSearchButtonPressed();
    });
  }

  @override
  void dispose() {
    _flightIdController.dispose();
    super.dispose();
  }

  // 검색 동작 메서드
  void _onSearchButtonPressed() {
    context.read<FlightBloc>().add(
      GetFlightDeparturesEvent(
        fromTime: _selectedFromTime?.replaceFirst(':', ''),
        toTime: _selectedToTime?.replaceFirst(':', ''),
        airport: _selectedAirportCode,
        airline: _selectedAirlineCode,
        flightId:
            _flightIdController.text.isEmpty ? null : _flightIdController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '인천공항 출발 현황',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildFilterSection(),
            const Divider(height: 1),
            _buildFlightList(),
          ],
        ),
      ),
    );
  }

  // 필터 / 검색 섹션
  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('출발 시간', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // 출발 시간 선택
          Row(
            children: [
              Expanded(
                child: _buildTimeDropdown(
                  value: _selectedFromTime,
                  items: _fromTimeOptions,
                  onChanged:
                      (value) => setState(() => _selectedFromTime = value),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('~'),
              ),
              Expanded(
                child: _buildTimeDropdown(
                  value: _selectedToTime,
                  items: _toTimeOptions,
                  onChanged: (value) => setState(() => _selectedToTime = value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 목적지, 항공사 선택
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  value: _selectedAirportCode,
                  labelText: '목적지 선택',
                  items:
                      airportCodes.entries
                          .map(
                            (entry) => DropdownMenuItem(
                              value: entry.key,
                              child: Text(
                                '${entry.value} (${entry.key})',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) => setState(() => _selectedAirportCode = value),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown(
                  value: _selectedAirlineCode,
                  labelText: '항공사 선택',
                  items:
                      airlineCodes.entries
                          .map(
                            (entry) => DropdownMenuItem(
                              value: entry.key,
                              child: Text(
                                '${entry.value} (${entry.key})',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) => setState(() => _selectedAirlineCode = value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // 편명 입력 텍스트 필드, 검색 버튼
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _flightIdController,
                  decoration: InputDecoration(
                    labelText: '편명 입력',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: _onSearchButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '검색',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 출발 시간 드랍 다운 버튼
  Widget _buildTimeDropdown({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      items:
          items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
      onChanged: onChanged,
    );
  }

  // 목적지, 항공사 선택 드랍 다운 버튼
  Widget _buildDropdown({
    required String? value,
    required String labelText,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
  }) {
    final allItems = [
      DropdownMenuItem<String>(
        value: null,
        child: Text('전체', style: TextStyle(color: Colors.grey[700])),
      ),
      ...items,
    ];

    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      items: allItems,
      onChanged: onChanged,
    );
  }

  // 출발 정보 카드 리스트
  Widget _buildFlightList() {
    return BlocConsumer<FlightBloc, FlightState>(
      listener: (context, state) {
        if (state is FlightError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is FlightLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is FlightLoaded) {
          if (state.flights.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Center(child: Text('검색 결과가 없습니다.')),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.flights.length,
            itemBuilder: (context, index) {
              final flight = state.flights[index];
              return FlightListItem(
                flight: flight,
                onTap: () {
                  GoRouter.of(context).goNamed('flight_detail', extra: flight);
                },
              );
            },
          );
        } else if (state is FlightError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Center(child: Text(state.message)),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(child: Text('필터를 설정하고 검색하세요.')),
          );
        }
      },
    );
  }
}
