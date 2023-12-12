import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:components/src/widgets/header_bar/dc_customer_header_bar.dart';
import 'package:components/src/widgets/navigation_bar/dc_customer_navigation_bar.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';

class DCIntakeScreen extends StatefulWidget {
  const DCIntakeScreen({Key? key}) : super(key: key);

  @override
  _DCIntakeScreenState createState() => _DCIntakeScreenState();
}

class _DCIntakeScreenState extends State<DCIntakeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCCustomerHeaderBar(
        title: 'DocCare',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onBackground,
              ),
              textAlign: TextAlign.left,
              child: const Text('Your history'),
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onBackground,
              ),
              textAlign: TextAlign.left,
              child: const Text('Current Intake'),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 1,
                  heightFactor: 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultTextStyle.merge(
                          style: context.textTheme.h4BoldPoppins.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: context.colorScheme.onBackground,
                          ),
                          textAlign: TextAlign.start,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Doctor name'),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: SvgPicture.string(
                                    DCSVGIcons.clock,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: context.textTheme.h4RegularPoppins
                                      .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: context.colorScheme.onBackground,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text('10:00 AM'),
                                  ),
                                ),
                                //Text at the end of the row
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: DefaultTextStyle(
                                        style: context
                                            .textTheme.h4RegularPoppins
                                            .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color:
                                              context.colorScheme.onBackground,
                                        ),
                                        child: const Text('Flu'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onBackground,
              ),
              textAlign: TextAlign.left,
              child: const Text('Past Intake'),
            ),
            DCCustomerNavigationBar(
              onItemSelected: (context, index) {
                print('index: $index');
              },
            ),
          ],
        ),
      ),
    );
  }
}
