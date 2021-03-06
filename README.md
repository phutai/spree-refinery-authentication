# Spree Refinery CMS Authentication

[![Build Status](https://travis-ci.org/bricesanchez/spree-refinery-authentication.svg?branch=master)](https://travis-ci.org/bricesanchez/spree-refinery-authentication) [![Code Climate](https://codeclimate.com/github/bricesanchez/spree-refinery-authentication/badges/gpa.svg)](https://codeclimate.com/github/bricesanchez/spree-refinery-authentication) [![Test Coverage](https://codeclimate.com/github/bricesanchez/spree-refinery-authentication/badges/coverage.svg)](https://codeclimate.com/github/bricesanchez/spree-refinery-authentication/coverage)

This gem is a Refinery CMS and Spree E-commerce connector.

## Key features

* It provides tabs in Refinery CMS and Spree menus to easily switch between both backends
* Shares admin sessions and user abilities between Refinery CMS and Spree.

## Compatibility

* [Spree 3.0+](http://spreecommerce.com/)
* [Refinery CMS 3.0+](http://refinerycms.com/)

## Installation

Create a new Rails 4.2.x application:

    gem install rails -v 4.2.3
    gem install bundler

Add Spree and those gems to your Gemfile:

    gem 'refinerycms', github: 'refinery/refinerycms', branch: 'master'
    gem 'quiet_assets', :group => :development

    # Add support for searching inside Refinery's admin interface.
    gem 'refinerycms-acts-as-indexed', ['~> 2.0', '>= 2.0.0']

    # Add support for Refinery's custom fork of the visual editor WYMeditor.
    gem 'refinerycms-wymeditor', ['~> 1.0', '>= 1.0.6']

    gem 'spree', github: 'spree/spree', branch: '3-0-stable'
    gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'
    gem 'spree-refinerycms-authentication', github: 'bricesanchez/spree-refinery-authentication', branch: '3-0-stable'

> **Note:** DON'T install the gem `refinerycms-authentication-devise`. The authentication will be provided by Spree and included in the gem `spree_auth_devise`.

Run bundler, then install Spree

    bundle
    rails g spree:install

Change the `Spree.user_class` in the initializer `config/initializer/spree.rb`

    Spree.user_class = "Spree::User"

Run the migrations

    rake db:migrate

Then, put those lines in config/routes.rb to use RefineryCMS and Spree together and remove routes conflicts

    root :to => "refinery/pages#home"
    mount Spree::Core::Engine, :at => '/shop'
    mount Refinery::Core::Engine, at: '/'

> **Note:** If you try to mount both engines `at => '/'`, Refinery will try to display a page even if you request a Spree page. Every page load will be slow.

Create a Spree admin user

    bundle exec rake spree_auth:admin:create

All done! Now start your application

    rails server

You should now be able to access Refinery admin at [http://localhost:3000/refinery](http://localhost:3000/refinery) and Spree admin at [http://localhost:3000/shop/admin](http://localhost:3000/shop/admin).
