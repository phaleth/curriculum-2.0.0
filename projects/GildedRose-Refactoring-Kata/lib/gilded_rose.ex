defmodule GildedRose do
  @moduledoc """
  GidldedRose refactoring challenge.
  """

  @spec update_quality(list(map)) :: list(map)
  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_non_sulfuras_quantity(item) do
    if item.quality > 0 and item.name != "Sulfuras, Hand of Ragnaros",
      do: %{item | quality: item.quality - 1},
      else: item
  end

  defp update_item_quality(item) do
    if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" do
      update_non_sulfuras_quantity(item)
    else
      if item.quality < 50,
        do: increase_item_quality(item),
        else: item
    end
  end

  defp maybe_update_quality(item, sell_in_upper_bound) do
    if item.sell_in < sell_in_upper_bound and item.quality < 50,
      do: %{item | quality: item.quality + 1},
      else: item
  end

  defp maybe_update_sell_in(item) do
    if item.name != "Sulfuras, Hand of Ragnaros",
      do: %{item | sell_in: item.sell_in - 1},
      else: item
  end

  defp increase_item_quality(item) do
    item = %{item | quality: item.quality + 1}

    if item.name == "Backstage passes to a TAFKAL80ETC concert",
      do:
        item
        |> maybe_update_quality(11)
        |> maybe_update_quality(6),
      else: item
  end

  defp update_item_past_sell_in(item) do
    if item.name != "Aged Brie" do
      if item.name != "Backstage passes to a TAFKAL80ETC concert",
        do: update_non_sulfuras_quantity(item),
        else: %{item | quality: item.quality - item.quality}
    else
      if item.quality < 50, do: %{item | quality: item.quality + 1}, else: item
    end
  end

  @spec update_item(map) :: map
  def update_item(item) do
    item =
      item
      |> update_item_quality()
      |> maybe_update_sell_in()

    if item.sell_in < 0,
      do: update_item_past_sell_in(item),
      else: item
  end
end
