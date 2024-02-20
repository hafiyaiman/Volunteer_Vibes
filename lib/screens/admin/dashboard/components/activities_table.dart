import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CombinedActivitiesTable extends StatelessWidget {
  final String userId;

  CombinedActivitiesTable({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('activities')
          .doc('PI8A2mCR56iMUYKvlBp5')
          .collection('by_organizations')
          .where('organizationId', isEqualTo: userId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> orgSnapshot) {
        if (!orgSnapshot.hasData) {
          return CircularProgressIndicator();
        }

        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('activities')
              .doc('PI8A2mCR56iMUYKvlBp5')
              .collection('emergency_response')
              .where('organizationId', isEqualTo: userId)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> emergencySnapshot) {
            if (!emergencySnapshot.hasData) {
              return CircularProgressIndicator();
            }

            // Combine the data from both collections
            List<QueryDocumentSnapshot> combinedData = [
              ...orgSnapshot.data!.docs,
              ...emergencySnapshot.data!.docs
            ];

            return DataTable(
              columns: [
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Start Date')),
                DataColumn(label: Text('Start Time')),
                DataColumn(label: Text('End Date')),
                DataColumn(label: Text('End Time')),
                // ... Add more columns as needed
              ],
              rows: combinedData.map((document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return DataRow(
                  cells: [
                    DataCell(Text(data['title'] ?? '')),
                    DataCell(
                      Text(
                        DateFormat('DD/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            data['start_date'].seconds * 1000,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(data['start_time']?.toString() ?? '')),
                    DataCell(
                      Text(
                        DateFormat('DD/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            data['end_date'].seconds * 1000,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(data['end_time']?.toString() ?? '')),

                    // ... Add more cells as needed
                  ],
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
