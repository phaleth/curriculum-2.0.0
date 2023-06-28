defmodule GildedRoseTest do
  use ExUnit.Case

  test "begin the journey of refactoring" do
    items = [%Item{name: "foo", sell_in: 0, quality: 0}]
    GildedRose.update_quality(items)
    %{name: first_item_name} = List.first(items)
    assert "foo" === first_item_name
  end

  test "example code test" do
    items =
      GildedRose.update_quality([
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}
      ])

    expected = [
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
    ]

    assert items === expected
  end
end
