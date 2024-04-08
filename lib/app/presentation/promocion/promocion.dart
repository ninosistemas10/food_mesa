import 'dart:async';
import 'package:flutter/material.dart';

class PromocionSlider extends StatefulWidget {
    const PromocionSlider({Key? key}) : super(key: key);

    @override
    State<PromocionSlider> createState() => _PromocionSliderState();
}

    class _PromocionSliderState extends State<PromocionSlider> with TickerProviderStateMixin {
        List<String> assets = [
            'assets/image/image1.jpeg',
            'assets/image/image2.jpeg',
            'assets/image/image3.jpeg',
            'assets/image/image4.jpeg',
            'assets/image/image5.jpeg',
            'assets/image/image6.jpeg',
        ];        
        final color = [
            Colors.red,
            Colors.amber,
            Colors.teal,
            Colors.blueGrey,
            Colors.blue,
        ];
        int currentIndex = 0;
        late Timer _timer;
        late PageController _pageController;

        @override
        void initState() {
            super.initState();
            _pageController = PageController(
                initialPage: currentIndex,
                viewportFraction: 0.7,
            );

            _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
                if (currentIndex < assets.length - 1) {
                    currentIndex++;
                } else {
                    currentIndex = 0;
                    _pageController.jumpToPage(0);
                }
                _pageController.animateToPage(
                    currentIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                );
                setState(() {});
            });
        }

        @override
        Widget build(BuildContext context) {
            return SingleChildScrollView(
                child: Column(
                    children: [
                        SizedBox(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                                itemCount: assets.length,
                                physics: const BouncingScrollPhysics(),
                                controller: _pageController,
                                onPageChanged: (value) {
                                    currentIndex = value;
                                    setState(() {});
                                },
                                
                                itemBuilder: (context, index) {
                                    return Container(
                                        margin: const EdgeInsets.all(8),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                        ),
                                        
                                        child: Image.asset(
                                            assets[index],
                                            fit: BoxFit.cover,
                                        ),
                                    );
                                },
                            ),
                        ),
                        
                        TabPageSelector(
                            controller: TabController(
                                length: assets.length,
                                initialIndex: currentIndex,
                                vsync: this,
                            ),
                            selectedColor: Colors.red,
                            color: Colors.grey,
                            borderStyle: BorderStyle.none,
                        ),

                    ],
                ),
            );
        }

        @override
        void dispose() {
            _timer.cancel();
            _pageController.dispose();
        super.dispose();
        }
    }
