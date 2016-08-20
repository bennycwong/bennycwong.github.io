+++
date = "2016-08-20T12:41:17-07:00"
description = "Easily connect to multiple databases"
title = "Using Multiple DBs in Phoenix"
tags = [
  "elixir",
  "ecto",
  "phoenix",
  "learning",
  "database",
]
slug = "multiple-dbs-in-phoenix"
draft = false
+++

The first phoenix project I've worked on is an internal tool at Dollar Shave Club. It connects to our existing database and does some work on it.

Now that the application is up and running, I'm starting to explore how to handle user authentication and logging of who made what changes, but without touching our main database.

I want to setup a separate database for this internal application.  

It turns out it's pretty trivial to setup a second database in Phoenix.

Here's are the steps.  
In this example, I'm going to define __Repo__ as my main database, and a __RepoPostgres__, a postgres DB that I'm using the handle concerns that are unrelated to to main database  

#### 1. Define the second database in your config file:

//project/config/{env}.exs
```
# Configure your database
config :demo, Demo.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "root",
  database: "demo_dev",
  hostname: "localhost",
  pool_size: 10

config :demo, Demo.RepoPostgres,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "demo_dev",
  hostname: "localhost",
  pool_size: 10

```

#### 2. Create a new repo file in lib
//project/lib/demo/repo_postgres.ex

```
defmodule Demo.RepoPostgres do
  use Ecto.Repo, otp_app: :demo
end
```

#### 3. Add the new database repo in supervision tree on app start
//project/lib/demo.ex

```
children = [
      # Start the Ecto repository
      supervisor(Demo.Repo, []),
      supervisor(Demo.RepoPostgres, []), #<---- Add new line here

      # Start the endpoint when the application starts
      supervisor(Demo.Endpoint, []),
      # Start your own worker by calling: Demo.Worker.start_link(arg1, arg2, arg3)
      # worker(Demo.Worker, [arg1, arg2, arg3]),
    ]
```

#### 4. Use it!

In any place where you want to use the second database, simply use that module.

For example, the controller:

```
defmodule Demo.UserController do
  use Demo.Web, :controller
  alias Demo.User
  alias Demo.RepoPostgres

  def index(conn, _params) do
    users = RepoPostgres.all(User)
    render conn, "index.html", users: users
  end
end
```


#### Conclusion

I think this is one of the a-ha moments in my journey using elixir.  

After reading through the first half of [Programming Phoenix by Chris McCord](https://pragprog.com/book/phoenix/programming-phoenix), I theorized that this is how one would add a second database. And it turns how, that's exactly how to do it. It was a trivial amount of work, and it was easy to reason about.  

There were no surprises.  

It worked as expected.  

I think this is [Principle of Least Astonishment (POLA)](https://en.wikipedia.org/wiki/Principle_of_least_astonishment)  in action.


Hats off to the Phoenix and Ecto teams for making this so simple, and to Chris for his excellent book.
