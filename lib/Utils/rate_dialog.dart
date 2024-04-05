import 'package:flutter/material.dart';
import 'package:speakerclener/ads/EntryAnimation.dart';


/// Defines variants of entry animations

class RateDialog extends StatefulWidget {
  RateDialog({
    Key? key,
    this.imageWidget,
    this.title,
    this.onOkButtonPressed,
    this.description,
    this.onCancelButtonPressed,
    this.onNeutralButtonPressed,
    this.onlyOkButton = false,
    this.isNeutralButton = false,
    this.onlyCancelButton = false,
    this.buttonOkText,
    this.buttonCancelText,
    this.buttonOkColor = Colors.transparent,
    this.buttonCancelColor = Colors.transparent,
    this.buttonNeutralColor = Colors.redAccent,
    this.cornerRadius = 8.0,
    this.buttonRadius = 8.0,
    this.entryAnimation = EntryAnimation.DEFAULT,
  }) : super(key: key);

  final Widget? imageWidget;
  final Widget? title;
  final Widget? description;
  final bool onlyOkButton;
  final bool isNeutralButton;
  final bool onlyCancelButton;
  final Text? buttonOkText;
  final Text? buttonCancelText;
  final Color buttonOkColor;
  final Color buttonCancelColor;
  final Color buttonNeutralColor;
  final double buttonRadius;
  final double cornerRadius;
  final VoidCallback? onOkButtonPressed;
  final VoidCallback? onCancelButtonPressed;
  final VoidCallback? onNeutralButtonPressed;
  final EntryAnimation entryAnimation;

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> with TickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<Offset> _entryAnimation;

  get _start {
    switch (widget.entryAnimation) {
      case EntryAnimation.DEFAULT:
        break;
      case EntryAnimation.TOP:
        return Offset(0.0, -1.0);
      case EntryAnimation.TOP_LEFT:
        return Offset(-1.0, -1.0);
      case EntryAnimation.TOP_RIGHT:
        return Offset(1.0, -1.0);
      case EntryAnimation.LEFT:
        return Offset(-1.0, 0.0);
      case EntryAnimation.RIGHT:
        return Offset(1.0, 0.0);
      case EntryAnimation.BOTTOM:
        return Offset(0.0, 1.0);
      case EntryAnimation.BOTTOM_LEFT:
        return Offset(-1.0, 1.0);
      case EntryAnimation.BOTTOM_RIGHT:
        return Offset(1.0, 1.0);
    }
  }

  get _isDefaultEntryAnimation => widget.entryAnimation == EntryAnimation.DEFAULT;

  @override
  void initState() {
    super.initState();
    if (!_isDefaultEntryAnimation) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      );
      _entryAnimation = Tween<Offset>(begin: _start, end: Offset(0.0, 0.0)).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Curves.easeIn,
        ),
      )..addListener(() => setState(() {}));
      _animationController!.forward();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Widget _buildPortraitWidget(BuildContext context, Widget? imageWidget) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: widget.title,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.description,
            ),
            _buildButtonsBar(context)
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            // right: Radius.circular(widget.cornerRadius),
              bottom: Radius.circular(widget.cornerRadius)),
          child: imageWidget,
        ),
      ],
    );
  }

  // Widget _buildLandscapeWidget(BuildContext context, Widget imageWidget) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: <Widget>[
  //       Expanded(
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(widget.cornerRadius),
  //               bottomLeft: Radius.circular(widget.cornerRadius)),
  //           child: imageWidget,
  //         ),
  //       ),
  //       Expanded(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.only(top: 16.0),
  //               child: widget.title,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(3.0),
  //               child: widget.description,
  //             ),
  //             _buildButtonsBar(context),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildButtonsBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: !widget.onlyOkButton ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
        children: <Widget>[
          if (!widget.onlyOkButton) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonCancelColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.buttonRadius)),
              ),
              onPressed: widget.onCancelButtonPressed ?? () => Navigator.of(context).pop(),
              child: widget.buttonCancelText ??
                  Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
            )
          ],
          if (widget.isNeutralButton) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonNeutralColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.buttonRadius)),
              ),
              onPressed: widget.onNeutralButtonPressed ?? () => Navigator.of(context).pop(),
              child: widget.buttonCancelText ??
                  Text(
                    'I hate it!',
                    style: TextStyle(color: Colors.white),
                  ),
            )
          ],
          if (!widget.onlyCancelButton) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonOkColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.buttonRadius)),
              ),
              onPressed: widget.onOkButtonPressed,
              child: widget.buttonOkText ??
                  Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        transform: !_isDefaultEntryAnimation
            ? Matrix4.translationValues(
          _entryAnimation.value.dx * width,
          _entryAnimation.value.dy * width,
          0,
        )
            : null,
        // height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * (isPortrait ? 0.8 : 0.5),
        child: Material(
          type: MaterialType.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.cornerRadius)),
          elevation: Theme.of(context).dialogTheme.elevation ?? 24.0,
          // child: isPortrait
          //     ? _buildPortraitWidget(context, widget.imageWidget)
          //     : _buildLandscapeWidget(context, widget.imageWidget),
          child: _buildPortraitWidget(context, widget.imageWidget),
        ),
      ),
    );
  }
}
