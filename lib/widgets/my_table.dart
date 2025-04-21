import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tcm/blocs/sensor/sensor_alerts_cubit.dart';
import 'package:intl/intl.dart';

class MyTable extends StatefulWidget {
  final String idCapteur;

  const MyTable({super.key, required this.idCapteur});

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  bool _sortAscending = true;
  int? _sortColumnIndex;
  late MyDataTableSource _dataTableSource;

  @override
  void initState() {
    super.initState();
    _dataTableSource = MyDataTableSource(
      [],
    ); // Initialisation avec données vides
    context.read<SensorAlertsCubit>().fetchAlerts(widget.idCapteur);
  }

  void _updateDataSource(List<dynamic> newData) {
    if (!listEquals(_dataTableSource._rows, newData)) {
      _dataTableSource = MyDataTableSource(newData);
    }
  }

  void _sort<T>(
    Comparable<T> Function(Map<String, dynamic> d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dataTableSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SensorAlertsCubit, SensorAlertsState>(
      builder: (context, state) {
        if (state is SensorAlertsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SensorAlertsLoaded) {
          _updateDataSource(state.alerts);
          return PaginatedDataTable2(
            renderEmptyRowsInTheEnd: false,
            wrapInCard: false,
            dividerThickness: 0,
            sortAscending: _sortAscending,
            sortColumnIndex: _sortColumnIndex,
            border: TableBorder(
              horizontalInside: BorderSide(
                width: 1,
                color: Colors.grey.shade800,
              ),
              bottom: BorderSide(width: 1, color: Colors.grey.shade800),
            ),
            headingRowDecoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            columns: [
              const DataColumn2(label: Text('Alerte'), size: ColumnSize.L),
              DataColumn2(
                label: Text('Date'),
                size: ColumnSize.M,
                onSort: (columnIndex, ascending) {
                  _sort<DateTime>(
                    (row) => DateTime.parse(row['Date_alerte']),
                    columnIndex,
                    ascending,
                  );
                },
              ),
              DataColumn2(
                label: Text('Statut'),
                size: ColumnSize.S,
                onSort: (columnIndex, ascending) {
                  _sort<num>((row) => row['Active'], columnIndex, ascending);
                },
              ),
            ],
            source: _dataTableSource,
          );
        } else {
          return const Center();
        }
      },
    );
  }
}

class MyDataTableSource extends DataTableSource {
  // ignore: unused_field
  final List<dynamic> _rows;
  final List<dynamic> _sortedRows;

  MyDataTableSource(this._rows) : _sortedRows = List.from(_rows);
  void sort<T>(
    Comparable<T> Function(Map<String, dynamic> d) getField,
    bool ascending,
  ) {
    _sortedRows.sort((a, b) {
      final aVal = getField(a);
      final bVal = getField(b);
      return ascending
          ? Comparable.compare(aVal, bVal)
          : Comparable.compare(bVal, aVal);
    });
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    final row = _sortedRows[index];
    return DataRow(
      cells: [
        DataCell(Text(row['Type'] ?? 'Inconnue')),
        DataCell(
          Text(
            DateFormat(
              'dd/MM/yyyy',
            ).format(DateTime.parse((row['Date_alerte']))),
          ),
        ),
        DataCell(Text(row['Active'] == 1 ? "⛔️" : "✅")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _sortedRows.length;

  @override
  int get selectedRowCount => 0;
}
