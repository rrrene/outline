# Outline


## Description

Outline is an open source project and knowledge management application for the facebook/twitter generation.


## Features

 * Written in Ruby on Rails
 * No-Fluff design
 * Post Notes, To-Dos and Links to projects
 * Organize knowledge on pages
 * Simple user management
 * Support for themes
 * Support for multiple languages
 * Easily extendable


## Installation

Outline is a Ruby on Rails application, meaning that you can configure and run it the way you would any other Rails application.

    git clone git@github.com:rrrene/outline.git
    cd outline
    bundle
    cp config/database.yml.mysql config/database.yml
    rake db:create:all db:migrate
    unicorn_rails

The use of RVM is recommended.


## License

Released under the MIT License. See the LICENSE file for further details.
