import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TranslateContainer extends StatefulWidget {
  const TranslateContainer({super.key});

  @override
  State<TranslateContainer> createState() => _TranslateContainerState();
}

class _TranslateContainerState extends State<TranslateContainer> {
  final TextEditingController _controller = TextEditingController();
  int _wordCount = 0;
  final int _wordLimit = 50;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateWordCount);
  }

  void _updateWordCount() {
    final text = _controller.text;
    setState(() {
      _wordCount = _countWords(text);
      if (_wordCount > _wordLimit) {
        // Truncate the text if word limit is exceeded
        _controller.value = _controller.value.copyWith(
          text: _truncateTextToWordLimit(text, _wordLimit),
          selection: TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          ),
        );
        _wordCount = _wordLimit;
      }
    });
  }

  int _countWords(String text) {
    if (text.isEmpty) {
      return 0;
    }
    final words = text.trim().split(RegExp(r'\s+'));
    return words.length;
  }

  String _truncateTextToWordLimit(String text, int wordLimit) {
    final words = text.trim().split(RegExp(r'\s+'));
    if (words.length <= wordLimit) {
      return text;
    }
    return words.take(wordLimit).join(' ');
  }

  @override
  void dispose() {
    _controller.removeListener(_updateWordCount);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFFFFFFFF),
          border: Border.all(
            color: const Color(0xFF6D1B7B).withOpacity(0.8),
            width: 0.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controller,
              maxLines: 6,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                labelStyle: GoogleFonts.poppins(
                  color: const Color(0xFF000000),
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFF6D1B7B).withOpacity(0.8),
                    width: 0.2,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_wordCount/$_wordLimit words',
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.volume_up_outlined,
                        color: const Color(0xFF6D1B7B).withOpacity(0.8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
