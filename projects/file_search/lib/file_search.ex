defmodule FileSearch do
  @moduledoc """
  Documentation for FileSearch
  """

  def main(args) do
    if Enum.member?(args, "--by_type"),
      do: by_extension(".") |> IO.inspect(),
      else: Enum.join(["[", all(".") |> Enum.map_join(", ", &"\"#{&1}\""), "]"]) |> IO.puts()
  end

  @doc """
  Find all nested files.

  For example, given the following folder structure
  /main
    /sub1
      file1.txt
    /sub2
      file2.txt
    /sub3
      file3.txt
    file4.txt

  It would return:

  ["file1.txt", "file2.txt", "file3.txt", "file4.txt"]
  """
  def all(folder) do
    Path.wildcard(Path.join(folder, "**/*.*"))
    |> Enum.map(&(String.split(&1, "/") |> List.last()))
    |> Enum.sort()
  end

  @doc """
  Find all nested files and categorize them by their extension.

  For example, given the following folder structure
  /main
    /sub1
      file1.txt
      file1.png
    /sub2
      file2.txt
      file2.png
    /sub3
      file3.txt
      file3.jpg
    file4.txt

  The exact order and return value are up to you as long as it finds all files
  and categorizes them by file extension.

  For example, it might return the following:

  %{
    ".txt" => ["file1.txt", "file2.txt", "file3.txt", "file4.txt"],
    ".png" => ["file1.png", "file2.png"],
    ".jpg" => ["file3.jpg"]
  }
  """
  def by_extension(folder) do
    all(folder)
    |> Enum.reduce(%{}, fn file_name, acc ->
      ext = String.split(file_name, ".") |> List.last()

      Map.update(acc, ".#{ext}", [file_name], fn file_names ->
        [file_name | file_names] |> Enum.reverse()
      end)
    end)
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      Map.put(acc, k, Enum.sort(v))
    end)
  end
end
