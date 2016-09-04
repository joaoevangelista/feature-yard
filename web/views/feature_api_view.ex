defmodule Featureyard.Api.FeatureView do
  use Featureyard.Web, :view

  def render("index.json", %{features: features}) do
    %{ data: render_many(features, Featureyard.Api.FeatureView, "feature.json") }
  end



  def render("feature.json", %{feature: feature}) do
    %{id: feature.id,
    enabled: feature.enabled,
    name: feature.name,
    key: feature.key,
    audiences: render_many(feature.audiences, Featureyard.AudienceView, "show.json")}
  end
end
