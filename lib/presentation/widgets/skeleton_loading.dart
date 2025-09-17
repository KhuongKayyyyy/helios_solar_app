import 'package:flutter/material.dart';

class SkeletonLoading extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const SkeletonLoading({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<SkeletonLoading> createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutSine,
      ),
    );

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ?? Colors.white.withOpacity(0.15);
    final highlightColor =
        widget.highlightColor ?? Colors.white.withOpacity(0.35);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (_animation.value - 1).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 1).clamp(0.0, 1.0),
              ],
              colors: [baseColor, highlightColor, baseColor],
            ),
          ),
        );
      },
    );
  }
}

class SkeletonCurrentWeather extends StatelessWidget {
  const SkeletonCurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Loading text
          Text(
            'Loading weather data...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          // Location
          const SkeletonLoading(
            width: 200,
            height: 20,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          const SizedBox(height: 20),

          // Temperature
          const SkeletonLoading(
            width: 120,
            height: 60,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          const SizedBox(height: 10),

          // Condition
          const SkeletonLoading(
            width: 150,
            height: 16,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          const SizedBox(height: 20),

          // Weather details row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SkeletonLoading(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  const SizedBox(height: 8),
                  const SkeletonLoading(
                    width: 60,
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ],
              ),
              Column(
                children: [
                  const SkeletonLoading(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  const SizedBox(height: 8),
                  const SkeletonLoading(
                    width: 60,
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ],
              ),
              Column(
                children: [
                  const SkeletonLoading(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  const SizedBox(height: 8),
                  const SkeletonLoading(
                    width: 60,
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
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

class SkeletonHourlyWeather extends StatelessWidget {
  const SkeletonHourlyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (index) {
          return Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SkeletonLoading(
                  width: 40,
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                SizedBox(height: 10),
                SkeletonLoading(
                  width: 24,
                  height: 24,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                SizedBox(height: 10),
                SkeletonLoading(
                  width: 35,
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class SkeletonDailyWeather extends StatelessWidget {
  const SkeletonDailyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Column(
        children: List.generate(7, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
            child: Row(
              children: [
                const SkeletonLoading(
                  width: 80,
                  height: 16,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                const Spacer(),
                const SkeletonLoading(
                  width: 30,
                  height: 30,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                const Spacer(),
                const SkeletonLoading(
                  width: 70,
                  height: 16,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
