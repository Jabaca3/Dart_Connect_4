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

  while (true) {
    var player = "X";
    var computer = "O";
    var player_coord = [];
    var computer_coord = [];

    while (true) {
      var move = ui.promptMove();
      --move;
      if (!myBoard.check_col_full(move)) {
        player_coord = myBoard.drop_token(move, player);
        break;
      }
    }

    if (strategies == 2) {
      computer_coord = myBoard.drop_token(myBoard.random(), computer);
      ui.showMessage("\n");
      ui.showBoard(myBoard.board);
      ui.showMessage("\n");
    } else {
      // MAKE SMART STRAT HERE
      computer_coord = myBoard.drop_token(myBoard.smart(), computer);
      ui.showMessage("\n");
      ui.showBoard(myBoard.board);
      ui.showMessage("\n");
    }

    if (myBoard.check_vertical(player, player_coord[1], 4) == "Win") {
      //ui.showBoard(myBoard.board);
      break;
    }
    if (myBoard.check_vertical(computer, computer_coord[1], 4) == "Win") {
      //ui.showBoard(myBoard.board);
      break;
    }

    // Check for computer win
  }

  //ui.showMessage("\n");

  // Respond to API
  // Get Json response and get move from request
  // Have

  // TODO:
  // Select Strategie
}
