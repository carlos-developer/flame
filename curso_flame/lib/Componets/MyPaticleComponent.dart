import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flame/components/particle_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/flare_animation.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/particle.dart';
import 'package:flame/particles/accelerated_particle.dart';
import 'package:flame/particles/animation_particle.dart';
import 'package:flame/particles/circle_particle.dart';
import 'package:flame/particles/component_particle.dart';
import 'package:flame/particles/composed_particle.dart';
import 'package:flame/particles/computed_particle.dart';
import 'package:flame/particles/image_particle.dart';
import 'package:flame/particles/moving_particle.dart';
import 'package:flame/particles/paint_particle.dart';
import 'package:flame/particles/rotating_particle.dart';
import 'package:flame/particles/sprite_particle.dart';
import 'package:flame/particles/translated_particle.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/svg.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flame/animation.dart' as animation;

class MyParticleComponent extends BaseGame{
  static const gridSize = 5;
  static const steps = 5;



  final Random rnd = Random();
  final StepTween steppedTween = StepTween(begin: 0, end: 5);
  final TextConfig fpsTextConfig = const TextConfig(
    color: const Color(0xFFFFFFFF),
  );

  final sceneDuration = const Duration(seconds: 1);

  Offset cellSize;
  Offset halfCellSize;
  FlareAnimation flareAnimation;
  MyParticleComponent(){
    add(createMyParticleComponent());
  }

  createMyParticleComponent(){
    double axisX=0.0;
    Particle particle=Particle.generate(count: 8,lifespan: 10,
        generator: (i){
       axisX+=50.0*i;
      return MovingParticle(curve: Curves.slowMiddle,
        from: Offset(axisX,50),
        to:  Offset(axisX,600),
        child: CircleParticle(
          radius: 2.0,
          paint: Paint()..color=Colors.blueAccent
        )
      );
        });
    return ParticleComponent(
      particle: particle
    );
  }



  Particle circle() {
    return CircleParticle(
      paint: Paint()..color = Colors.white10,
    );
  }


  Particle smallWhiteCircle() {
    return CircleParticle(
      radius: 5.0,
      paint: Paint()..color = Colors.white,
    );
  }


  Particle movingParticle() {
    return MovingParticle(

      from: const Offset(-20, -20),
      to: const Offset(20, 20),
      child: CircleParticle(paint: Paint()..color = Colors.amber),
    );
  }


  Particle randomMovingParticle() {
    return MovingParticle(
      to: randomCellOffset(),
      child: CircleParticle(
        radius: 5 + rnd.nextDouble() * 5,
        paint: Paint()..color = Colors.red,
      ),
    );
  }


  Particle alignedMovingParticles() {
    return Particle.generate(
      count: 5,
      generator: (i) {
        final currentColumn = (cellSize.dx / 5) * i - halfCellSize.dx;
        return MovingParticle(
          from: Offset(currentColumn, -halfCellSize.dy),
          to: Offset(currentColumn, halfCellSize.dy),
          child: CircleParticle(
            radius: 2.0,
            paint: Paint()..color = Colors.blue,
          ),
        );
      },
    );
  }


  Particle randomMovingParticles() {
    return Particle.generate(
      count: 5,
      generator: (i) => MovingParticle(
        to: randomCellOffset() * .5,
        child: CircleParticle(
          radius: 5 + rnd.nextDouble() * 5,
          paint: Paint()..color = Colors.deepOrange,
        ),
      ),
    );
  }


  Particle easedMovingParticle() {
    return Particle.generate(
      count: 5,
      generator: (i) => MovingParticle(
        curve: Curves.easeOutQuad,
        to: randomCellOffset() * .5,
        child: CircleParticle(
          radius: 5 + rnd.nextDouble() * 5,
          paint: Paint()..color = Colors.deepPurple,
        ),
      ),
    );
  }

  Particle intervalMovingParticle() {
    return Particle.generate(
      count: 5,
      generator: (i) => MovingParticle(
        curve: const Interval(.2, .6, curve: Curves.easeInOutCubic),
        to: randomCellOffset() * .5,
        child: CircleParticle(
          radius: 5 + rnd.nextDouble() * 5,
          paint: Paint()..color = Colors.greenAccent,
        ),
      ),
    );
  }

  Particle computedParticle() {
    return ComputedParticle(
      renderer: (canvas, particle) => canvas.drawCircle(
        Offset.zero,
        particle.progress * halfCellSize.dx,
        Paint()
          ..color = Color.lerp(
            Colors.red,
            Colors.blue,
            particle.progress,
          ),
      ),
    );
  }


  Particle steppedComputedParticle() {
    return ComputedParticle(
      lifespan: 2,
      renderer: (canvas, particle) {
        const steps = 5;
        final steppedProgress =
            steppedTween.transform(particle.progress) / steps;

        canvas.drawCircle(
          Offset.zero,
          (1 - steppedProgress) * halfCellSize.dx,
          Paint()
            ..color = Color.lerp(
              Colors.red,
              Colors.blue,
              steppedProgress,
            ),
        );
      },
    );
  }

  Particle reusablePatricle;

  Particle reuseParticles() {
    reusablePatricle ??= circle();

    return Particle.generate(
      count: 10,
      generator: (i) => MovingParticle(
        curve: Interval(rnd.nextDouble() * .1, rnd.nextDouble() * .8 + .1),
        to: randomCellOffset() * .5,
        child: reusablePatricle,
      ),
    );
  }

