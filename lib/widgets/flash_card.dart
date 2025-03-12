import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlashCard extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final bool isFlipped;
  final VoidCallback onOpen;
  final Function(bool) onFlip;

  const FlashCard({
    Key? key,
    required this.title,
    required this.description,
    required this.color,
    required this.onOpen,
    required this.isFlipped,
    required this.onFlip,
  }) : super(key: key);

  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  final FlipCardController _controller = FlipCardController();

  @override
  void didUpdateWidget(covariant FlashCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Flip back if this card was flipped before but now should be closed
    if (!widget.isFlipped && _controller.state?.isFront == false) {
      _controller.flipcard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isFlipped) {
          _controller.flipcard(); // Flip back if already flipped
          widget.onFlip(false);
        } else {
          _controller.flipcard(); // Flip open
          widget.onFlip(true);
        }
      },
      child: FlipCard(
        controller: _controller,
        rotateSide: RotateSide.left, // Flip left to right like a book
        axis: FlipAxis.vertical, // Horizontal flip
        animationDuration: const Duration(milliseconds: 600), // Smooth flip
        frontWidget: Container(
          width: 350,
          height: 220,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backWidget: Container(
          width: 350,
          height: 220,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),

              const SizedBox(height: 12),

              SizedBox(
                child: ElevatedButton(
                  onPressed: widget.onOpen,
                  child: const Text("Open"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
