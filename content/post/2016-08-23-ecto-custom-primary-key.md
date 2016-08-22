+++
date = "2016-08-23T12:27:17-07:00"
description = "How Ecto handles Custom Primary Keys"
title = "Dealing with Legacy Databases"
tags = [
  "elixir",
  "ecto",
  "phoenix",
  "learning",
]
slug = "custom-primary-keys"
draft = false
+++

Ergast.com is a webservice which provides a database of Historical F1 Data, starting from the 1950 season until today.

They also kindly provide a [mysql database image](http://ergast.com/mrd/db/) for download. This database is the source of this toy project I've been working on: the idea of which is provide a [{json:api}](http://jsonapi.org/) compliant API as a way for me to practice working with Elixir and Phoenix.

#### Challenges

Unfortunately, the mysql database image uses a non standard primary key for each table.

Here's a sample of the __races__ table.

| raceId | year | round | circuitId | name                          | date       | time     | url                                                             |
|--------|------|-------|-----------|-------------------------------|------------|----------|-----------------------------------------------------------------|
| 1      | 2009 | 1     | 1         | Australian Grand Prix         | 2009-03-29 | 06:00:00 | http://en.wikipedia.org/wiki/2009_Australian_Grand_Prix         |
| 2      | 2009 | 2     | 2         | Malaysian Grand Prix          | 2009-04-05 | 09:00:00 | http://en.wikipedia.org/wiki/2009_Malaysian_Grand_Prix          |
| 3      | 2009 | 3     | 17        | Chinese Grand Prix            | 2009-04-19 | 07:00:00 | http://en.wikipedia.org/wiki/2009_Chinese_Grand_Prix            |
| 4      | 2009 | 4     | 3         | Bahrain Grand Prix            | 2009-04-26 | 12:00:00 | http://en.wikipedia.org/wiki/2009_Bahrain_Grand_Prix            |

Notice that the primary key for this table is __raceId__, and the association to the seasons table is __year__.

#### Setting Custom Primary Keys

Using the model generator in Phoenix, you'll end up with something like this:

//web/models/race.ex
```
schema "races" do
  field :round, :integer
  field :name, :string
  field :url, :string
  field :date, Ecto.Date
  field :time, Ecto.Time
  timestamps()

  belongs_to :circuit, PhoenixF1JsonApi.Circuit
  belongs_to :season, PhoenixF1JsonApi.Season
end
```

However, this will not work, because this assumes the primary key for the race table is _id_, and the associations are more sane, such as __season_id__ and __circuit_id__.

In order to set it up correct, I had to do the following:

//web/models/race.ex
```
@primary_key {:raceId, :integer, []}
@derive {Phoenix.Param, key: :raceId}
schema "races" do
  field :round, :integer
  field :name, :string
  field :date, Ecto.Date
  field :time, Ecto.Time
  field :url, :string

  belongs_to :circuit, PhoenixF1JsonApi.Circuit, foreign_key: :circuitId
  belongs_to :season, PhoenixF1JsonApi.Season, foreign_key: :year
end
```

#### Let's break down each step.

```
@primary_key {:raceId, :integer, []}
```

Here I'm defining the primary key for this schema as raceId, and it's an intger.

```
@derive {Phoenix.Param, key: :raceId}
```
Next, I set the @derive to use raceID as the param key. This is the ID that's going to be used in the routes.

```
belongs_to :circuit, PhoenixF1JsonApi.Circuit, foreign_key: :circuitId
belongs_to :season, PhoenixF1JsonApi.Season, foreign_key: :year
```
Next, I had to asscoiate the foreign_keys for the circuit and season tables to those table's primary key.
```
timestamps()
```
Finally I had to remove the __timestamps()__ line because the data doesn't have updated_at/created_at.


#### Conclusion
While it's not difficult to use non standard keys in Phoenix, It's really not preferred. If you have the ability to reformat the data, I highly recommend it. If not, there are ways to deal with this problem.

The main takaway for me is that the phoenix framework guides are very good. I followed the instructions here:
[Ecto Custom Primary Keys](http://www.phoenixframework.org/docs/ecto-custom-primary-keys)





#### Open Source
See my project on [Github](https://github.com/bennycwong/phoenix_f1_json_api).
