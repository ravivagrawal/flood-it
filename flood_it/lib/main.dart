import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'frame.dart';
import 'functions.dart';

void main() => runApp(MyApp()); // main function, runs the app

Map<int, Color> color = {
  // settting the theme for the app
  50: Color.fromRGBO(87, 87, 87, .1),
  100: Color.fromRGBO(87, 87, 87, .2),
  200: Color.fromRGBO(87, 87, 87, .3),
  300: Color.fromRGBO(87, 87, 87, .4),
  400: Color.fromRGBO(87, 87, 87, .5),
  500: Color.fromRGBO(87, 87, 87, .6),
  600: Color.fromRGBO(87, 87, 87, .7),
  700: Color.fromRGBO(87, 87, 87, .8),
  800: Color.fromRGBO(87, 87, 87, .9),
  900: Color.fromRGBO(87, 87, 87, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF575757, color);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: MyHomePage(title: 'Flood It !'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _autoclicked =
      0; // this variable is used to start and stop the Greedy algo on click of AUTO button
  int _size = 0;
  int _theme = 0;
  List<String> themeName = ['Default', 'Chocolate', 'Leaf', 'Ocean'];
  List<int> sizes = [7, 14, 21, 28];
  var _grid; //contains the grid
  var _chain; //contains the chain
  var _rgrid; //for resetting grid
  var _rchain; //for resetting chain
  int steps;
  final List<List<Color>> themes = [
    //this contains the various themes
    [
      Colors.blue,
      Colors.red,
      Colors.white,
      Colors.orange,
      Colors.yellow,
      Colors.green
    ],
    [
      Colors.brown[800],
      Colors.brown[600],
      Colors.brown[50],
      Colors.brown[200],
      Colors.brown[400],
      Colors.amber[900]
    ],
    [
      Colors.yellow[800],
      Colors.green[600],
      Colors.green[50],
      Colors.green[200],
      Colors.yellow[400],
      Colors.green[900]
    ],
    [
      Colors.green[200],
      Colors.blue[600],
      Colors.blue[50],
      Colors.blue[200],
      Colors.blue[400],
      Colors.blue[900]
    ]
  ];
  void copyarray(var og, var copy) {
    //This function copies the values of elements of array og into the array copy
    int i, j;
    for (i = 0; i < sizes[_size]; i++)
      for (j = 0; j < sizes[_size]; j++) copy[i][j] = og[i][j];
  }

  int length(var chain) {
    //This function returns the length of the chain, that is the number of 1's
    int c = 0;
    int i, j;
    for (i = 0; i < sizes[_size]; i++)
      for (j = 0; j < sizes[_size]; j++) if (chain[i][j] == 1) c++;
    return c;
  }

  bool done(var chain) {
    // This returns true, if the grid is completely flooded and false if not
    int i, j;
    bool flag = true;
    for (i = 0; i < sizes[_size]; i++)
      for (j = 0; j < sizes[_size]; j++) if (chain[i][j] == 0) flag = false;
    return flag;
  }

  void _update(int c) {
    // This function makes the changes in _grid and _chain paramenters according to the choice (c)
    if (c != _grid[0][0] && !done(_chain)) steps++;
    int i, j;
    bool flag = false;
    List<List<int>> chain = (List.generate(
        sizes[_size], (_) => List.generate(sizes[_size], (_) => 0)));

    List<List<int>> grid = (List.generate(
        sizes[_size], (_) => List.generate(sizes[_size], (_) => 0)));

    copyarray(_grid, grid);
    copyarray(_chain, chain);
    for (i = 0; i < sizes[_size]; i++)
      for (j = 0; j < sizes[_size]; j++)
        if (chain[i][j] == 1) {
          grid[i][j] = c;
        }

    do {
      flag = false;
      for (i = 0; i < sizes[_size]; i++) {
        for (j = 0; j < sizes[_size]; j++) {
          if (chain[i][j] == 1) {
            if (i - 1 >= 0) {
              if (grid[i - 1][j] == c && chain[i - 1][j] != 1) {
                chain[i - 1][j] = 1;
                flag = true;
              }
            }
            if (j - 1 >= 0) {
              if (grid[i][j - 1] == c && chain[i][j - 1] != 1) {
                chain[i][j - 1] = 1;
                flag = true;
              }
            }
            if (j + 1 < sizes[_size]) {
              if (grid[i][j + 1] == c && chain[i][j + 1] != 1) {
                chain[i][j + 1] = 1;
                flag = true;
              }
            }
            if (i + 1 < sizes[_size]) {
              if (grid[i + 1][j] == c && chain[i + 1][j] != 1) {
                chain[i + 1][j] = 1;
                flag = true;
              }
            }
          }
        }
      }
    } while (flag);
    setState(() {
      copyarray(grid, _grid);
      copyarray(chain, _chain);
    });
  }

  void _generateGrid() {
    //This funcitons generates a random grid array of size n
    setState(() {
      var rng = Random();
      var m = sizes[_size];
      _grid =
          (List.generate(m, (_) => List.generate(m, (_) => rng.nextInt(6))));
      _chain = (List.generate(m, (_) => List.generate(m, (_) => 0)));
      _rgrid = (List.generate(m, (_) => List.generate(m, (_) => 0)));
      _rchain = (List.generate(m, (_) => List.generate(m, (_) => 0)));
      if (_chain != null && _grid != null) {
        _chain[0][0] = 1;
        _rchain[0][0] = 1;
        steps = 0;
        _update(_grid[0][0]);
        copyarray(_grid, _rgrid);
        copyarray(_chain, _rchain);
      }
    });
  }

  void _sizeChange() {
    //Function for changing size
    setState(() {
      _size = (_size + 1) % 4;
      print(_size);
      print(sizes[_size]);
      _generateGrid();
    });
  }

  void _themeChange() {
    //Function for changing theme
    setState(() {
      _theme = (_theme + 1) % 4;
    });
  }

  void reset() {
    //Fucntion for resetting to the same grid
    setState(() {
      copyarray(_rgrid, _grid);
      copyarray(_rchain, _chain);
      // var i, j;
      // for (i = 0; i < sizes[_size]; i++)
      //   for (j = 0; j < sizes[_size]; j++) _chain[i][j] = 0;
      // _chain[0][0] = 1;
      steps = 0;
      // _update(_grid[0][0]);
    });
  }

  Future<void> solve() async {
    //Button that calls nextStep (Greedy algo) till the auto button is clicked again or till the grid id completely flooded
    if (done(_chain)) _autoclicked = 1;
    _autoclicked++;
    if (_autoclicked % 2 == 1) {
      do {
        var c = Functions.nextStep(_grid, _chain, sizes[_size]);
        _update(c);
        await new Future.delayed(const Duration(milliseconds: 500));
      } while (!done(_chain) && (_autoclicked % 2 == 1));
      if (done(_chain)) _autoclicked = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_grid == null || _chain == null || _rgrid == null || _rchain == null) {
      _generateGrid();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Theme:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                RaisedButton(
                  color: themes[_theme][1],
                  onPressed: _themeChange,
                  child: Text(
                    themeName[_theme],
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                ),
                Text(
                  'Size:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                RaisedButton(
                  color: themes[_theme][1],
                  onPressed: _sizeChange,
                  child: Text(
                    sizes[_size].toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Steps: ' +
                      steps.toString() +
                      '/' +
                      Functions.max(_rgrid, _rchain, sizes[_size]).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.width / 6) * 0.65,
                  width: (MediaQuery.of(context).size.width / 6) * 0.65,
                  child: RaisedButton(
                    onPressed: () => {_update(0)},
                    color: themes[_theme][0],
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width / 6) * 0.65,
                  width: (MediaQuery.of(context).size.width / 6) * 0.65,
                  child: RaisedButton(
                    onPressed: () => {_update(1)},
                    color: themes[_theme][1],
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width / 6) * 0.65,
                  width: (MediaQuery.of(context).size.width / 6) * 0.65,
                  child: RaisedButton(
                    onPressed: () => {_update(2)},
                    color: themes[_theme][2],
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width / 6) * 0.65,
                  width: (MediaQuery.of(context).size.width / 6) * 0.65,
                  child: RaisedButton(
                    onPressed: () => {_update(3)},
                    color: themes[_theme][3],
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width / 6) * 0.65,
                  width: (MediaQuery.of(context).size.width / 6) * 0.65,
                  child: RaisedButton(
                    onPressed: () => {_update(4)},
                    color: themes[_theme][4],
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width / 6) * 0.65,
                  width: (MediaQuery.of(context).size.width / 6) * 0.65,
                  child: RaisedButton(
                    onPressed: () => {_update(5)},
                    color: themes[_theme][5],
                  ),
                ),
              ],
            ),
            Grid(sizes[_size], _grid, themes[_theme]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.width / 6) * 0.65,
                  width: (MediaQuery.of(context).size.width / 6) * 0.65 * 3,
                  child: RaisedButton(
                    child: Text(
                      'AUTO',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: solve,
                    color: themes[_theme][1],
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width / 6) * 0.65,
                  width: (MediaQuery.of(context).size.width / 6) * 0.65 * 3,
                  child: RaisedButton(
                    child: Text(
                      'RESET',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: reset,
                    color: themes[_theme][1],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateGrid,
        tooltip: 'New Game',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
