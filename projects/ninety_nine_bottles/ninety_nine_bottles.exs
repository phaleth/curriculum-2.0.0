# defmodule NinetyNineBottles do
#   def start() do
#     bottle_count = 99

#     Enum.each(bottle_count..1, fn bottle_num ->
#       case bottle_num do
#         1 -> IO.puts("""
#         1 bottle of Elixir on the wall, 1 bottle of Elixir.
#         Go code some more, 99 bottles of Elixir on the wall.
#         """)

#         num -> IO.puts("""
#         #{num} bottles of Elixir on the wall, #{num} bottles of Elixir.
#         Take one down and pass it around, #{num - 1} bottle#{if(num == 2, do: "", else: "s")} of Elixir on the wall.
#         """)
#       end
#     end)
#   end
# end

defmodule NinetyNineBottles do
  def start() do
    bottle_count = 99

    Enum.each(bottle_count..1, fn bottle_num -> spawn(__MODULE__, :compose, [bottle_num]) end)
  end

  def compose(num) do
    IO.puts("#{num} bottle#{if(num == 1, do: "", else: "s")} of Elixir on the wall, #{num} bottle#{if(num == 1, do: "", else: "s")} of Elixir.")
    if num == 1,
      do: IO.puts("Go code some more, 99 bottles of Elixir on the wall."),
      else: IO.puts("Take one down and pass it around, #{num - 1} bottle#{if(num == 2, do: "", else: "s")} of Elixir on the wall.")
    IO.puts("")
  end
end

NinetyNineBottles.start()
