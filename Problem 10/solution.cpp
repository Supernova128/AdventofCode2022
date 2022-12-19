#include <cstdio>
#include <cstring>
#include <fstream>
#include <iostream>
#include <pthread.h>
#include <string>
#include <cmath>

using namespace std;

int cycle = 0;

int reg = 1;

int signal_strength = 0;

int screen[40][6] = { 0 };

void draw_pixel();

void handle_instruct(string p);

void noop();

void addx(string n);

void signal_strength_add();

void print_screen();

int main() {
  fstream instructs;
  instructs.open("input.txt", ios::in);
  if (instructs.is_open()) {
    string instruct;
    while (getline(instructs, instruct)) {
      handle_instruct(instruct);
    }
  }
  instructs.close();
  cout << signal_strength << endl;
  print_screen();
}

void handle_instruct(string p) {
  if (p == "noop") {
    noop();
  } else {
    string amount = p.substr(5);
    addx(amount);
  }
};

void signal_strength_add() {
  if (cycle % 40 == 20) {
    signal_strength += reg * cycle;
  }
  draw_pixel();
};

void draw_pixel() {
    if ((cycle - 1) % 40 <= reg + 1 && (cycle-1) % 40 >= reg - 1  ){
        screen[(cycle - 1) % 40][(int)floor((cycle -1)/ 40)] = 1;
    }
}

void noop() {
  cycle += 1;
  signal_strength_add();
};

void addx(string n) {
  cycle += 1;
  signal_strength_add();
  cycle += 1;
  signal_strength_add();
  reg += stoi(n);
}


void print_screen(){
    for (int j = 0; j< 6; j++){
        for (int i = 0; i< 40; i++){
            if (screen[i][j] == 1){
                printf("\u2588"); // Uses unicode character for black square instead
            }
            else {
                printf(" ");
            }
        }
        printf("\n");
    }

}



