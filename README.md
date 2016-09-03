# Feature Yard

Toggle features your apps can consume, dynamically and serve them at an endpoint!


[![phoenix badge by Nate Perry](https://github.com/joaoevangelista/feature-yard/blob/master/art/phoenix-badge-light.png)](https://dribbble.com/shots/1612621-Phoenix-Framework-Logo)


[![Build Status](https://travis-ci.org/joaoevangelista/feature-yard.svg?branch=master)](https://travis-ci.org/joaoevangelista/feature-yard)

## About

This service is intended to be implemented at your organization, that
has many products or even one, with different clients needs of features,
for example, one can include new clients, the other can't but can show prices.

### Clients

Clients is the way you think to split the business you want to control, could be
an app distributed for any consumers with different requirements or an app with
experimental capabilities that can be enabled any time.

### Features

Features are as the name implies, features that you want to enable on the client,
a single client can have as many features as you want, each on a state
independent of another. A feature is composed by a name and a key, the key is
used to make conditionals on the devices for example

```ruby
  # object obtained via api call
  can_produce = {enabled: false, key: "CAN_PRODUCE"}
  # or dynamically iterating on response
  can_produce = response.find_by_key "CAN_PRODUCE"

  if can_produce.enabled
    # do something
  end

```

The fetching and update strategy is up to you.

### Audiences

Similarly to scopes audiences provides a further filter to your features, so
each can be applied for example in a certain user based on their account, plan, etc.
The main property of it is the `key` too, its recommended to be `lower_snake_case`,
but it is up to you, even numbers can be it if suits your need.

## Development

### Get Started

To start your Phoenix app:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `npm install`
* Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Production

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### Learn more

* Official website: http://www.phoenixframework.org/
* Guides: http://phoenixframework.org/docs/overview
* Docs: https://hexdocs.pm/phoenix
* Mailing list: http://groups.google.com/group/phoenix-talk
* Source: https://github.com/phoenixframework/phoenix