  Particle imageParticle() {
    return ImageParticle(
      size: const Size.square(24),
      image: Flame.images.loadedFiles['zap.png'],
    );
  }


  Particle reusableImageParticle;


  Particle reuseImageParticle() {
    const count = 9;
    const perLine = 3;
    const imageSize = 24.0;
    final colWidth = cellSize.dx / perLine;
    final rowHeight = cellSize.dy / perLine;

    reusableImageParticle ??= imageParticle();

    return Particle.generate(
      count: count,
      generator: (i) => TranslatedParticle(
          offset: Offset(
            (i % perLine) * colWidth - halfCellSize.dx + imageSize,
            (i ~/ perLine) * rowHeight - halfCellSize.dy + imageSize,
          ),
          child: reusableImageParticle),
    );
  }

  Particle rotatingImage({double initialAngle = 0}) {
    return RotatingParticle(from: initialAngle, child: imageParticle());
  }


  Particle acceleratedParticles() {
    return Particle.generate(
      count: 10,
      generator: (i) => AcceleratedParticle(
        speed:
        Offset(rnd.nextDouble() * 600 - 300, -rnd.nextDouble() * 600) * .2,
        acceleration: const Offset(0, 200),
        child: rotatingImage(initialAngle: rnd.nextDouble() * pi),
      ),
    );
  }

  Particle paintParticle() {
    final List<Color> colors = [
      const Color(0xffff0000),
      const Color(0xff00ff00),
      const Color(0xff0000ff),
    ];
    final List<Offset> positions = [
      const Offset(-10, 10),
      const Offset(10, 10),
      const Offset(0, -14),
    ];

    return Particle.generate(
      count: 3,
      generator: (i) => PaintParticle(
        paint: Paint()..blendMode = BlendMode.difference,
        child: MovingParticle(
          curve: SineCurve(),
          from: positions[i],
          to: i == 0 ? positions.last : positions[i - 1],
          child: CircleParticle(
            radius: 20.0,
            paint: Paint()..color = colors[i],
          ),
        ),
      ),
    );
  }


  Particle spriteParticle() {
    return SpriteParticle(
      sprite: Sprite('zap.png'),
      size: Position.fromOffset(cellSize * .5),
    );
  }





  Particle fireworkParticle() {
    final List<Paint> paints = [
      Colors.amber,
      Colors.amberAccent,
      Colors.red,
      Colors.redAccent,
      Colors.yellow,
      Colors.yellowAccent,
      Colors.blue,
    ].map<Paint>((color) => Paint()..color = color).toList();

    return Particle.generate(
      count: 10,
      generator: (i) {
        final initialSpeed = randomCellOffset();
        final deceleration = initialSpeed * -1;
        const gravity = const Offset(0, 40);

        return AcceleratedParticle(
          speed: initialSpeed,
          acceleration: deceleration + gravity,
          child: ComputedParticle(renderer: (canvas, particle) {
            final paint = randomElement(paints);
            paint.color = paint.color.withOpacity(1 - particle.progress);

            canvas.drawCircle(
              Offset.zero,
              rnd.nextDouble() * particle.progress > .6
                  ? rnd.nextDouble() * (50 * particle.progress)
                  : 2 + (3 * particle.progress),
              paint,
            );
          }),
        );
      },
    );
  }


  Particle chainingBehaviors() {
    final paint = Paint()..color = randomMaterialColor();
    final rect = ComputedParticle(
      renderer: (canvas, _) => canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: 10, height: 10),
        paint,
      ),
    );

    return ComposedParticle(children: <Particle>[
      rect
          .rotating(to: pi / 2)
          .moving(to: -cellSize)
          .scaled(2)
          .accelerated(acceleration: halfCellSize * 5)
          .translated(halfCellSize),
      rect
          .rotating(to: -pi)
          .moving(to: cellSize.scale(1, -1))
          .scaled(2)
          .translated(halfCellSize.scale(-1, 1))
          .accelerated(acceleration: halfCellSize.scale(-5, 5))
    ]);
  }

  @override
  bool debugMode() => true;
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (debugMode()) {
      fpsTextConfig.render(canvas, '${fps(120).toStringAsFixed(2)}fps',
          Position(0, size.height - 24));
    }
  }


  Offset randomCellOffset() {
    return cellSize.scale(rnd.nextDouble(), rnd.nextDouble()) - halfCellSize;
  }

  Color randomMaterialColor() {
    return Colors.primaries[rnd.nextInt(Colors.primaries.length)];
  }

  T randomElement<T>(List<T> list) {
    return list[rnd.nextInt(list.length)];
  }

  animation.Animation getBoomAnimation() {
    const columns = 8;
    const rows = 8;
    const frames = columns * rows;
    const imagePath = 'boom.png';
    final spriteImage = Flame.images.loadedFiles[imagePath];
    final spritesheet = SpriteSheet(
      rows: rows,
      columns: columns,
      imageName: imagePath,
      textureWidth: spriteImage.width ~/ columns,
      textureHeight: spriteImage.height ~/ rows,
    );
    final sprites = List<Sprite>.generate(
      frames,
          (i) => spritesheet.getSprite(i ~/ rows, i % columns),
    );

    return animation.Animation.spriteList(sprites);
  }
}

class SineCurve extends Curve {
  @override
  double transformInternal(double t) {
    return (sin(pi * (t * 2 - 1 / 2)) + 1) / 2;
  }
}
