// ignore_for_file: public_member_api_docs, inference_failure_on_function_return_type

import 'package:administrator/administrator.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/controller/create_staff_bloc.dart';
import 'package:utility/utility.dart';

class DCCreateStaffScreen2 extends StatefulWidget {
  @override
  _DCCreateStaffScreen2State createState() => _DCCreateStaffScreen2State();
}

class _DCCreateStaffScreen2State extends State<DCCreateStaffScreen2> {
  String selectedDayOfWeek = '';
  List<DynamicWidget> listDynamic = [];
  List<String> data = [];
  Icon floatingIcon = Icon(Icons.add);

  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<int> startPeriod = List.generate(17, (index) => index + 1);

  addDynamic() {
    if (data.isNotEmpty) {
      floatingIcon = Icon(Icons.add);
      data = [];
      listDynamic = [];
    }

    if (listDynamic.length >= 7) {
      return;
    }

    listDynamic.add(DynamicWidget(
      onDelete: () {
        // Remove the corresponding DynamicWidget
        setState(() {
          listDynamic.removeLast();
        });
      },
      daysOfWeek: daysOfWeek,
      startPeriod: startPeriod,
      endPeriod: startPeriod,
      onDayOfWeekSelected: (selectedDay) {
        setState(() {
          selectedDayOfWeek += selectedDay ?? '';
        });
      },
    ));
    setState(() {});
  }

  submitData() {
    floatingIcon = Icon(Icons.arrow_back);

    listDynamic.forEach((widget) {
      // Concatenate the selected day and periods and add to the data list
      data.add(
          "${widget.selectedDayOfWeek}: ${widget.selectedStartPeriod} to ${widget.selectedEndPeriod}");
    });

    setState(() {});
    print(data.length);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Column(children: [
      Card(
        child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: BlocBuilder<CreateStaffBloc, CreateStaffState>(
                  builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Full name: ${state.fullName}"),
                                  Text("Email: ${state.email}"),
                                  Text("Password: ${state.password}"),
                                  Text(
                                      "Birthday: ${state.birthday?.toString() ?? ''}"),
                                  Text("Phone Number: ${state.phone}"),
                                  Text("Role: ${state.role}"),
                                  if (state.role == 'Doctor')
                                    Text("Specialization: ${state.role}"),
                                ],
                              ),
                            Text("${index + 1} : ${data[index]}"),
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ),
    ]);

    final Widget dynamicTextField = ListView.builder(
      shrinkWrap: true,
      itemCount: listDynamic.length,
      itemBuilder: (_, index) => listDynamic[index],
    );

    final nextButton = Container(
      child: ElevatedButton(
        onPressed: submitData,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Next'),
        ),
      ),
    );

    Widget submitButton = Container(
      child: ElevatedButton(
        onPressed: () {
          context.read<CreateStaffBloc>().add(
                const CreateStaffButtonPressedEvent(),
              );
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Submit'),
        ),
      ),
    );

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              if (data.isEmpty) dynamicTextField else result,
              if (data.isEmpty) nextButton else submitButton,
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: addDynamic,
          child: floatingIcon,
        ),
      ],
    );
  }
}

class DynamicWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final VoidCallback onDelete;

  // Add three lists for dropdown items
  final List<String> daysOfWeek;
  final List<int> startPeriod;
  final List<int> endPeriod;
  final Function(String?) onDayOfWeekSelected;

  // Add fields to store the selected values
  String? selectedDayOfWeek;
  int? selectedStartPeriod;
  int? selectedEndPeriod;

  DynamicWidget({
    required this.onDelete,
    required this.daysOfWeek,
    required this.startPeriod,
    required this.endPeriod,
    required this.onDayOfWeekSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Dropdown for Day of Week
          DCDropdownButton<String>(
            borderRadius: 16,
            dropdownWidth: context.width,
            hintText: 'Day of Week',
            items: daysOfWeek,
            onItemSelected: (context, controller, selectedValue) {
              // Handle selection
              onDayOfWeekSelected(selectedValue);
              selectedDayOfWeek = selectedValue;
            },
          ),
          const SizedBox(height: 16),
          // Dropdown for Start Hour
          DCDropdownButton<int>(
            borderRadius: 16,
            dropdownWidth: context.width,
            hintText: 'Start Period',
            items: startPeriod,
            onItemSelected: (context, controller, selectedValue) {
              // Handle selection
              selectedStartPeriod = selectedValue;
            },
          ),
          const SizedBox(height: 16),
          // Dropdown for End Hour
          DCDropdownButton<int>(
            borderRadius: 16,
            dropdownWidth: context.width,
            hintText: 'End Period',
            items: endPeriod,
            onItemSelected: (context, controller, selectedValue) {
              // Handle selection
              selectedEndPeriod = selectedValue;
            },
          ),
          const SizedBox(height: 16),
          const Divider(
            height: 1,
            color: Colors.black, // Adjust the color of the line as needed
          ),
          // Delete button
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
