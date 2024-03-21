#include <iostream>
#include "game.h"

using namespace std;

int main() {
    cout << "Welcome to program \"Vinnie the Pooh and the Vengeful Bees\"!" << endl;
    bool exit = false;
    while (!exit) {
        startGame();

        cout << "Would you like to try again? [Y/N] ";
        string response;
        cin >> response;
        exit = response == "N" || response == "n";
    }
}
