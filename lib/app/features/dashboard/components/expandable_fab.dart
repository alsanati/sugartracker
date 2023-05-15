import 'package:flutter/material.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return IgnorePointer(
      ignoring: !_open,
      child: AnimatedOpacity(
        opacity: _open ? 1.0 : 0.0,
        curve: const Interval(0.0, 0.25, curve: Curves.easeInOut),
        duration: const Duration(milliseconds: 250),
        child: SizedBox(
          width: 54.0,
          height: 54.0,
          child: Center(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 4.0,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: InkWell(
                onTap: _toggle,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;

    for (var i = 0; i < count; i++) {
      children.add(
        _ExpandingActionButton(
          index: i,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.index,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final int index;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset(0,
            progress.value * maxDistance * (index + 1)); // Change the sign here
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: child!,
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key, this.onPressed, required this.label, required this.context})
      : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        clipBehavior: Clip.antiAlias,
        color: theme.colorScheme.secondary,
        elevation: 4.0,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              label,
              style: TextStyle(color: theme.colorScheme.onSecondary),
            ),
          ),
        ));
  }
}
