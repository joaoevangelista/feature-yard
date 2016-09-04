defmodule Featureyard.AudienceView do
  use Featureyard.Web, :view

  def render("show.json", %{audience: audience}) do
    %{id: audience.id,
   key: audience.key,
   description: audience.description}
  end
end
