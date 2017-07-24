# README

This is a RubyOnRails judge for coding contest, this is part of Aldo Rincon Mora and Diego Andres Tarazona Orduz bachelor degree project, it uses Rails 5.1.2.

The code is write to linux enviroments, tested using Ubuntu Server 16.10, if you want use a different OS you sould be sure make the configuration by your self.

1. Install safeexec

The source code for safeexec is located lib/judge/safeexec.c and build with the following commands
```bash
 gcc -Wall -o safeexec safeexec.c
 chown root.root safeexec
 chmod 4555 safeexec
```
and move the new safeexec binary to /usr/bin folder.

To install all the RoR dependencies run the command bundle install. 

configure the config/database.yml to fit your development enviroment, if you need a custom credentials please add that file to the .gitignore after modified.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
 :()
