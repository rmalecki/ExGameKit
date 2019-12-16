defmodule GameKit.PublicKeyCache do
  @moduledoc false
  use GenServer

  # External API
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(args) do
    {:ok, args}
  end

  def get(url) do
    GenServer.call(__MODULE__, {:get, url})
  end

  defp is_valid_url?(url) do
    !(Regex.run(~r{https://.*\.apple\.com/}i, url) |> is_nil())
  end

  defp download_key(url, cache) do
    with true <- is_valid_url?(url),
         {:ok, body} <- HTTPoison.get(url) |> handle_response(),
         {:ok, key} <- ExPublicKey.loads(body)
      do
      {:reply, {:ok, key}, Map.put(cache, url, key)}
    else
      false -> {:reply, {:error, "Invalid URL"}, cache}
      e -> {:reply, e, cache}
    end
  end

  @impl true
  def handle_call({:get, url}, _from, cache) do
    case Map.get(cache, url) do
      nil -> download_key(url, cache)
      key -> {:reply, {:ok, key}, cache}
    end
  end

  defp handle_response({:ok, %{body: body, status_code: code}})
       when code in 200..299
    do
    {:ok, body}
  end

  defp handle_response({:ok, %{body: body}}),
       do: {:error, "Could not retrieve key, response: #{body}"}

  defp handle_response(other), do: other

end
