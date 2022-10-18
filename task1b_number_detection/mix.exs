defmodule Task1bNumberDetection.MixProject do
  use Mix.Project

  def project do
    [
      app: :task1b_number_detection,
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nx, "~> 0.2"},
      {:evision, "~> 0.1.7", github: "cocoa-xu/evision", tag: "v0.1.7"},
      {:tesseract_ocr, "~> 0.1.5"},
    ]
  end
end
