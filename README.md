# Inmana

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

- Create a new restaurant:

  `POST http://localhost:4000/api/restaurants`

  Body:

  ```json
  {
    "name": "Restaurant Name",
    "email": "restaurant@email.com"
  }
  ```

  Response:

  `201 Created`:

  ```json
  {
    "message": "Restaurant created!",
    "restaurant": {
      "email": "restaurant@email.com",
      "name": "Restaurant Name",
      "id": "8256398b-c7c4-417e-8c3b-5fa9505d5d55"
    }
  }
  ```

- Create a new supply:

  `POST http://localhost:4000/api/supplies`

  Body:

  ```json
  {
    "restaurant_id": "8256398b-c7c4-417e-8c3b-5fa9505d5d55",
    "description": "Supply description",
    "expiration_date": "2021-04-26",
    "responsible": "Responsible Name"
  }
  ```

  Response:

  `201 Created`:

  ```json
  {
    "message": "Supply created!",
    "supply": {
      "description": "Supply description",
      "expiration_date": "2021-04-26",
      "responsible": "Responsible Name",
      "restaurant_id": "8256398b-c7c4-417e-8c3b-5fa9505d5d55",
      "id": "017f07d6-43db-4908-99e8-5296692ecf70"
    }
  }
  ```

- Show supply:

  `GET http://localhost:4000/api/supplies/:supply_id`

  Response:

  `200 OK`:

  ```json
  {
    "supply": {
      "description": "Supply description",
      "expiration_date": "2021-04-26",
      "responsible": "Responsible Name",
      "restaurant_id": "8256398b-c7c4-417e-8c3b-5fa9505d5d55",
      "id": "017f07d6-43db-4908-99e8-5296692ecf70"
    }
  }
  ```

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

---

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
