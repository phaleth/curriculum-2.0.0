defmodule CharacterTests do
  use ExUnit.Case
  alias BattleMap.Character
  alias BattleMap.Barbarian
  alias BattleMap.Wizard
  alias BattleMap.Archer

  describe "Barbarian" do
    test "can attack within two squares of current position" do
      for x <- 2..6, y <- 2..6 do
        assert Character.can_attack?(%Barbarian{}, {4, 4}, {x, y})
      end
    end

    test "cannot attack beyond two squares of current position" do
      refute Character.can_attack?(%Barbarian{}, {4, 4}, {1, 1})
      refute Character.can_attack?(%Barbarian{}, {4, 4}, {7, 7})
      refute Character.can_attack?(%Barbarian{}, {4, 4}, {7, 1})
      refute Character.can_attack?(%Barbarian{}, {4, 4}, {1, 7})
    end

    test "logic is not hardcoded to the {4, 4} position" do
      refute Character.can_attack?(%Barbarian{}, {3, 3}, {6, 6})
    end
  end

  describe "Wizard" do
    test "can attack in eight directions" do
      # up, up-right, right, down-right, down, down-left, left, up-left
      assert Character.can_attack?(%Wizard{}, {4, 4}, {4, 5})
      assert Character.can_attack?(%Wizard{}, {4, 4}, {5, 5})
      assert Character.can_attack?(%Wizard{}, {4, 4}, {5, 4})
      assert Character.can_attack?(%Wizard{}, {4, 4}, {5, 3})
      assert Character.can_attack?(%Wizard{}, {4, 4}, {4, 3})
      assert Character.can_attack?(%Wizard{}, {4, 4}, {3, 3})
      assert Character.can_attack?(%Wizard{}, {4, 4}, {3, 4})
      assert Character.can_attack?(%Wizard{}, {4, 4}, {3, 5})
    end

    test "cannot attack invalid squares" do
      refute Character.can_attack?(%Wizard{}, {4, 4}, {6, 5})
      refute Character.can_attack?(%Wizard{}, {4, 4}, {2, 5})
      refute Character.can_attack?(%Wizard{}, {4, 4}, {3, 2})
      refute Character.can_attack?(%Wizard{}, {4, 4}, {6, 3})
    end
  end

  describe "Archer" do
    test "can attack at distance of three of current position" do
      for x <- 1..7,
          y <- 1..7,
          (x === 1 and y === 1) or (x === 7 and y === 7) or (x === 1 and y === 7) or
            (x === 7 and y === 1) do
        assert Character.can_attack?(%Archer{}, {4, 4}, {x, y})
      end
    end

    test "cannot attack within inside three squares of current position" do
      refute Character.can_attack?(%Archer{}, {4, 4}, {2, 2})
      refute Character.can_attack?(%Archer{}, {4, 4}, {6, 6})
      refute Character.can_attack?(%Archer{}, {4, 4}, {6, 2})
      refute Character.can_attack?(%Archer{}, {4, 4}, {2, 6})

      refute Character.can_attack?(%Archer{}, {4, 4}, {3, 3})
      refute Character.can_attack?(%Archer{}, {4, 4}, {5, 5})
      refute Character.can_attack?(%Archer{}, {4, 4}, {5, 3})
      refute Character.can_attack?(%Archer{}, {4, 4}, {3, 5})
    end

    test "cannot attack beyond three squares of current position" do
      refute Character.can_attack?(%Archer{}, {4, 4}, {0, 0})
      refute Character.can_attack?(%Archer{}, {4, 4}, {8, 8})
      refute Character.can_attack?(%Archer{}, {4, 4}, {8, 0})
      refute Character.can_attack?(%Archer{}, {4, 4}, {0, 8})
    end

    test "logic is not hardcoded to the {4, 4} position" do
      refute Character.can_attack?(%Archer{}, {3, 3}, {8, 8})
    end
  end
end
