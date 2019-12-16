defmodule GameKit.MixProject do
  use Mix.Project

  def project do
    [
      app: :gamekit,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {GameKit, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.11 or ~> 1.0"},
      {:ex_crypto, "~> 0.10.0"}
    ]
  end
end
