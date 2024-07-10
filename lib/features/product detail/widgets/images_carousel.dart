import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List imageUrls;

  const ImageCarousel({super.key, required this.imageUrls});

  @override
  State<ImageCarousel> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ImageCarousel> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.36,
      child: Column(
        children: [
          CarouselSlider(
            items: widget.imageUrls.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: 
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.20,
                    
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 240.0, // Adjust height as needed
              viewportFraction: 1.0, // Display full image
              enableInfiniteScroll: true, // Loop through images
              autoPlay: true, // Optional: Autoplay the slider
              autoPlayInterval: const Duration(seconds: 3), // Autoplay interval
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
          ),
          const SizedBox(
              height: 10.0), // Add spacing between slider and previews
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageUrls.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() => _currentImageIndex = entry.key),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: 

                    CachedNetworkImage(
                                          imageUrl: entry.value,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        
                                          
                                        ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
