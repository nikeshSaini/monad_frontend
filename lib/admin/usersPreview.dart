import 'package:flutter/material.dart';

import 'adminExpensePreview.dart';
import 'adminattendancePreview.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  // Dummy list of users
  final List<String> users = ['John Doe', 'Jane Smith', 'Alice Johnson', 'Bob Brown'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee's Data"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Employee List',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              DataTable(
                columns: [
                  DataColumn(label: Text('S.No')),
                  DataColumn(label: Text('Employee Name')),
                  DataColumn(label: Text('Action')),
                ],
                rows: List.generate(
                  users.length,
                      (index) => DataRow(
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(users[index])),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.schedule),
                            onPressed: () {
                              // Navigate to check attendance page
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminAttendancePreview()));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.attach_money),
                            onPressed: () {
                              // Navigate to check expenses page  AdminExpensePreview
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminExpensePreview(
                                      // Pass some dummy expense data for demonstration
                                        expenses: [
                                          Expense(
                                            date: DateTime.now(),
                                            location: 'City A',
                                            lodgingAmount: 100.0,
                                            localTravel: 1200.33,
                                            intercitytravel: 132.3,
                                            mealAmount: 50.0,
                                            othersAmount: 30.0,
                                            description: 'Some descridssssssd;mal;cvansl;f ,vbnakl; nvesdl;hveos;hveos;hgseovbsdl;vnwek;gjb ption',
                                          ),
                                          Expense(
                                            date: DateTime.now(),
                                            location: 'City b',
                                            lodgingAmount: 23100.0,
                                            localTravel: 1200.33,
                                            intercitytravel: 132.3,
                                            mealAmount: 503.0,
                                            othersAmount: 302.0,
                                            description: 'Some description',
                                          )
                                        ])),
                              );
                            },
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
