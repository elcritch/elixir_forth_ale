defmodule ForthAle.MixProject do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  def project do
    [
      app: :forth_ale,
      description: "Portable Abstraction LayEr for Elixir ALE",
      version: "0.2.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def deps do
    [
      {:ex_doc, ">= 0.0.0"},
      {:halio, "~> 0.2", git: "git@github.com:elcritch/halio.git"},
      {:elixir_ale, "~> 1.0"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

end
