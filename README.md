# README

## System dependencies
Ruby Version: 3.0.0, Rails: 7.1.2  
`gem install rails`

Rails requires the Pysche gem to parse and emit YAML. It is a ruby wrapper for the libyaml library, you may need to install it:
 `brew install libyaml` 

This app uses the image_processing gem. It is a ruby wrapper for the vips library. Install vips with brew: 
`brew install vips` 

(I'm running MacOS 12.7, and this install did not take long. Maybe a few minutes. But when I tried to install it on a different machine running 11.x, that was a terrible idea - hours installing its dependencies and then a failure anyway.)

There's an error that can occur because of added security to restrict multithreading in macOS High Sierra and later versions of macOS (10.x+). Optional, but recommended: either run  `export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`  in your directory, or add  `OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`  to your .bash_profile (this is less recommended).  [here's a link to issue](https://github.com/rails/rails/issues/38560, "issue")

## Configuration

Run `bundle install` to install the dependencies in the application gemfile.

Inside the project directory, run  `bin/rails credentials:edit`  which will prompt you to generate a secret key @ *config/master.key*.

Replace the contents of the generated file with the key I will provide by email. You can check that the key has been properly changed by running  `bin/rails credentials:edit`  again. (`EDITOR="code --wait" bin/rails credentials:edit`  will open the credientials file in vscode.) You should be able to view AWS credentials I have provided for access to a public S3 bucket I have linked this application to.

## Database initialization

Make sure your postgres service is active, and create our database & run migrations:
`rails db:create` 
`rails db:migrate`

## Services

The testing suite can be run with:  `rspec`

Caching in a local development environment is disabled by default. It can be enabled by running  `rails dev:cache`

## Deployment

The server can be launched with `rails s`

Users can authenticate by either creating a session bearer token by posting a succesful login to localhost:3000/sessions or by  providing an api key. At this time, there is no exposed route to generate api keys, so it must be done via rails console.

to open rails console: `rails c` 
`key = ApiKey.create().raw_token` will print a working api key to be included as a bearer token in an authorization header that can be used to access the api. (example: Bearer "AbCdEf123456")

