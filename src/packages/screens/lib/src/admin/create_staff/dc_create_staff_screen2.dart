// ignore_for_file: public_member_api_docs, inference_failure_on_function_return_type

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/controller/create_staff_bloc.dart';

class DCCreateStaffScreen2 extends StatefulWidget {
  const DCCreateStaffScreen2({super.key});

  @override
  _DCCreateStaffScreen2State createState() => _DCCreateStaffScreen2State();
}

class _DCCreateStaffScreen2State extends State<DCCreateStaffScreen2> {
  String selectedDayOfWeek = '';
  final List<DynamicWidget> listDynamic = [];
  List<String> data = [];
  final Map<String, List<int>> dayOfWeek = {};
  Icon floatingIcon = Icon(Icons.add);
  bool atFirstPage = true;

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
      data = [];
      atFirstPage = !atFirstPage;
      floatingIcon = Icon(Icons.add);
    }

    if (listDynamic.length >= 7) {
      return;
    }

    if (atFirstPage) {
      listDynamic.add(DynamicWidget(
        index: listDynamic.length,
        onDelete: (index) {
          // Remove the corresponding DynamicWidget and its dayOfWeek entry by index
          setState(() {
            print('index removed: ${index}');
            listDynamic.removeAt(index);
            for (int i = 0; i < listDynamic.length; i++) {
              print(i);
              print(listDynamic[i].selectedDayOfWeek);
              listDynamic[i].index = i;
            }

            // Get the selected day at the given index
            String? removedDay = listDynamic[index].selectedDayOfWeek;

            if (removedDay != null) {
              dayOfWeek.remove(removedDay);
            }
          });
          print('REMOVE: ${dayOfWeek.length}');
          print(dayOfWeek);
          for (int i = 0; i < listDynamic.length; i++) {
            print(i);
            print(listDynamic[i].selectedDayOfWeek);
          }
        },
        daysOfWeek:
            daysOfWeek.where((day) => !dayOfWeek.containsKey(day)).toList(),
        startPeriod: startPeriod,
        endPeriod: startPeriod,
        onDayOfWeekSelected: (selectedDay) {
          setState(() {
            selectedDayOfWeek = selectedDay ?? '';
          });
          // Initialize with null values instead of dummy values
          dayOfWeek.putIfAbsent(selectedDay!, () => [-1, -1]);
          print(dayOfWeek);
        },
        onValuesSelected: () {
          // Update the startPeriod and endPeriod in the dayOfWeek map
          dayOfWeek[selectedDayOfWeek!]![0] =
              listDynamic.last.selectedStartPeriod!;
          dayOfWeek[selectedDayOfWeek!]![1] =
              listDynamic.last.selectedEndPeriod!;
          print('ADD: ${dayOfWeek.length}');
          print(dayOfWeek);
        },
      ));

      print('index: ${listDynamic.length - 1}');
    }
    setState(() {});
  }

  submitData() {
    atFirstPage = !atFirstPage;
    floatingIcon = Icon(Icons.arrow_back);

    // Create a list to store indices of widgets to be removed
    List<int> indicesToRemove = [];

    listDynamic.asMap().forEach((index, widget) {
      // Check if all values are not null and selectedStartPeriod and selectedEndPeriod are not dummy values
      if (widget.selectedDayOfWeek != null &&
          widget.selectedStartPeriod != null &&
          widget.selectedEndPeriod != null &&
          widget.selectedStartPeriod !=
              -1 && // Replace -1 with your dummy value for startPeriod
          widget.selectedEndPeriod != -1) {
        // Replace -1 with your dummy value for endPeriod
        // Concatenate the selected day and periods and add to the data list
        data.add(
            "${widget.selectedDayOfWeek}: ${widget.selectedStartPeriod} to ${widget.selectedEndPeriod}");
      } else {
        // Add the index of widgets to be removed
        indicesToRemove.add(index);
      }
    });

    // Remove widgets from listDynamic based on indicesToRemove
    indicesToRemove.forEach((index) {
      setState(() {
        listDynamic.removeAt(index);
      });
    });

    setState(() {
      // Trigger a rebuild of the widget tree
      print(data.length);
    });
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
                                    Text(
                                        "Specialization: ${state.specializationId}"),
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
        itemBuilder: (_, index) {
          for (int i = 0; i < listDynamic.length; i++) {
            print("Ngay ${i}");
            print("Selected day ${listDynamic[i].selectedDayOfWeek}");
            print("index ${listDynamic[i].index}");
            print("${listDynamic[i].daysOfWeek}");
          }
          return listDynamic[index];
        });

    Widget nextButton = Container(
      child: ElevatedButton(
        onPressed: (listDynamic.isNotEmpty)
            ? () {
                submitData();
                context.read<CreateStaffBloc>().add(
                      WorkingShiftInputEvent(dayOfWeek),
                    );
              }
            : null,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Next',
            selectionColor: Colors.black,
          ),
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
              if (atFirstPage) dynamicTextField else result,
              if (atFirstPage) nextButton else submitButton,
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            if (atFirstPage) {
              addDynamic();
            } else {
              setState(() {
                atFirstPage = true;
              });
            }
          },
          child: atFirstPage ? Icon(Icons.add) : Icon(Icons.arrow_back),
        ),
      ],
    );
  }
}

