defmodule Pokelixir do
  @moduledoc """
  Documentation for `Pokelixir`.
  """
  @pokeapi_root_url "https://pokeapi.co/api/v2/pokemon"

  @doc """
  Get a pokemon by name

  ## Examples

      iex> Pokelixir.get("charizard")
      %Pokemon{
        id: 6,
        name: "charizard",
        hp: 78,
        attack: 84,
        defense: 78,
        special_attack: 109,
        special_defense: 85,
        speed: 100,
        height: 17,
        weight: 905,
        types: ["fire", "flying"]
      }

  """
  def get(name) do
    response =
      Finch.build(:get, "#{@pokeapi_root_url}/#{name}")
      |> Finch.request!(MyFinch)

    result = Jason.decode!(response.body)

    %Pokemon{
      id: result["id"],
      name: Enum.at(result["forms"], 0)["name"],
      hp: Enum.at(result["stats"], 0)["base_stat"],
      attack: Enum.at(result["stats"], 1)["base_stat"],
      defense: Enum.at(result["stats"], 2)["base_stat"],
      special_attack: Enum.at(result["stats"], 3)["base_stat"],
      special_defense: Enum.at(result["stats"], 4)["base_stat"],
      speed: Enum.at(result["stats"], 5)["base_stat"],
      height: result["height"],
      weight: result["weight"],
      types: Enum.map(result["types"], fn elem -> elem["type"]["name"] end)
    }
  end

  def all() do
    # offset = 0
    # url = "https://pokeapi.co/api/v2/pokemon?offset=#{offset}&limit=20"

    # result["results"]

    # Enum.reduce_while(1..100, 0, fn x, acc ->
    #  if x < 5, do: {:cont, acc + x}, else: {:halt, acc}
    # end)
    Enum.reduce_while(0..1999//20, [], fn offset, acc ->
      Process.sleep(2500)

      response =
        Finch.build(:get, "#{@pokeapi_root_url}?offset=#{offset}&limit=20")
        |> Finch.request!(MyFinch)

      result = Jason.decode!(response.body)

      if result["results"] == [], do: {:halt, acc}, else: {:cont, acc ++ result["results"]}
    end)
    |> Enum.map(fn each ->
      Process.sleep(2500)

      get(Map.get(each, "name"))
      |> IO.inspect()
    end)
  end
end
