import 'dart:io';
import 'dart:math';
import 'ConsoleUI.dart';

class Board {
  int row = 6;
  int col = 7;
  var strategie = -1;

  var board = List.generate(6, (i) => List.filled(7, "."), growable: false);

  drop_token(var col, player) {
    // Check if col is full, if not place
    if (!check_col_full(col)) {
      for (int i = row - 1; i >= 0; i--) {
        if (board[i][col] == ".") {
          board[i][col] = player;
          return [i, col];
        }
      }
    }
  }

  check_col_full(var col) {
    for (int i = 0; i < col; i++) {
      if (board[0][col - 1] == "X" || board[0][col] == "O") {
        return true;
      }
    }
    return false;
  }

  random() {
    var num = Random().nextInt(this.col);
    if (!check_col_full(num)) {
      return num;
    }
    return random();
  }

  smart() {
    return 0;
  }

  check_horizontal(var player, var row, var connection) {
    // Sart on row 0 and given column 0 and check horizonatally
    var counter = 0;

    // Start checking from the left
    for (int col = 0; col < this.col; col++) {
      if (connection == 4 && connection == counter) {
        stdout.write("WINNERRE WINERE\n");
        return "Win";
      }

      // Made for Smart to find next position
      if (connection == 3 && connection == counter && col < this.col) {
        return [row, col++];
      }

      // Itterating through the board
      if (this.board[row][col] == player) {
        counter += 1;

        // Finding anything other than the player resets the connections
      } else if (this.board[row][col] != player) {
        counter = 0;
      }
    }
    counter = 0;
    // Start checking from the right
    for (int col = this.col - 1; col > 0; col--) {
      if (connection == 4 && connection == counter) {
        stdout.write("WINNERRE WINERE fadsfasdf\n");
        return "Win";
      }

      // Made for Smart to find next position
      if (connection == 3 && connection == counter && col < 0) {
        return [row, col--];
      }

      // Itterating through the board
      if (this.board[row][col] == player) {
        counter += 1;

        // Finding anything other than the player resets the connections
      } else if (this.board[row][col] != player) {
        counter = 0;
      }
    }
  }

  check_vertical(var player, var col, var connection) {
    var counter = 0;
    for (int row = 0; row < this.row; row++) {
      // Made for Smart to find next position
      if (connection == 3 && connection == counter && row < this.row) {
        return [row++, col];
      }

      // Itterating through the board
      if (this.board[row][col] == player) {
        counter++;

        if (connection == 4 && connection == counter) {
          stdout.write("WINNERRE WINERE\n");
          return "Win";
        }

        // Finding anything other than the player resets the connections
      } else if (this.board[row][col] != player) {
        counter = 0;
      }
    }
  }

  check_diagonal() {}
}
