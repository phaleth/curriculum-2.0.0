defmodule GildedRose do
  @moduledoc """
  GidldedRose refactoring challenge.
  """

  @spec update_quality(list(map)) :: list(map)
  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  @spec update_item(map) :: map
  def update_item(item) do
    item =
      if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" do
        if item.quality > 0 and item.name != "Sulfuras, Hand of Ragnaros",
          do: %{item | quality: item.quality - 1},
          else: item
      else
        if item.quality < 50 do
          item = %{item | quality: item.quality + 1}

          if item.name == "Backstage passes to a TAFKAL80ETC concert" do
            item =
              if item.sell_in < 11 and item.quality < 50,
                do: %{item | quality: item.quality + 1},
                else: item

            if item.sell_in < 6 and item.quality < 50,
              do: %{item | quality: item.quality + 1},
              else: item
          else
            item
          end
        else
          item
        end
      end

    item =
      if item.name != "Sulfuras, Hand of Ragnaros",
        do: %{item | sell_in: item.sell_in - 1},
        else: item

    if item.sell_in < 0 do
      if item.name != "Aged Brie" do
        if item.name != "Backstage passes to a TAFKAL80ETC concert" do
          if item.quality > 0 and item.name != "Sulfuras, Hand of Ragnaros",
            do: %{item | quality: item.quality - 1},
            else: item
        else
          %{item | quality: item.quality - item.quality}
        end
      else
        if item.quality < 50, do: %{item | quality: item.quality + 1}, else: item
      end
    else
      item
    end
  end
end
