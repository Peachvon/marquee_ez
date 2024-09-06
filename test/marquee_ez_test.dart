import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:marquee_ez/marquee_ez.dart';

void main() {
  test('adds one to input values', () {
    // final calculator = MarqueeEZ();
    expect(
        const MarqueeEZ(
          text: 'test',
          width: 100,
          milliseconds: 5000,
        ),
        Widget);
  });
}
