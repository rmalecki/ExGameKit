defmodule GamekitTest do
  use ExUnit.Case
  doctest Gamekit

  test "greets the world" do
    assert Gamekit.hello() == :world
  end
end
