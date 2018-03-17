class GameOfLife
  attr_reader :input_array, :number_of_iterations, :expected_state

  def initialize(input_array, number_of_iterations)
    @seed = input_array
    @number_of_iterations = number_of_iterations
    @validation_errors = []
  end

  # method to test implementation
  def test_game(seed, num_of_iterations, expected_state)
    if valid_seed? && valid_iterations?
      start_game
      last_state == expected_state
    else
      print_error_message
    end
  end

  protected

  def valid_seed?
    not_empty_seed && seed_is_non_empty_2D_array && seed_is_of_constant_size && seed_has_either_of_two_values
  end

  def valid_iterations?
    if @number_of_iterations.is_a?(Integer) && @number_of_iterations > 0
      return true
    else
      @validation_errors << "Number of iterations should be greater than 0."
      return false
    end
  end

  def not_empty_seed
    if @seed.any?
      return true
    else
      @validation_errors << "Input should be a non-empty 2D array."
      return false
    end
  end

  def seed_is_non_empty_2D_array
    if @seed.map{|row| row.is_a?(Array) && row.any? }.include? false
      @validation_errors << "Input should be a 2D array."
      return false
    else
      return true
    end
  end

  def seed_is_of_constant_size
    if @seed.map{|row| row.size}.uniq.size == 1
      return true
    else
      @validation_errors << "Input should have a consistent row size."
      return false
    end
  end

  def seed_has_either_of_two_values
    if @seed.map{|row| row.all? {|cell| cell.is_a?(Integer) && cell.between?(0,1) } }.include? false
      @validation_errors << "Input should be either 1 (live cell) or 0 (dead cell)."
      return false
    else
      return true
    end
  end

  def start_game
    @number_of_iterations.times do |state_number|
      sleep(0.2)
      process_current_state
      print_new_state(state_number)
    end
  end

  # method to find all the adjacent cell values
  def adjacent(row_index, cell_index)
    last_row, last_col = @seed.size-1, @seed.first.size-1
    ([row_index-1,0].max..[row_index+1,last_row].min).each_with_object([]) do |i, a|
      ([cell_index-1,0].max..[cell_index+1,last_col].min).each { |j| a << @seed[i][j] unless i==row_index && j==cell_index }
    end
  end

  # method to apply rules for next iteration
  def apply_rules_for(cell, row_index, cell_index, active_neighbors)
    if cell == 1 && (active_neighbors < 2 || active_neighbors > 3)
      return 0
    elsif cell == 0 && active_neighbors == 3
      return 1
    else
      return @seed[row_index][cell_index]
    end
  end

  # method to process current state and populate next state
  def process_current_state
    @next_generation = Array.new(@seed.length){Array.new(@seed[0].length)}
    @seed.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        active_neighbors = adjacent(row_index,cell_index).inject(0, :+)
        @next_generation[row_index][cell_index] = apply_rules_for(cell, row_index, cell_index, active_neighbors)
      end
    end
    @seed = @next_generation
  end

  def print_new_state(state_number)
    print "\r" + ("\e[A\e[K"*(@seed.length+1)) if state_number > 0
    print "Generation: #{state_number + 1} \n"
    puts @next_generation.map { |x| x.join(' ').gsub('1','X').gsub('0', '.') }
  end

  def last_state
    @next_generation
  end

  def print_error_message
    puts @validation_errors.uniq
  end
end

# Sample Test 1 - Oscillators
num_of_iterations = 5
seed  = [[0,1,0],[0,1,0],[0,1,0]] # oscillators - blinker
expected_state = [[0,0,0], [1,1,1], [0,0,0]]
game_of_life = GameOfLife.new(seed, num_of_iterations)
test_result = game_of_life.test_game(seed, num_of_iterations, expected_state)
puts "The test method returned #{test_result}."

# Sample Test 1 - Still Lifes
num_of_iterations = 5
seed = [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] # still lifes - block
expected_state = [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]]
game_of_life = GameOfLife.new(seed, num_of_iterations)
test_result = game_of_life.test_game(seed, num_of_iterations, expected_state)
puts "The test method returned #{test_result}."

# Sample Test 1 - Spaceships
num_of_iterations = 5
seed = [[0,0,1,0,0],[1,0,1,0,0],[0,1,1,0,0],[0,0,0,0,0],[0,0,0,0,0]] # spaceships - glider
expected_state = [[0,0,0,0,0],[0,0,1,0,0],[0,0,0,1,1],[0,0,1,1,0],[0,0,0,0,0]]
game_of_life = GameOfLife.new(seed, num_of_iterations)
test_result = game_of_life.test_game(seed, num_of_iterations, expected_state)
puts "The test method returned #{test_result}."
