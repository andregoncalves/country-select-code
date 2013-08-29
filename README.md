# Country-Select-Code

Provides a simple helper to get an HTML select list of countries.
Optionally, you can store the country code instead of the full country name.
Compatible with Rails 4.

Code adapted from Rails' +country_select+ plugin (previously in core)
See https://github.com/jamesds/country-select

The list of countries comes from the ISO 3166 standard.  While it is a relatively neutral source of country names, it may still offend some users.
Users are strongly advised to evaluate the suitability of this list given their user base.

## Latest Changes

**1.0.0**

- Initial version

## Installation

Install as a gem using

    gem install country-select-code

Or put the following in your Gemfile

    gem 'country-select-code'

## Example

Simple use supplying model and attribute as parameters:

    country_select_code("user", "country_name")

Supplying priority countries to be placed at the top of the list:

    country_select_code("user", "country_name", [ "United Kingdom", "France", "Germany" ])

Storing just the country code

    country_select_code("user", "country_name", nil, :with_country_code => true)

Supplying priority countries with country code parameter

    country_select_code("user", "country_name", [["United Kingdom", "GB"], ["France", "FR"], ["Germany", "DE"]], :with_country_code => true)

## Version History

 - **1.0.0** - Initial version

Copyright (c) 2013 Andre Goncalves, released under the MIT license