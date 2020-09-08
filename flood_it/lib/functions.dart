/*This file conatins the various misc functions */

class Functions {
  static void copyarray(var og, var copy, var size) {
    //This function copies the values of elements of array og into the array copy
    int i, j;
    for (i = 0; i < size; i++) for (j = 0; j < size; j++) copy[i][j] = og[i][j];
  }

  static int length(var chain, var size) {
    //This function returns the length of the chain, that is the number of 1's
    int c = 0;
    int i, j;
    for (i = 0; i < size; i++)
      for (j = 0; j < size; j++) if (chain[i][j] == 1) c++;
    return c;
  }

  static bool done(var chain, var size) {
    // This returns true, if the grid is completely flooded and false if not
    int i, j;
    bool flag = true;
    for (i = 0; i < size; i++)
      for (j = 0; j < size; j++) if (chain[i][j] == 0) flag = false;
    return flag;
  }

  static void update(var grid, var chain, var c, var size) {
    // This function makes the changes in grid and chain paramenters according to the choice (c)
    int i, j;
    bool flag = false;
    for (i = 0; i < size; i++)
      for (j = 0; j < size; j++)
        if (chain[i][j] == 1) {
          grid[i][j] = c;
        }

    do {
      flag = false;
      for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
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
            if (j + 1 < size) {
              if (grid[i][j + 1] == c && chain[i][j + 1] != 1) {
                chain[i][j + 1] = 1;
                flag = true;
              }
            }
            if (i + 1 < size) {
              if (grid[i + 1][j] == c && chain[i + 1][j] != 1) {
                chain[i + 1][j] = 1;
                flag = true;
              }
            }
          }
        }
      }
    } while (flag);
  }

  static int nextStep(var grid, var chain, var size) {
    // This funciton uses Greedy Algorithm to return the valuie of the next best step
    List<List<int>> copyChain =
        (List.generate(size, (_) => List.generate(size, (_) => 0)));
    int i;
    List<List<int>> copyGrid =
        (List.generate(size, (_) => List.generate(size, (_) => 0)));
    copyarray(chain, copyChain, size);
    copyarray(grid, copyGrid, size);
    int max = 0;
    int mp = 0;
    List<List<int>> ccc =
        (List.generate(size, (_) => List.generate(size, (_) => 0)));
    List<List<int>> ccg =
        (List.generate(size, (_) => List.generate(size, (_) => 0)));
    for (i = 0; i < 6; i++) {
      copyarray(copyChain, ccc, size);
      copyarray(copyGrid, ccg, size);
      update(ccg, ccc, i, size);
      int increase = length(ccc, size) - length(copyChain, size);
      if (increase > max) {
        max = increase;
        mp = i;
      }
    }
    return mp;
  }

  static int max(var grid, var chain, var size) {
    // This funciton calls nextStep function till the chain is done and hence returns the minimum number of steps to complete the grid using Greedy algo
    List<List<int>> copyChain =
        (List.generate(size, (_) => List.generate(size, (_) => 0)));
    int i;
    List<List<int>> copyGrid =
        (List.generate(size, (_) => List.generate(size, (_) => 0)));
    copyarray(chain, copyChain, size);
    copyarray(grid, copyGrid, size);
    int steps = 0;
    do {
      int max = 0;
      int mp = 0;
      List<List<int>> ccc =
          (List.generate(size, (_) => List.generate(size, (_) => 0)));
      List<List<int>> ccg =
          (List.generate(size, (_) => List.generate(size, (_) => 0)));
      for (i = 0; i < 6; i++) {
        copyarray(copyChain, ccc, size);
        copyarray(copyGrid, ccg, size);
        update(ccg, ccc, i, size);
        int increase = length(ccc, size) - length(copyChain, size);
        if (increase > max) {
          max = increase;
          mp = i;
        }
      }
      update(copyGrid, copyChain, mp, size);
      steps++;
    } while (!done(copyChain, size));
    return steps;
  }
}
