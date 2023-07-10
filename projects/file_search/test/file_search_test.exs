defmodule FileSearchTest do
  use ExUnit.Case
  doctest FileSearch
  import FileSearch

  test "folder structure return list of files" do
    File.mkdir("./main")
    File.mkdir("./main/sub1")
    File.mkdir("./main/sub2")
    File.mkdir("./main/sub3")
    File.touch("./main/sub1/file1.txt")
    File.touch("./main/sub2/file2.txt")
    File.touch("./main/sub3/file3.txt")
    File.touch("./main/file4.txt")

    assert all("./main") == ["file1.txt", "file2.txt", "file3.txt", "file4.txt"]

    File.rm_rf("./main")
  end

  test "folder structure return lists of files by extension" do
    File.mkdir("./main2")
    File.mkdir("./main2/sub1")
    File.mkdir("./main2/sub2")
    File.mkdir("./main2/sub3")
    File.touch("./main2/sub1/file1.txt")
    File.touch("./main2/sub1/file1.png")
    File.touch("./main2/sub2/file2.txt")
    File.touch("./main2/sub2/file2.png")
    File.touch("./main2/sub3/file3.txt")
    File.touch("./main2/sub3/file3.jpg")
    File.touch("./main2/file4.txt")

    assert by_extension("./main2") == %{
             ".txt" => ["file1.txt", "file2.txt", "file3.txt", "file4.txt"],
             ".png" => ["file1.png", "file2.png"],
             ".jpg" => ["file3.jpg"]
           }

    File.rm_rf("./main2")
  end
end
