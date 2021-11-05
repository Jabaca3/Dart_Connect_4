import 'ConsoleUI.dart';
import 'WebClient.dart';
import 'dart:io';
import 'Board.dart';

void main() async {
  ConsoleUI ui = new ConsoleUI();
  WebClient webClient = new WebClient();
  Board myBoard = Board();

  // Getting server information (Strategie)
  var server = ui.promptServer();
  ui.showMessage("Obtaining server informaion ......\n");
  var strategies = await webClient.getinfo(server);

  // Prompting for strategie
  var selection = ui.promptStrategy();
  ui.showMessage("selected strategy: ${strategies[selection]}");

  // Setting the Strategie of the board
  ui.showBoard(myBoard.board);
  ui.showMessage("\n");
  myBoard.strategie = selection;

  print(selection);

  bool game = true;

  var player = "X";
  var computer = "O";
  var player_coord = [-1, -1];
  var computer_coord = [-1, -1];

  while (game) {
    while (true) {
      // Prompting user move
      var move = ui.promptMove();
      --move;
      if (!myBoard.check_col_full(move)) {
        player_coord = myBoard.drop_token(move, player).cast<int>();
        break;
      }
    }
    // Checking if user Won
    if (myBoard.check_win(player, player_coord[0], player_coord[1], 4) ==
        "Win") {
      ui.showBoard(myBoard.board);
      game = false;
      exit(0);
    }

    // Calculting random variation
    if (selection == 1) {
      var rand = myBoard.random();
      computer_coord = myBoard.drop_token(rand, computer).cast<int>();

      // Checking if computer won
      if (myBoard.check_win(
              computer, computer_coord[0], computer_coord[1], 4) ==
          "Win") {
        ui.showBoard(myBoard.board);
        exit(0);
      }
    } else if (selection == 0) {
      // MAKE SMART STRAT HERE
      var location = myBoard.smart(
          computer, computer_coord[0], computer_coord[1], player_coord);

      computer_coord = myBoard.drop_token(location, computer).cast<int>();
      print(computer_coord);

      // Checking if computer won
      if (myBoard.check_win(
              computer, computer_coord[0], computer_coord[1], 4) ==
          "Win") {
        ui.showBoard(myBoard.board);
        exit(0);
      }
    }

    // Showing Board after moves...
    ui.showMessage("\n");
    ui.showBoard(myBoard.board);
    ui.showMessage("\n");
  }
}
