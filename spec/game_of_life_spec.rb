require_relative 'spec_helper'

describe GameOfLife do
  let!(:num_of_iterations) { 5 }
  let!(:game_of_life) { GameOfLife.new(seed, num_of_iterations) }

  describe "#test_game(seed, num_of_iterations, expected_state)" do

    subject { game_of_life.test_game(seed, num_of_iterations, expected_state) }

    context "with correct expected state for Still Lifes - Block" do
      let!(:seed) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }
      let!(:expected_state) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }

      it "should return true" do
        expect(subject).to be true
      end
    end

    context "with incorrect expected state for Still Lifes - Block" do
      let!(:seed) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }
      let!(:expected_state) { [[0,1,1,0],[0,1,1,0],[0,1,1,0],[0,1,1,0]] }

      it "should return false" do
        expect(subject).to be false
      end
    end

    context "with correct expected state for Oscillators - Blinker" do
      let(:seed) { [[0,1,0],[0,1,0],[0,1,0]] }
      let(:expected_state) { [[0, 0, 0], [1, 1, 1], [0, 0, 0]] }

      it "should return true" do
        expect(subject).to be true
      end
    end

    context "with incorrect expected state for Oscillators - Blinker" do
      let(:seed) { [[0,1,0],[0,1,0],[0,1,0]] }
      let(:expected_state) { [[1, 1, 1], [1, 1, 1], [0, 0, 0]] }

      it "should return false" do
        expect(subject).to be false
      end
    end

    context "with correct expected state for Spaceships - Glider" do
      let(:seed) { [[0,0,1,0,0],[1,0,1,0,0],[0,1,1,0,0],[0,0,0,0,0],[0,0,0,0,0]] }
      let(:expected_state) { [[0,0,0,0,0],[0,0,1,0,0],[0,0,0,1,1],[0,0,1,1,0],[0,0,0,0,0]] }

      it "should return true" do
        expect(subject).to be true
      end
    end

    context "with incorrect expected state for Spaceships - Glider" do
      let(:seed) { [[0,0,1,0,0],[1,0,1,0,0],[0,1,1,0,0],[0,0,0,0,0],[0,0,0,0,0]] }
      let(:expected_state) { [[0,0,0,0,0],[0,0,1,0,0],[0,0,0,1,1],[0,0,1,1,0],[0,1,1,1,0]] }

      it "should return false" do
        expect(subject).to be false
      end
    end

    context "with empty seed" do
      let(:seed) { [] }
      let(:expected_state) { [] }

      it "should call method to print validation errors" do
        expect(game_of_life).to receive(:print_error_message)
        subject
      end
    end
  end

  describe "#valid_seed?" do

    subject { game_of_life.send(:valid_seed?) }

    context "with valid input" do
      let!(:seed) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }

      it "should return true" do
        expect(subject).to be true
      end
    end

    context "with invalid input" do
      let!(:seed) { [[0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }

      it "should return false" do
        expect(subject).to be false
      end
    end
  end

  describe "#valid_iterations?" do
    let!(:seed) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }

    subject { game_of_life.send(:valid_iterations?) }

    context "with valid input" do

      it "should return true" do
        expect(subject).to be true
      end
    end

    context "with invalid input" do
      let!(:num_of_iterations) { 0 }

      it "should return false" do
        expect(subject).to be false
      end
    end
  end

  describe "#not_empty_seed" do

    subject { game_of_life.send(:not_empty_seed) }

    context "with empty seed" do
      let!(:seed) { [] }

      it "should return false" do
        expect(subject).to be false
      end
    end

    context "with non-empty seed" do
      let!(:seed) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }

      it "should return true" do
        expect(subject).to be true
      end
    end
  end

  describe "#seed_is_non_empty_2D_array" do

    subject { game_of_life.send(:seed_is_non_empty_2D_array) }

    context "with empty 2D array" do
      let!(:seed) { [[], []] }

      it "should return false" do
        expect(subject).to be false
      end
    end

    context "with empty 2D array" do
      let!(:seed) { [[1,0,1], []] }

      it "should return false" do
        expect(subject).to be false
      end
    end

    context "with non empty 2D array" do
      let!(:seed) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }

      it "should return true" do
        expect(subject).to be true
      end
    end
  end

  describe "#seed_is_of_constant_size" do

    subject { game_of_life.send(:seed_is_of_constant_size) }

    context "with inconsistent row size" do
      let!(:seed) { [[1,0,1], [1,0,1,1]] }

      it "should return false" do
        expect(subject).to be false
      end
    end

    context "with consistent row size" do
      let!(:seed) { [[0,0,0],[0,1,0],[0,1,0],[0,0,0]] }

      it "should return true" do
        expect(subject).to be true
      end
    end
  end

  describe "#seed_has_either_of_two_values" do

    subject { game_of_life.send(:seed_has_either_of_two_values) }

    context "with inputs other than 0 and 1" do
      let!(:seed) { [[1,2,1], [4,-1,1]] }

      it "should return false" do
        expect(subject).to be false
      end
    end

    context "with inputs either 0 or 1" do
      let!(:seed) { [[0,0,0],[0,1,0],[0,1,0],[0,0,0]] }

      it "should return true" do
        expect(subject).to be true
      end
    end
  end

  describe "#adjacent(row_index, cell_index)" do
    let!(:seed) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }

    subject { game_of_life.send(:adjacent, 1,1) }

    it "should return all adjacent cell values" do
      expect(subject).to eq [0,0,0,0,1,0,1,1]
    end
  end

  describe "#apply_rules_for(cell, row_index, cell_index, active_neighbors)" do
    let!(:seed) { [[0,0,0,0],[0,1,1,0],[0,1,1,0],[0,0,0,0]] }

    subject { game_of_life.send(:apply_rules_for,1,1,1,3) }

    it "should return 1" do
      expect(subject).to eq 1
    end
  end

  describe "#process_current_state" do
    let(:seed) { [[0,0,0],[1,1,1],[0,0,0]] }

    subject { game_of_life.send(:process_current_state) }

    it "should update seed with the new state" do
      expect(subject).to eq [[0,1,0],[0,1,0],[0,1,0]]
    end
  end
end
