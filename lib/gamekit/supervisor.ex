defmodule GameKit.Supervisor do
  @moduledoc false

  use Supervisor
  alias GameKit.PublicKeyCache

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(PublicKeyCache, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
