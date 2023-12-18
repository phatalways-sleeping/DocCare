// ignore_for_file: public_member_api_docs, inference_failure_on_function_return_type, must_be_immutable, lines_longer_than_80_chars

import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/controller/create_staff_bloc.dart';

class DCCreateStaffScreen2 extends StatefulWidget {
  const DCCreateStaffScreen2({required this.initialState, super.key});

  final CreateStaffState initialState;
  @override
  _DCCreateStaffScreen2State createState() =>
      _DCCreateStaffScreen2State(initialState);
}

class _DCCreateStaffScreen2State extends State<DCCreateStaffScreen2> {
  final CreateStaffState initialState;
  _DCCreateStaffScreen2State(this.initialState);
  final List<DynamicWidget> listDynamic = [];
  List<String> data = [];
  late Map<String, List<int>> dayOfWeek = {};
  Icon floatingIcon = const Icon(Icons.add);
  bool atFirstPage = true;

  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<int> startPeriod = List.generate(19, (index) => index + 1);
  @override
  void initState() {
    super.initState();

    // Initialize daysOfWeek with state.dayOfWeek if it's not null
    this.dayOfWeek = initialState.dayOfWeek ?? {};

// Initialize listDynamic based on the initial daysOfWeek
    dayOfWeek.entries.forEach((entry) {
      final selectedDayOfWeek = entry.key ?? '';
      final selectedStartPeriod = entry.value[0] ?? -1;
      final selectedEndPeriod = entry.value[1] ?? -1;

      listDynamic.add(
        DynamicWidget(
          index: listDynamic.length,
          onDelete: (index) {
            // Remove the corresponding DynamicWidget and its dayOfWeek entry by index
            setState(() {
              final removedWidget = listDynamic.removeAt(index);
              dayOfWeek.remove(removedWidget.selectedDayOfWeek);
              for (var i = 0; i < listDynamic.length; i++) {
                listDynamic[i].index = i;
              }
            });
          },
          selectedStartPeriod: selectedStartPeriod,
          selectedEndPeriod: selectedEndPeriod,
          daysOfWeek: daysOfWeek,
          startPeriod: startPeriod,
          endPeriod: startPeriod,
          selectedDayOfWeek: selectedDayOfWeek,
          onValuesSelected: (selectedDay, selectedStart, selectedEnd) {
            dayOfWeek.putIfAbsent(selectedDay!, () => [-1, -1]);
            // Update the startPeriod and endPeriod in the dayOfWeek map
            dayOfWeek[selectedDay]![0] = selectedStart!;
            dayOfWeek[selectedDay]![1] = selectedEnd!;
          },
        ),
      );
    });
  }

  void addDynamic() {
    if (listDynamic.length >= 7) {
      return;
    }

    if (atFirstPage) {
      listDynamic.add(
        DynamicWidget(
          index: listDynamic.length,
          onDelete: (index) {
            // Remove the corresponding DynamicWidget and its dayOfWeek entry by index
            setState(() {
              final removedWidget = listDynamic.removeAt(index);
              dayOfWeek.remove(removedWidget.selectedDayOfWeek);
              for (var i = 0; i < listDynamic.length; i++) {
                listDynamic[i].index = i;
              }
            });
          },
          selectedStartPeriod: -1,
          selectedEndPeriod: -1,
          daysOfWeek:
              daysOfWeek.where((day) => !dayOfWeek.containsKey(day)).toList(),
          startPeriod: startPeriod,
          endPeriod: startPeriod,
          selectedDayOfWeek: '',
          onValuesSelected: (selectedDay, selectedStart, selectedEnd) {
            dayOfWeek.putIfAbsent(selectedDay!, () => [-1, -1]);
            // Update the startPeriod and endPeriod in the dayOfWeek map
            dayOfWeek[selectedDay]![0] = selectedStart!;
            dayOfWeek[selectedDay]![1] = selectedEnd!;
          },
        ),
      );
    }
    setState(() {});
  }

