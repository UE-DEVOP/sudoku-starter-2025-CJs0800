import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:sudoku_starter/GrilleInterne.dart';
import 'package:sudoku_api/src/Puzzle.dart';

class Game extends StatefulWidget {
  const Game({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 0;
  Puzzle? puzzle;
  int? selectedRow;
  int? selectedCol;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  @override
  void initState() {
    super.initState();
    generatePuzzle();
  }

  Future<void> generatePuzzle() async{
    PuzzleOptions puzzleOptions = new PuzzleOptions(patternName: "winter");
    Puzzle puzzle = new Puzzle(puzzleOptions);
    await puzzle.generate();
    setState(() {
      this.puzzle = puzzle;
    });
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 2;
    var width = MediaQuery.of(context).size.width;
    var maxSize = height > width ? width : height;
    var boxSize = (maxSize / 3).ceil().toDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            SizedBox(
              width: boxSize*3,
              height: boxSize*3,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(9, (x) {
                  return Container(
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),

                    child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(9, (y) {
                        int val = puzzle?.board()?.matrix()?[x][y]?.getValue() ?? 0;
                        bool isSelected = selectedRow == x && selectedCol == y;
                        return InkWell(
                            onTap: () {
                              setState(() {
                                selectedRow = x;
                                selectedCol = y;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 0.3),
                                  color: isSelected ? Colors.blueAccent.shade100.withAlpha(100) : Colors.transparent
                              ),
                              child: Center(child: Text(val == 0 ? '' : val.toString())),
                            ),
                        );
                      }),
                    )
                  );
                }),
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
