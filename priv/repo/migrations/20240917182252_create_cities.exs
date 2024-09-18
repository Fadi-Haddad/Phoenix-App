defmodule PhoenixApp.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string, null: false
        timestamps()
    end
  end
end
