import 'dart:io';
import 'dart:math';
import 'ConsoleUI.dart';

class Board {
  int row = 6;
  int col = 7;
  var strategie = -1;

  var board = List.generate(6, (i) => List.filled(7, "."), growable: false);

  drop_token(var mycol, player) {
    // Check if col is full, if not place
    if (!check_col_full(mycol)) {
      for (int i = this.row - 1; i >= 0; i--) {
        if (board[i][mycol] == ".") {
          this.board[i][mycol] = player;
          return [i, mycol];
        }
      }
    }
    return drop_token(random(), player);
  }

  check_col_full(var mycol) {
    if (mycol >= this.col) {
      return true;
    }
    if (board[0][mycol] == "X" || board[0][mycol] == "O") {
      return true;
    }
    return false;
  }

  random() {
    var num = Random().nextInt(this.col);
    print(num);
    if (!check_col_full(num)) {
      return num;
    }
    return random();
  }

  check_win(var player, var myrow, var mycol, connections) {
    if (myrow == -1 || mycol == -1) {
      return [-1, -1];
    }

    var v1 = check_horizontal(player, myrow, connections);
    var v2 = check_vertical(player, mycol, connections);
    var v3 = check_diagonal(player, myrow, mycol, connections);

    if (v1 == "Win") {
      return v1;
    }
    if (v2 == "Win") {
      return v2;
    }
    if (v3 == "Win") {
      return v3;
    }

    if (v1[0] != -1) {
      return v1;
    }
    if (v2[0] != -1) {
      return v2;
    }
    if (v3[0] != -1) {
      return v3;
    }
    return v1;
  }

  smart(var player, var myrow, var mycol, var p_cords) {
    if (myrow == -1) {
      print("Stuck in herer haallpp");
      return random();
    }

    //Checking on how to win
    var coords = check_win(player, myrow, mycol, 3);

    if (coords[0] != -1) {
      print("GOING FOR WIN....");
      return coords[1];
    }

    //Checking on how to block
    print("Player Cords: ${p_cords} ");
    var block = check_win("X", p_cords[0], p_cords[1], 3);

    if (block[0] != -1) {
      print("GOING FOR BLOCKK....");
      return block[1];
    }

    print("GENERATING RANDOM");
    return random();
  }

  check_horizontal(var player, var myrow, var connection) {
    // Sart on myrow 0 and given column 0 and check horizonatally
    var counter = 0;

    // Start checking from the left
    for (int col = 0; col < this.col; col++) {
      // Made for Smart to find next position
      if (connection == 3 && connection == counter && col < this.col - 1) {
        return [myrow, col++];
      }
      if (counter == 2 &&
          col < this.col - 3 &&
          this.board[myrow][col + 2] == player &&
          this.board[myrow][col + 1] == ".") {
        return [myrow, col++];
      }

      // Itterating through the board
      if (this.board[myrow][col] == player) {
        counter += 1;
      }
      if (connection == 4 && connection == counter) {
        return "Win";

        // Finding anything other than the player resets the connections
      } else if (this.board[myrow][col] != player) {
        counter = 0;
      }
    }
    counter = 0;

    // Start checking from the right
    for (int mycol = this.col - 2; mycol > -1; mycol--) {
      // Itterating through the board
      if (this.board[myrow][mycol] == player) {
        counter += 1;
      }
      if (connection == 3 && connection == counter && mycol >= 1) {
        return [myrow, col--];
      }

      if (connection == 4 && connection == counter) {
        return "Win";

        // Finding anything other than the player resets the connections
      } else if (this.board[myrow][mycol] != player) {
        counter = 0;
      }
    }
    return [-1, -1];
  }

  check_vertical(var player, var mycol, var connection) {
    var counter = 0;
    for (int row = 0; row < this.row; row++) {
      // Itterating through the board
      if (this.board[row][mycol] == player) {
        counter++;

        if (connection == 3 && connection == counter && mycol < this.col) {
          return [row, mycol];
        }

        if (connection == 4 && connection == counter) {
          return "Win";
        }

        // Finding anything other than the player resets the connections
      } else if (this.board[row][mycol] != player) {
        counter = 0;
      }
    }
    return [-1, -1];
  }

  check_diagonal(var player, var myrow, var mycol, var connection) {
    var counter = 0;

    var r = myrow;
    var c = mycol;
    // top-left to bottom-right
    while (r < this.row && c < this.col) {
      if (connection == 4 && connection == counter) {
        return "Win";
      }
      if (connection == 3 &&
          connection == counter &&
          r < this.row - 2 &&
          c < this.col - 2) {
        return [r++, c++];
      }
      if (board[r][c] == player) {
        counter++;
      }
      if (board[r][c] != player) {
        counter = 0;
      }
      r++;
      c++;
    }

    r = myrow;
    c = mycol;
    counter = 0;
    // Bottom right to top left
    while (r > -1 && c > -1) {
      if (board[r][c] == player) {
        counter++;
      }
      if (connection == 3 && connection == counter && r > 0 && c > 0) {
        return [r--, c--];
      }
      if (connection == 4 && connection == counter) {
        return "Win";
      }
      if (board[r][c] != player) {
        counter = 0;
      }
      r--;
      c--;
    }

    r = myrow;
    c = mycol;
    counter = 0;
    // Top right to bottom left
    while (r < this.row && c > -1) {
      if (board[r][c] == player) {
        counter++;
      }

      if (connection == 3 &&
          connection == counter &&
          r < this.row - 2 &&
          c > 0) {
        return [r++, c--];
      }

      if (connection == 4 && connection == counter) {
        return "Win";
      }
      if (board[r][c] != player) {
        counter = 0;
      }
      r++;
      c--;
    }

    r = myrow;
    c = mycol;
    counter = 0;
    // Bottom left to top right
    while (r > -1 && c < this.col) {
      if (board[r][c] == player) {
        counter++;
      }

      if (connection == 3 &&
          connection == counter &&
          r > 0 &&
          c < this.col - 2) {
        return [r--, c++];
      }
      if (connection == 4 && connection == counter) {
        return "Win";
      }
      if (board[r][c] != player) {
        counter = 0;
      }
      r--;
      c++;
    }
    return [-1, -1];
  }
}
