import 'package:flutter/material.dart';

import 'rows.dart';

/*This is contains the Grid widget, which is used to generate the grid based on the array of numbers and the theme, it is basically a coloumn having n rows, the rows widget is in the rows.dart file*/

class Grid extends StatelessWidget {
  final int n;
  final List<List<int>> grid;
  final List<Color> theme;
  Grid(this.n, this.grid, this.theme);
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var i = 0; i < n; i++) Rows(n, grid[i], theme),
        ],
      ),
    );
  }
}
