defmodule GameKit do
  use Application
  @moduledoc false

  def start(_type, _args) do
    GameKit.Supervisor.start_link
  end
end
