import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/product%20detail/widgets/add_review_textfield.dart';

class CustomRatingWidget extends StatefulWidget {
  CustomRatingWidget(
      {super.key,
      required this.rating,
      required this.width,
      required this.height,
      required this.ontap, required this.addReview});

  double rating;
  final double width;
  final double height;
  final VoidCallback ontap;
  final TextEditingController addReview;

  @override
  State<CustomRatingWidget> createState() => _CustomRatingWidgetState();
}

class _CustomRatingWidgetState extends State<CustomRatingWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Review:',
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
                ),
                Text(
                  widget.rating.toString(), // Display rating with one decimal
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(
                  horizontal: widget.width *
                      0.05), // Adjust padding based on screen size
              itemSize:
                  widget.width * 0.07, // Adjust star size based on screen size
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                setState(() {
                  widget.rating = newRating;
                });
                print(widget.rating);
              },
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                AddReviewTextField(
                    hintText: 'Write Review', controller: widget.addReview),
                IconButton(onPressed: widget.ontap, icon: const Icon(Icons.send))
              ],
            ) // Assuming you have an AddReviewTextField widget
          ],
        ),
      ),
    );
  }
}
