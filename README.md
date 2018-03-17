# Conway's Game of Life

### Problem Statement
- The universe of the Game of Life is an infinite two­dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive(denoted by 1) or dead(denoted by 0). Every cell interacts with its eight neighbors, which are the cells that are horizontally, vertically, or diagonally adjacent.
- The game follows the following rules :
   - Any live cell with fewer than two live neighbors dies, as if caused by under­population.
   - Any live cell with two or three live neighbors lives on to the next generation.
   - Any live cell with more than three live neighbors dies, as if by over­population.
   - Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

### Notes
- The program is written and tested in Ruby (version: 2.1.5) using RSpec (version: 2.14.8).

### Assumption
- The code is executed using a bash terminal.

### Installation
Install Ruby : https://www.ruby-lang.org/en/documentation/installation/

Install RSpec : https://rubygems.org/gems/rspec/versions/3.4.0

### Execution
Unzip the folder and use the bash terminal to run the following command from the `game-of-life` directory:
`ruby game_of_life.rb`

The example listed in the file is for Oscillators- Blinker. It shows how the state changes with every iteration denoted by `X` (active cell) and `.` (dead cell).
num_of_iterations = 5
seed  = [[0,1,0],[0,1,0],[0,1,0]] # input array
expected_state = [[0,0,0], [1,1,1], [0,0,0]] # expected output after 5 iterations
The example also prints the result from the test_game method.

More examples are listed in the file, for still lives and spaceships. Uncomment the examples and run the file.

### Testing
To run the test cases, copy the following command to the bash terminal from the `game-of-life` directory:
`rspec spec`

