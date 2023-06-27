defmodule Greeting do
  def main(args) do
    {opts, _word, _errors} = OptionParser.parse(args, switches: [time: :string, upcase: :boolean])
    msg = "Good #{opts[:time] || "morning"}!"
    msg = if opts[:upcase], do: String.upcase(msg), else: msg
    IO.puts(msg)
  end
end
