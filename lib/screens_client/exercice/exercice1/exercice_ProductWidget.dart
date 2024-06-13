import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sportapplication/screens_client/exercice/exercice_productwidget2.dart';

class ItemsWidget extends StatelessWidget {
  final String text;

  const ItemsWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(16.0),
      color: Colors.blueAccent,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ItemsListWidget extends StatelessWidget {
  ItemsListWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.duree,
    required this.nameId,
    required this.material, 
    required this.video,
  });

  final String imageUrl;
  final String nameId;
  final String name;
  final String duree;
  final String material;
  final String video;

  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: [
                    
                    IconButton(
                      icon: Icon(
                        Icons.play_circle,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailScreen(
                              name: name,
                              duree: duree,
                              imageUrl: imageUrl,
                              material: material,
                              productId: nameId,
                              isFirstExercise: false, videoUrl: video,
                              
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            duree,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
  
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  const Parallax({
    super.key,
    required Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context);
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

  
    final background = child!;
    final backgroundImageConstraints =
        BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

  
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
        localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

  
    final scrollFraction =
        (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);


    final background = child!;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}

class Exercice {
  const Exercice(
  {
    required this.nameExercice,
    required this.duree,
    required this.imageUrl,
    required this.nameId,
    required this.material,
    required this.videoUrl,
  });

  final String nameExercice;
  final String duree;
  final String imageUrl;
  final String nameId;
  final String material;
  final String   videoUrl;
}

const locations = [
  Exercice(
    nameId: 'jambe',
    nameExercice: 'Exercice Jambes',
    duree: '15 min',
    material: 'Avec matériel',
    videoUrl: 'assets/videos/sport1.mp4',
    imageUrl:
        "https://images.pexels.com/photos/2827392/pexels-photo-2827392.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ),
  Exercice(
    nameId: 'bras',
    nameExercice: 'Exercice Bras',
    duree: '30 min ',
    material: 'Avec matériel',
    videoUrl: 'assets/videos/sport1.mp4',
    imageUrl:
        "https://images.pexels.com/photos/3917334/pexels-photo-3917334.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ),
];
