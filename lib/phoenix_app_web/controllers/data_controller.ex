defmodule PhoenixAppWeb.DataController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Repo
  alias PhoenixApp.City
  require Logger

  def data(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  @api_key "82c0017e4dc9413395e184435241709"  # Bad practice

  def fetch_weather(city_name) do

    url ="http://api.weatherapi.com/v1/current.json?key=#{@api_key}&q=#{city_name}&aqi=no"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        weather_data = body
        |>Jason.decode!()
        |>extract_weather_data()
        |>IO.inspect(label: "Extracted Weather Data")  # debugging output
        {:ok, weather_data}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("HTTP error: #{reason}")
        {:error, reason}
      end
  end

  def extract_weather_data(%{
    "location" => %{"name" => location_name},
    "current" => %{
      "temp_c" => temp_c,
      "condition" => %{
        "text" => condition_text}}}) do
      %{
      location: location_name,
      temperature_c: temp_c,
      condition: condition_text}
  end


  def get_data(conn, _params) do

    cities = Repo.all(City)

    weather_data =
      cities
      |> Enum.map(fn city ->
        IO.inspect(city, label: "City Data")  # Debugging city
        IO.inspect(city.name, label: "City.name")  # Debugging city.name
        IO.inspect(fetch_weather(city.name), label: "Weather Data2")  # Debugging fetch_weather(city.name)
        case fetch_weather(city.name) do
          {:ok, weather} ->
            %{city: city.name, weather: weather}
          {:error, reason} -> %{city: city.name, weather: "Weather data not available", reason: reason}
        end
      end)

    response =
    case weather_data do
      [] -> %{message: "No cities found in the database."}
      _ -> %{weather_data: weather_data}
    end

    json(conn, response)  # sends response back to client
  end

  def add_city(conn, %{"city" => city_params}) do
    changeset = City.changeset(%City{}, city_params)

    case Repo.insert(changeset) do
      {:ok, _city} ->
        json(conn, %{message: "City added successfully"})
      {:error, changeset} ->
        json(conn, %{error: changeset.errors})
    end
  end
end
