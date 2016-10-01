___
##### Atterntion

using `unique_by:` returns `ArgumentError: unknown keyword: unique_by`

using
```
dataset = client.datasets.find_or_create('sales.gross', fields: [
  Geckoboard::MoneyField.new(:amount, name: 'Amount', currency_code: 'USD'),
  Geckoboard::DateTimeField.new(:timestamp, name: 'Time'),
], unique_by: [:timestamp])
```
gives unknown keyword `currency_code`, if substituted by `currency` returns `currency was not provided`. Workaround - providing hash as argument.
___

App runs on Ruby using Postgers, caching and background processes use Redis, Blockchain API, Geckoboard API

##### setup:
- clone
- `cd` into cloned directory
- run `bundle install`
- you'll need to setup local Postgres database `gecko_app_development`
- export your `api_key` to environment
- finally run `ruby gecko_app.rb MIN, FX`. MIN - minute interval that will be used for downloading bitcoin stats and putting them to Geckoboard server. FX - currency code  ISO 4217 standard. You can use any of ["USD", "ISK", "HKD", "TWD", "CHF", "EUR", "DKK", "CLP", "CAD", "CNY", "THB", "AUD", "SGD", "KRW", "JPY", "PLN", "GBP", "SEK", "NZD", "BRL", "RUB"] for which there is data on `URL: https://blockchain.info/ticker`

Data will be periodically sent to Geckoboard, my example [Dashboard](https://vasilievvv.geckoboard.com/dashboards/CB666CFD581B95DB)

Code mostly was spiked, also due to above errors and inability to export data from Geckoboard.

##### further development
* Blockchain data updates every 15 minutes and Geckoboard updates dataset every 10 minutes. I plan to use Redis for local caching of Blockchain responses, which will minimize db calls usage. And will save resources
* Also I plan to use Redis for background processes scheduling
* To have a friendly UI and better UX, app will be deployed to web (Heroku), allowing users create datasets online.
* I plan to test implemented code. Tho I strongly believe it should be done in a first place.
* Code imo needs refactoring, I'd probably extract to separate class all methods relating to data formatting. And would store JSON directly to Postgres, had some issues with bjson data type and hstore. Would probably autogenerate and populate tables and generate datasets based on tables structure. Push mechanizm needs to be changed for appending new data, overwriting is resource consuming.
* Would add error reporting on downloading and pushing data.

...hope to hear from you soon guys.


