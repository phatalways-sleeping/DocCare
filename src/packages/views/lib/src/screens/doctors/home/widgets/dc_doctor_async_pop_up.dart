// ignore_for_file: public_member_api_docs
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:views/src/screens/doctors/home/widgets/dc_doctor_pop_up_prescription.dart';

class DCDoctorAsyncPopUp extends StatefulWidget {
  const DCDoctorAsyncPopUp({
    required this.future,
    required this.customerName,
    super.key,
  });

  final Future<Map<String, dynamic>> future;
  final String customerName;

  @override
  State<DCDoctorAsyncPopUp> createState() => _DCDoctorAsyncPopUpState();
}

class _DCDoctorAsyncPopUpState extends State<DCDoctorAsyncPopUp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var medicineMessage = '';
          final List<Map<String, dynamic>> medicines =
              snapshot.data!['medicines'] as List<Map<String, dynamic>>;

          for (var medicine in medicines) {
            var TOD = medicine['timeOfTheDay'].split('/').join(',').toString();
            TOD = TOD.substring(0, TOD.length - 1);

            medicineMessage +=
                '${medicine['medicineName']}: ${medicine['quantity']} pill${int.parse(medicine['quantity'].toString()) > 1 ? 's' : ''} - $TOD - ${medicine['toBeTaken'].toString() == '0' ? 'before eating' : 'after eating'}\n';
          }

          medicineMessage = medicineMessage.substring(
            0,
            medicineMessage.length - 1,
          );

          final rating = snapshot.data!['rating'];

          return DCPopupDoctorPrescription(
            title: 'Prescription',
            confirmButtonColor: context.colorScheme.secondary,

            diagnosisMessage: snapshot.data!['diagnosis'].toString(),
            //List of medicines to string
            medicinesMessage: medicineMessage,
            noteMessage: snapshot.data!['note'].toString(),
            customerName: widget.customerName,
            onConfirmButtonClicked: (context) => {Navigator.pop(context)},
            showReview: (rating == null) ? null : (rating as int),
          );
        } else if (snapshot.hasError) {
          return ElevatedButton(
            onPressed: () => setState(() {}),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                context.colorScheme.error,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              elevation: const MaterialStatePropertyAll(4),
              shadowColor: MaterialStatePropertyAll(
                context.colorScheme.onSurface.withOpacity(0.5),
              ),
              fixedSize: MaterialStatePropertyAll(
                Size(
                  context.width * 0.94,
                  50,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'An eror occured.',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    color: context.colorScheme.tertiary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.refresh,
                  color: context.colorScheme.tertiary,
                  size: 20,
                ),
              ],
            ),
          );
        }
        return Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: context.colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }
}
