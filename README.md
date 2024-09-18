# PhoenixApp

1. **Start by installing the Hex package manager for Elixir:**
   ```bash
   mix local.hex
2. **Run the following command to install the Phoenix generator:**
   ```bash
   mix archive.install hex phx_new
3. **Create a new Phoenix app with your database of choice (PostgreSQL in this app):**
   ```bash
   mix phx.new {app_name} --database mysql
4. **Run the follwing command to fetch and install dependencies**
   ```bash
   mix deps.get
5. **Configure the database in config/devs.exs and run**
   ```bash
   mix ecto.create
6. **Start up the Phoenix app server**
   ```bash
   mix phx.server 
7. **Start up the Phoenix app server**
   ```bash
   mix phx.server 
8. **Create a new DataController inside phoenix_app_web/controllers**
   
9. **Add a route to get the data inside phoenix_app_web/route.ex**
   get "/get_data", DataController, :data
10. **Since the database currently has no tables, we'll need to set up the cities table first**
   ```bash
   mix ecto.gen.migration create_cities
   
11. **Run the migrations**
   ```bash
   mix ecto.migrate
11. **Install httpoison and jason by adding them to mix.es**

   {:httpoison, "~> 1.8"},
   {:jason, "~> 1.2"}

   and run :
   ```bash
   mix deps.get
12. **Create a new SQL query window**
   ```bash
      INSERT INTO cities (name, inserted_at, updated_at) VALUES
      ('Beirut', NOW(), NOW()),
      ('Paris', NOW(), NOW()),
      ('Cairo', NOW(), NOW());
13. **Add /add_city route to router.es to avoid CSRF errors**
   ```bash
      scope "/api", PhoenixAppWeb do
         pipe_through :api
         post "/add_city", DataController, :add_city
      end
14. **Define functions add_city , get_data to DataController**

15. **Add cities to cities table with thunderclient**
   URL = http://localhost:4000/api/add_city
   with Json Body = 
   ```bash
         {
      "city": {
         "name": "London"
      }







