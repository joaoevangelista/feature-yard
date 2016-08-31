defmodule Featureyard.FeatureAPIView do
  use Featureyard.Web, :view

  def render("index.json", %{features: features}) do
    render_many(features, Featureyard.FeatureAPIView, "feature.json")
  end

  def render("feature.json", %{feature: feature}) do
    %{id: feature.id,
    enabled: feature.enabled,
    name: feature.name,
    key: feature.key}
  end
end
