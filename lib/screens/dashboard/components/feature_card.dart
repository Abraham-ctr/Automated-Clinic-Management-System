import 'package:flutter/material.dart';

class FeatureCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final ValueNotifier<String?> flippedCardNotifier;
  final VoidCallback onTap; // New parameter for navigation

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.flippedCardNotifier,
    required this.onTap, // Receive navigation function
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    widget.flippedCardNotifier.addListener(_handleFlippedCardChange);
  }

  @override
  void dispose() {
    widget.flippedCardNotifier.removeListener(_handleFlippedCardChange);
    _controller.dispose();
    super.dispose();
  }

  void _handleFlippedCardChange() {
    if (widget.flippedCardNotifier.value != widget.title && isFlipped) {
      _controller.reverse();
      setState(() {
        isFlipped = false;
      });
    }
  }

  void _toggleCard() {
    if (isFlipped) {
      _controller.reverse();
      widget.flippedCardNotifier.value = null;
    } else {
      _controller.forward();
      widget.flippedCardNotifier.value = widget.title;
    }
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final rotationValue = _flipAnimation.value;
          final isBack = rotationValue > 0.5;
          return Transform(
            transform: Matrix4.rotationY(rotationValue * 3.1416),
            alignment: Alignment.center,
            child: isBack ? _buildBack() : _buildFront(),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, size: 40, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.1416),
      child: Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Manage ${widget.title}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: widget.onTap, // Navigate to respective screen
              child: const Text("Open", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
