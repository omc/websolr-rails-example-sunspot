# Websolr-Rails-Example App
In this tutorial we'll show you how to build a Rails 5 app integrated with Solr using the Sunspot client and Websolr in production. Keep in mind that the Apache Solr search server presents an API and there are a number of open source clients to choose from. We recommend Sunspot, and will showcase it in this tutorial. Let's get started!

## Sign up for Websolr

You can sign up here for a Websolr plan. Select the plan that works best for you and your team.

Our Rails 5 app using Websolr + Sunspot

Our example Rails app will provide you a good outline to follow along.
You can access the GitHub repo.

In our example app, Mythology Fake Search we'll have a list of mythological figures that are searchable via characters, countries, quotes and stories.

You can see the app in action here.

So now that we have our example code (or a Rails project of your own) let's proceed to the next step.

## Install and Start Sunspot

Install Sunspot by including the `sunspot_rails` gem in your `Gemfile` 


    gem 'sunspot_rails'

On the command line, run `bundle install`.

Let's start a local instance of Solr using Sunspot's rake task:


    rake sunspot:solr:start

The status `Successfully started Solr ...` will pop up. This rake task also creates a `solr/conf` directory, which contains default configuration files for your local Solr instance, as well as a `solr/data` directory for the Solr index itself.

You should add the `solr/data` directory to your .gitignore file.

## Deploying to Heroku

As with all things related to the development process, deploy early and often. It’s a good idea to double check that you have completed all the steps above. For our example app we used Heroku to deploy. For step by step instructions as to how you can deploy your rails app with Heroku, please consult their excellent documentation:


    https://devcenter.heroku.com/articles/getting-started-with-rails4

Once you have deployed to Heroku you can add the Websolr add-on from the Overview tab.

## Inserting Data

Our next step will allow us to add data to the index as well as how to do a local database import. Let’s start with populating our local app first. For convenience sake, we will use the Faker gem to help populate db. Here’s a link to the Faker gem documentation:


    https://github.com/stympy/faker

Let’s add the Faker gem to the gemfile:


    gem 'faker'

and run our `bundle install` command. Now that we’ve got the Faker gem installed, we can start adding some sample data. Take a look at our `schema.rb` and `seeds.rb` files in our sample code if you need some guidance in how to structure those files.

Run the following commands to set up your local db, note that in Rails 5 we can now use the rails command instead of rake.


    rails db:create
    rails db:migrate
    rails db:seed

Run `rails s` and check out all the mythological characters that have appeared! Now that we know how to populate our local db, let’s proceed on how to index our models.

## Indexing our Models

Fortunately, Sunspot provides searchable class methods for us to configure how our models are to be indexed. This let's us specify the fields we'd like to have indexed, and the Solr data type we want them to be indexed as.

Let's take a look at `app/models/character.rb`, where we include the following:

    class Character < ApplicationRecord
      belongs_to :story
      belongs_to :country
      has_many :quotes

    #indexing them as Solr text fields
      searchable do
        text :name

      end
    end

Should you want to change how your models are indexed, you will need to rebuild your index for any existing data in your database. To do so, run Sunspot's "reindex" rake task:


    $ rake sunspot:reindex

Using Sunspot's `solr_search` method, which can also aliased to `search`, accepts a block and returns a search result object that wraps the response from Solr.
Looking at our Charcter Class on our `characters_controller.rb`


    class CharactersController < ApplicationController
      def index
        @search = Character.search do
          keywords params[:query]
        end
        @posts = @search.results
      end
    end

The `keywords` method accepts a query string and performs a keyword-based search against your text fields.

The `@search` object provides a `results` method that fetches the full ActiveRecord objects that correspond to the results returned by Solr.
That should do it, your models are now indexed and ready to be searched!

Congratulations! You've Added Solr to Your Rails App

You have created your Solr index using Websolr and Sunspot. You indexed the models and now can deploy to the service of your choice! For our example we used Heroku, where you can install the Websolr Addon.

Please feel free to give us feedback or ask questions at devcontent@omc.io or @onemorecloud.
