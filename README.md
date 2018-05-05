**under construction**

# MTG Card and Deck Database for Spellbook App

This is a Rails API built for the [Spellbook](https://github.com/GuttermanA/spellbook) web application created as a final project at the Flatiron School. The API contains a PostgreSQL database seeded with the nearly 20,000 Magic: the Gathering Cards which is fully searchable on name and card type. Users can:

* Login with authentication
* View their saved decks and card collection
* View other user's decks
* Perform full CRUD action on their decks and collection
* Search a database of nearly 20,000 Magic cards
* Search for user decks

## API Routes

### /cards
```
GET /cards/search
```
Takes search params for cards and returns matching cards by type or name for up to 50 results.

```
GET /cards/:id
```
Returns data for single card of given id.

### /decks
```
POST /decks
```
Takes deck data in request body and creates deck. Requires authorization.

```
PATCH /decks/:id
```
Takes deck data in request body and updates deck of given id. Requires authentication.

```
DELETE /decks/:id
```
Deletes deck of given id. Requires authentication.

```
GET /decks/:id
```
Returns data for single deck of given id.

```
GET /decks/search
```
Takes search params for decks and returns matching decks names.

## Installing
1. Clone repository from GitHub
2. Open terminal
3. Navigate to the repository directory
```
cd spellbook-api
```
4. Install gems
```
bundle install
```
5. Setup database
```
rake db:create
```
```
rake db:migrate
```
```
rake db:seed
```
**Note: seeding make take a while as the database is seeded by the [Magic: The Gathering Developers API](https://magicthegathering.io/) - No API key required**
6. Start server
```
rails s
```

## Built With
* [Rails](http://rubyonrails.org/) - web-application framework
* PostgreSQL - database
* [MTG SDK - Ruby](https://github.com/MagicTheGathering/mtg-sdk-ruby) - data and seeding
* [Fast JSON API](https://github.com/Netflix/fast_jsonapi) - serializer
* [JWT](https://github.com/jwt/ruby-jwt) - authentication

## Contributing
1. Fork repository [here](https://github.com/GuttermanA/spellbook-api)
2. Create new branch for your feature
```
git checkout -b my-new-feature
```
3. Add and commit your changes
```
git commit -am 'Add some feature'
```
4. Push to your branch
```
git push origin my-new-feature
```
5. Create new pull request

## Authors
* Alex Gutterman - [Github](https://github.com/guttermana)
