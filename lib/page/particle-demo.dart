import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class ParticleDemo extends StatefulWidget {
  @override
  _ParticleDemoState createState() => _ParticleDemoState();
}

class _ParticleDemoState extends State<ParticleDemo> {
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: PimpedButton(
                        particle: MyParticle(),
                        pimpedWidgetBuilder: (context, controller) {
                          _controller = controller;
                          return FloatingActionButton(onPressed: () {
                            controller.forward(from: 0.0);
                          },);
                        },
                      ),
        ),
      ),
      floatingActionButton: RaisedButton(
        child: Text("Animate"),
        onPressed: (){
          // _controller.forward(from: 0.0);
          _controller.repeat(period: Duration(seconds: 1));
        },
      ),
    );
  }
}

class MyParticle extends Particle {
  @override
  void paint(Canvas canvas, Size size, progress, seed) {
    int randomMirrorOffset = 6;
    CompositeParticle(children: [
      // Firework(),
      CircleMirror(
          numberOfParticles: 16,
          child: AnimatedPositionedParticle(
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 60.0),
            child: FadingCircle(radius: 3.0, color: Colors.pink),
            // child: FadingRect(width: 5.0, height: 15.0, color: Colors.pink),
          ),
          initialRotation: -pi / randomMirrorOffset),
      CircleMirror.builder(
          numberOfParticles: 16,
          particleBuilder: (index) {
            return IntervalParticle(
                child: AnimatedPositionedParticle(
                  begin: Offset(0.0, 30.0),
                  end: Offset(0.0, 50.0),
                  child: FadingCircle(radius: 3.0, color: Colors.pink),
                ),
                interval: Interval(
                  0.5,
                  1,
                ));
          },
          initialRotation: -pi / randomMirrorOffset +10 ),
    ]).paint(canvas, size, progress, seed);
  }
}