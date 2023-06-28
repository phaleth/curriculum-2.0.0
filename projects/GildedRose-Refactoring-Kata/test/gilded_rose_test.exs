defmodule GildedRoseTest do
  use ExUnit.Case

  test "begin the journey of refactoring" do
    items = [%Item{name: "foo", sell_in: 0, quality: 0}]
    GildedRose.update_quality(items)
    %{name: first_item_name} = List.first(items)
    assert "foo" === first_item_name
  end

  test "Once the sell by date has passed, Quality degrades twice as fast" do
    updated_items =
      GildedRose.update_quality([
        %Item{name: "normal", sell_in: 9, quality: 1},
        %Item{name: "normal", sell_in: 0, quality: 1},
        %Item{name: "normal", sell_in: -1, quality: 1}
      ])

    assert Enum.all?(updated_items, &(&1.quality === 0))
  end

  test "The Quality of an item is never negative" do
    updated_items =
      GildedRose.update_quality([
        %Item{name: "normal", sell_in: 0, quality: 2},
        %Item{name: "normal", sell_in: -1, quality: 2}
      ])

    assert Enum.all?(updated_items, &(&1.quality === 0))
  end

  test "\"Aged Brie\" actually increases in Quality the older it gets" do
    updated_items =
      GildedRose.update_quality([
        %Item{name: "Aged Brie", sell_in: 0, quality: 2},
        %Item{name: "Aged Brie", sell_in: -1, quality: 2}
      ])

    assert Enum.all?(updated_items, &(&1.quality === 4))
  end

  test "The Quality of an item is never more than 50" do
    updated_items =
      GildedRose.update_quality([
        %Item{name: "Aged Brie", sell_in: 9, quality: 50},
        %Item{name: "Aged Brie", sell_in: 0, quality: 50},
        %Item{name: "Aged Brie", sell_in: -1, quality: 50}
      ])

    assert Enum.all?(updated_items, &(&1.quality === 50))
  end

  @tag :skip
  test "\"Sulfuras\", being a legendary item, never has to be sold or decreases in Quality" do
    updated_items =
      GildedRose.update_quality([
        %Item{name: "Sulfuras", sell_in: 9, quality: 80},
        %Item{name: "Sulfuras", sell_in: 0, quality: 80},
        %Item{name: "Sulfuras", sell_in: -1, quality: 80}
      ])

    assert Enum.all?(updated_items, &(&1.quality === 80))
  end

  @tag :skip
  test "\"Backstage passes\", like aged brie, increases in Quality as its SellIn value approaches"

  test "Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less" do
    items =
      GildedRose.update_quality([
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}
      ])

    expected = [
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
    ]

    assert items === expected
  end

  @tag :skip
  test "Quality drops to 0 after the concert"
end
