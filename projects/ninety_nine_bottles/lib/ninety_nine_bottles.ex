defmodule NinetyNineBottles do
  def start() do
    bottle_count = 99

    Enum.map(bottle_count..1, fn bottle_num ->
      Task.Supervisor.async(MyTaskSupervisor, fn -> message(bottle_num) end)
    end)
    |> Task.await_many()
    |> Enum.each(&IO.puts(&1))
  end

  def message(num) do
    if num == 1,
      do: """
      #{num} bottle#{if(num == 1, do: "", else: "s")} of Elixir on the wall, #{num} bottle#{if(num == 1, do: "", else: "s")} of Elixir.
      Go code some more, 99 bottles of Elixir on the wall.
      """,
      else: """
      #{num} bottle#{if(num == 1, do: "", else: "s")} of Elixir on the wall, #{num} bottle#{if(num == 1, do: "", else: "s")} of Elixir.
      Take one down and pass it around, #{num - 1} bottle#{if(num == 2, do: "", else: "s")} of Elixir on the wall.
      """
  end
end