class DynamicWidget extends StatefulWidget {
  final Function(int) onDelete;
  final List<String> daysOfWeek;
  final List<int> startPeriod;
  final List<int> endPeriod;
  final Function(String?) onDayOfWeekSelected;
  final Function()? onValuesSelected;
  int index;

  String? selectedDayOfWeek;
  int? selectedStartPeriod = 1;
  int? selectedEndPeriod = 1;
  DynamicWidget({
    required this.index,
    required this.onDelete,
    required this.daysOfWeek,
    required this.startPeriod,
    required this.endPeriod,
    required this.onDayOfWeekSelected,
    this.onValuesSelected,
  });

  @override
  _DynamicWidgetState createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(widget.selectedDayOfWeek ?? ''),
          // Dropdown for Day of Week
          DCDropdownButton<String>(
            borderRadius: 16,
            dropdownWidth: context
                .width, // You may need to provide the context.width implementation
            hintText: 'Day of Week',
            items: widget.daysOfWeek,
            dropdownValue: widget.selectedDayOfWeek,
            onItemSelected: (context, controller, selectedValue) async {
              // Handle selection
              widget.onDayOfWeekSelected(selectedValue);
              setState(() {
                widget.selectedDayOfWeek = selectedValue;
                print("Select ${selectedValue}");
              });
              checkValuesSelected();
            },
          ),
          const SizedBox(height: 16),
          // Dropdown for Start Hour
          DCDropdownButton<int>(
            borderRadius: 16,
            dropdownWidth: context
                .width, // You may need to provide the context.width implementation
            hintText: 'Start Period',
            items: widget.startPeriod
                .where((value) =>
                    value < (widget.selectedEndPeriod ?? double.infinity))
                .toList(),
            onItemSelected: (context, controller, selectedValue) async {
              // Handle selection
              setState(() {
                widget.selectedStartPeriod = selectedValue;
                print("Select Start Period ${widget.selectedStartPeriod}");
              });
              checkValuesSelected();
            },
          ),
          const SizedBox(height: 16),
          // Dropdown for End Hour
          DCDropdownButton<int>(
            borderRadius: 16,
            dropdownWidth: context
                .width, // You may need to provide the context.width implementation
            hintText: 'End Period',
            items: widget.endPeriod
                .where((value) => value > (widget.selectedStartPeriod ?? 0))
                .toList(),
            onItemSelected: (context, controller, selectedValue) async {
              // Handle selection
              setState(() {
                widget.selectedEndPeriod = selectedValue;
              });
              checkValuesSelected();
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
            onPressed: () {
              // Pass the index to onDelete
              print("this index ${widget.index}");
              widget.onDelete(widget.index);
            },
          ),
        ],
      ),
    );
  }

  void checkValuesSelected() {
    if (widget.selectedDayOfWeek != null &&
        widget.selectedStartPeriod != null &&
        widget.selectedEndPeriod != null) {
      widget.onValuesSelected?.call();
      print("YESS"); // Call the callback when all values are selected
    }
  }
}
