import 'package:flutter/material.dart';

class IngredientButton extends StatefulWidget {
  final String category;
  final String buttonName;
  final List<String> selectedIngedient;
  const IngredientButton(this.category, this.buttonName, this.selectedIngedient,
      {super.key});

  @override
  State<IngredientButton> createState() => _IngredientButtonState();
}

class _IngredientButtonState extends State<IngredientButton> {
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Column(
          children: [
            ElevatedButton(
              child: Image.asset(
                'lib/assets/icons/${widget.category}/${widget.buttonName}.png',
                scale: 15,
                color: _hasBeenPressed
                    ? Colors.white.withOpacity(1)
                    : Colors.white.withOpacity(0.4),
                colorBlendMode: BlendMode.modulate,
              ),
              onPressed: () {
                setState(() {
                  _hasBeenPressed = !_hasBeenPressed;
                  if (_hasBeenPressed) {
                    widget.selectedIngedient.add(widget.buttonName);
                  } else {
                    widget.selectedIngedient.remove(widget.buttonName);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                minimumSize: Size(70, 70),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
            ),
            Text(widget.buttonName)
          ],
        ));
  }
}

class IngredientButtonForRecipeTab extends StatefulWidget {
  const IngredientButtonForRecipeTab(
      this.category, this.buttonName, this.filterIngredient, this.rmvIngredient,
      {super.key});
  final String category;
  final String buttonName;
  final Function filterIngredient;
  final Function rmvIngredient;
  @override
  State<IngredientButtonForRecipeTab> createState() =>
      _IngredientButtonForRecipeTabState();
}

class _IngredientButtonForRecipeTabState
    extends State<IngredientButtonForRecipeTab> {
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Column(
          children: [
            ElevatedButton(
              child: Image.asset(
                'lib/assets/icons/${widget.category}/${widget.buttonName}.png',
                scale: 15,
                color: _hasBeenPressed
                    ? Colors.white.withOpacity(1)
                    : Colors.white.withOpacity(0.4),
                colorBlendMode: BlendMode.modulate,
              ),
              onPressed: () {
                setState(() {
                  _hasBeenPressed = !_hasBeenPressed;
                  if (_hasBeenPressed) {
                    widget.filterIngredient(widget.buttonName);
                  } else {
                    widget.rmvIngredient(widget.buttonName);
                  }

                  // if (_hasBeenPressed) {
                  //   widget.selectedIngedient.add(widget.buttonName);
                  // } else {
                  //   widget.selectedIngedient.remove(widget.buttonName);
                  // }
                });
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                minimumSize: Size(30, 30),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
            ),
            Text(widget.buttonName)
          ],
        ));
  }
}
