defmodule Featureyard.Factory do
  use ExMachina.Ecto, repo: Featureyard.Repo

  alias Featureyard.User

  def user_factory do
    %User{
      email: sequence(:email, &"test-#{&1}@featureyard.com"),
      encrypted_password: "12345678"}
    end

  end