  void submitData() {
    data = [];
    atFirstPage = !atFirstPage;
    floatingIcon = const Icon(Icons.arrow_back);

    // Create a list to store indices of widgets to be removed
    final indicesToRemove = <int>[];

    listDynamic.asMap().forEach((index, widget) {
      // Check if all values are not null and selectedStartPeriod and selectedEndPeriod are not dummy values
      if (widget.selectedDayOfWeek != '' &&
          widget.selectedStartPeriod != -1 &&
          widget.selectedEndPeriod != -1 &&
          widget.selectedStartPeriod! < widget.selectedEndPeriod!) {
        // Concatenate the selected day and periods and add to the data list
        data.add(
          '${widget.selectedDayOfWeek}: ${widget.selectedStartPeriod} to ${widget.selectedEndPeriod}',
        );
      } else {
        // Add the index of widgets to be removed
        indicesToRemove.add(index);
      }
    });

    // Remove widgets from listDynamic based on indicesToRemove
    for (var index in indicesToRemove) {
      setState(() {
        listDynamic.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget result = Column(
      children: [
        Card(
          child: ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: BlocBuilder<CreateStaffBloc, CreateStaffState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (index == 0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Full name: ${state.fullName}'),
                                    Text('Email: ${state.email}'),
                                    Text('Password: ${state.password}'),
                                    Text(
                                      'Birthday: ${state.birthday}',
                                    ),
                                    Text('Phone Number: ${state.phone}'),
                                    Text('Role: ${state.role}'),
                                    if (state.role == 'Doctor')
                                      Text(
                                        'Specialization: ${state.specializationId}',
                                      ),
                                  ],
                                ),
                              Text('${index + 1} : ${data[index]}'),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );

    final List<Widget> dynamicTextField2 = listDynamic
        .map(
          (dynamicWidget) => dynamicWidget,
        )
        .toList();

    final nextButton = DCFilledButton(
      onPressed: (context) {
        if (listDynamic.isNotEmpty) {
          submitData();
          context.read<CreateStaffBloc>().add(
                WorkingShiftInputEvent(dayOfWeek),
              );
        }
      },
      backgroundColor:
          (listDynamic.isNotEmpty ? Colors.green[400] : Colors.grey[400]),
      child: const Text(
        'Next',
        selectionColor: Colors.black,
      ),
    );

    final Widget submitButton = DCFilledButton(
      onPressed: (context) {
        context.read<CreateStaffBloc>().add(
              const CreateStaffButtonPressedEvent(),
            );
      },
      backgroundColor:
          (listDynamic.isNotEmpty ? Colors.green[400] : Colors.grey[400]),
      child: const Text(
        'Submit',
        selectionColor: Colors.black,
      ),
    );

    return CustomScrollView(
      slivers: [
        if (atFirstPage)
          SliverList(
            delegate: SliverChildListDelegate(dynamicTextField2),
          )
        else
          SliverList(
            delegate: SliverChildListDelegate([result]),
          ),
        if (atFirstPage)
          SliverList(
            delegate: SliverChildListDelegate([nextButton]),
          )
        else
          SliverList(
            delegate: SliverChildListDelegate([submitButton]),
          ),
        SliverList(
          delegate: SliverChildListDelegate([
            DCFilledButton(
              onPressed: (context) {
                if (atFirstPage) {
                  addDynamic();
                } else {
                  setState(() {
                    atFirstPage = true;
                  });
                }
              },
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              backgroundColor: Colors.green[400],
              child: atFirstPage
                  ? const Icon(Icons.add)
                  : const Icon(Icons.arrow_back),
            ),
          ]),
        ),
      ],
    );
  }
}

class DynamicWidget extends StatefulWidget {
  DynamicWidget({
    required this.index,
    required this.onDelete,
    required this.daysOfWeek,
    required this.startPeriod,
    required this.endPeriod,
    required this.selectedStartPeriod,
    required this.selectedEndPeriod,
    super.key,
    this.onValuesSelected,
    this.selectedDayOfWeek,
  });
  final Function(int) onDelete;
  final List<String> daysOfWeek;
  final List<int> startPeriod;
  final List<int> endPeriod;
  final Function(String? daysOfWeek, int? startPeriod, int? endPeriod)?
      onValuesSelected;
  int index;

  String? selectedDayOfWeek;
  int? selectedStartPeriod;
  int? selectedEndPeriod;

  @override
  State<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(widget.selectedDayOfWeek ?? ''),

          DropdownButton<String>(
            items: [
              const DropdownMenuItem<String>(
                value: '',
                child: Text('Day of Week'),
              ),
              ...widget.daysOfWeek.toSet().map(
                    (value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  ),
            ],
            onChanged: (String? value) {
              setState(() {
                widget.selectedDayOfWeek = value;
              });
            },
            value: widget.selectedDayOfWeek ?? '',
          ),

          const SizedBox(height: 16),
          // Dropdown for Start Hour
          DropdownButton<int>(
            items: [
              const DropdownMenuItem<int>(
                value: -1,
                child: Text('Start Period'),
              ),
              ...widget.startPeriod
                  .where(
                    (value) =>
                        value <
                        (widget.selectedEndPeriod == -1
                            ? double.infinity
                            : widget.selectedEndPeriod)!,
                  )
                  .toSet()
                  .map(
                    (value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        value.toString(),
                      ), // Make sure to convert to String
                    ),
                  ),
            ],
            onChanged: (int? value) {
              setState(() {
                widget.selectedStartPeriod = value!;
              });
              checkValuesSelected();
            },
            value: widget.selectedStartPeriod ?? -1,
          ),

          const SizedBox(height: 16),
          // Dropdown for End Hour
          DropdownButton<int>(
            items: [
              const DropdownMenuItem<int>(
                value: -1,
                child: Text('End Period'),
              ),
              ...widget.endPeriod
                  .where((value) => value > (widget.selectedStartPeriod ?? 0))
                  .toList()
                  .toSet()
                  .map(
                    (value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    ),
                  ),
            ],
            onChanged: (int? value) {
              setState(() {
                widget.selectedEndPeriod = value!;
              });
              checkValuesSelected();
            },
            value: widget.selectedEndPeriod,
          ),
          const SizedBox(height: 16),
          const Divider(
            height: 1,
            color: Colors.black, // Adjust the color of the line as needed
          ),
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Pass the index to onDelete
              widget.onDelete(widget.index);
            },
          ),
        ],
      ),
    );
  }

  void checkValuesSelected() {
    if (widget.selectedDayOfWeek != null &&
        widget.selectedStartPeriod != -1 &&
        widget.selectedEndPeriod != -1) {
      widget.onValuesSelected?.call(widget.selectedDayOfWeek,
          widget.selectedStartPeriod, widget.selectedEndPeriod);
      // Call the callback when all values are selected
    }
  }
}
