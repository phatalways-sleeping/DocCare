import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    required this.imageSrc,
    required this.name,
    required this.speciality,
    required this.rating,
    super.key,
  });

  final String imageSrc;
  final String name;
  final String speciality;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.width * 0.03,
        vertical: context.height * 0.02,
      ),
      constraints: BoxConstraints(
        maxHeight: context.height * 0.14,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.03,
        vertical: context.height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            child: Image.network(
              imageSrc,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: context.width * 0.03,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: context.textTheme.h1BoldPoppins.copyWith(
                  fontSize: 20,
                ),
              ),
              Text(
                speciality,
                style: context.textTheme.h1RegularPoppins.copyWith(
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < rating; i++)
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  for (var i = 0; i < 5 - rating; i++)
                    const Icon(
                      Icons.star,
                      color: Colors.grey,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
