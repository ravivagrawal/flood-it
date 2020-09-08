import 'package:flutter/material.dart';

class Rows extends StatelessWidget {
  final int n;
  final List<int> grid;
  final List<Color> theme;
  Rows(this.n, this.grid, this.theme);

/*This return the Row widget which is a row containing n container such that is fits the size of the screen, according to the array of number and the theme*/

  void function() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var i = 0; i < n; i++)
            Container(
              // margin: EdgeInsets.all(
              //     ((((MediaQuery.of(context).size.width) / n) * .048) <
              //             (((MediaQuery.of(context).size.height) / n) * .048)
              //         ? (((MediaQuery.of(context).size.width) / n) * .048)
              //         : (((MediaQuery.of(context).size.height) / n) * .048))),
              width: (((MediaQuery.of(context).size.width) / n)) <
                      (((MediaQuery.of(context).size.height) / n) * .55)
                  ? (((MediaQuery.of(context).size.width) / n))
                  : (((MediaQuery.of(context).size.height) / n) * .55),
              height: (((MediaQuery.of(context).size.width) / n)) <
                      (((MediaQuery.of(context).size.height) / n) * .55)
                  ? (((MediaQuery.of(context).size.width) / n))
                  : (((MediaQuery.of(context).size.height) / n) * .55),

              child: null,
              color: theme[grid[i]],
            )
        ],
      ),
    );
  }
}
