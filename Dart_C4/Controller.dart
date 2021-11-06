import 'ConsoleUI.dart';
import 'WebClient.dart';
import 'dart:io';
import 'Board.dart';

void main() async {
  ConsoleUI ui = new ConsoleUI();
  WebClient webClient = new WebClient();
  Board myBoard = Board();

  /// Getting server information (Strategie)
  var server = ui.promptServer();
  ui.showMessage("Obtaining server information ......\n");
  var info = await webClient.getinfo(server);

  /// Prompting for strategie
  var selection = ui.promptStrategy();
  ui.showMessage("selected strategy: ${info["strategies"][selection]}");
  ui.showMessage("\n");

  /// Getting the board information
  ui.showMessage("Obtaining Board information");
  myBoard.col = info["width"];
  myBoard.row = info["height"];

  /// Setting the Strategie of the board
  ui.showBoard(myBoard.board);
  ui.showMessage("\n");
  myBoard.strategie = selection;

  bool game = true;
  var player = "x";
  var computer = "o";
  var player_coord = [-1, -1];
  var computer_coord = [-1, -1];

  while (game) {
    while (true) {
      /// Prompting user move
      var move = ui.promptMove();
      --move;
      if (!myBoard.check_col_full(move)) {
        player_coord = myBoard.drop_token(move, player).cast<int>();
        break;
      }
    }

    /// Checking if user Won
    if (myBoard.check_win(player, player_coord[0], player_coord[1], 4) ==
        "Win") {
      ui.showBoard(myBoard.board);
      ui.showMessage("\n");
      ui.showMessage("CONGRATS YOU WON");
      game = false;
      exit(0);
    }

    /// Random Strategie
    if (selection == 1) {
      var rand = myBoard.random();
      computer_coord = myBoard.drop_token(rand, computer).cast<int>();
    }

    /// Smart strategie
    if (selection == 0) {
      var location = myBoard.smart(
          computer, computer_coord[0], computer_coord[1], player_coord);
      computer_coord = myBoard.drop_token(location, computer).cast<int>();
    }

    /// Checking if computer won
    if (myBoard.check_win(computer, computer_coord[0], computer_coord[1], 4) ==
        "Win") {
      ui.showBoard(myBoard.board);
      ui.showMessage("\n");
      ui.showMessage("YOU LOSE :( ");
      exit(0);
    }

    /// Checking for draw
    if (myBoard.check_draw()) {
      ui.showMessage("DRAW!");
      exit(0);
    }

    /// Showing Board after moves...
    ui.showMessage("\n");
    ui.showBoard(myBoard.board);
    ui.showMessage("\n");
  }
}
