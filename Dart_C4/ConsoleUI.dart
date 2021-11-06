import 'dart:io';

class ConsoleUI {
  showMessage(var message) {
    stdout.write(message);
  }

  promptServer() {
    showMessage(
        "Enter the server URL [default: http://cheon.atwebpages.com/c4/info/] ");
    var line = stdin.readLineSync();
    return line;
  }

  promptStrategy() {
    showMessage("Select the server strategy: 1. Smart 2. Random [default: 1] ");
    var line = stdin.readLineSync();
    if (line == null) {
      showMessage("Invalid selection");
      return promptStrategy();
    } else {
      var selection = int.tryParse(line);
      if (selection == null) {
        ///pass
      } else if (selection > 0 && selection < 3) {
        return --selection;
      }
      showMessage("Invalid selection");
      return promptStrategy();
    }
  }

  promptMove() {
    while (true) {
      try {
        showMessage("Select a slot [1-7] ");
        var line = stdin.readLineSync();
        if (line == null) {
          ///Pass
        } else {
          var value = int.parse(line);
          if (value > 0 && value < 8) {
            return value;
          }
          showMessage("Invalid Selection: ${line}\n");
        }
      } catch (Exception) {
        showMessage("Exception Drawn, Please try again\n");
      }
    }
  }

  showBoard(var board) {
    for (var i = 0; i < 6; i++) {
      showMessage("\n");
      for (var j = 0; j < 7; j++) {
        showMessage(" ");
        showMessage(board[i][j]);
      }
    }
    showMessage("\n 1 2 3 4 5 6 7");
  }
}
