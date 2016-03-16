3/7/16 i had to uninstall and then install homebrew to be able to install redis. not sure why. 

	==> Pouring redis-3.0.7.el_capitan.bottle.1.tar.gz
	==> Caveats
	To have launchd start redis at login:
	  ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
	Then to load redis now:
	  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
	Or, if you don't want/need launchctl, you can just run:
	  redis-server /usr/local/etc/redis.conf
	==> Summary
	🍺  /usr/local/Cellar/redis/3.0.7: 9 files, 876.3K

3/7/16 after uninstalling and reinstalling homebrew, i could no longer access postgres so reinstalled it with homebrew and got these messages (below) ==> this worked! strange, since i was able to find/start postgres from the finder, like i usually do
	
	15-2012-Macbook-Pro:rails_zestimator rachael$ brew install postgres
	==> Installing dependencies for postgresql: openssl, readline
	==> Installing postgresql dependency: openssl
	==> Downloading https://homebrew.bintray.com/bottles/openssl-1.0.2g.el_capitan.bottle.tar.gz
	######################################################################## 100.0%
	==> Pouring openssl-1.0.2g.el_capitan.bottle.tar.gz
	==> Caveats
	A CA file has been bootstrapped using certificates from the system
	keychain. To add additional certificates, place .pem files in
	  /usr/local/etc/openssl/certs

	and run
	  /usr/local/opt/openssl/bin/c_rehash

	This formula is keg-only, which means it was not symlinked into /usr/local.

	Apple has deprecated use of OpenSSL in favor of its own TLS and crypto libraries

	Generally there are no consequences of this for you. If you build your
	own software and it requires this formula, you'll need to add to your
	build variables:

	    LDFLAGS:  -L/usr/local/opt/openssl/lib
	    CPPFLAGS: -I/usr/local/opt/openssl/include

	==> Summary
	🍺  /usr/local/Cellar/openssl/1.0.2g: 466 files, 11.9M
	==> Installing postgresql dependency: readline
	==> Downloading https://homebrew.bintray.com/bottles/readline-6.3.8.el_capitan.bottle.tar.gz
	######################################################################## 100.0%
	==> Pouring readline-6.3.8.el_capitan.bottle.tar.gz
	==> Caveats
	This formula is keg-only, which means it was not symlinked into /usr/local.

	OS X provides the BSD libedit library, which shadows libreadline.
	In order to prevent conflicts when programs look for libreadline we are
	defaulting this GNU Readline installation to keg-only.


	Generally there are no consequences of this for you. If you build your
	own software and it requires this formula, you'll need to add to your
	build variables:

	    LDFLAGS:  -L/usr/local/opt/readline/lib
	    CPPFLAGS: -I/usr/local/opt/readline/include

	==> Summary
	🍺  /usr/local/Cellar/readline/6.3.8: 40 files, 2.0M
	==> Installing postgresql
	==> Downloading https://homebrew.bintray.com/bottles/postgresql-9.5.1.el_capitan.bottle.tar.gz
	######################################################################## 100.0%
	==> Pouring postgresql-9.5.1.el_capitan.bottle.tar.gz
	==> Caveats
	If builds of PostgreSQL 9 are failing and you have version 8.x installed,
	you may need to remove the previous version first. See:
	  https://github.com/Homebrew/homebrew/issues/2510

	To migrate existing data from a previous major version (pre-9.0) of PostgreSQL, see:
	  http://www.postgresql.org/docs/9.5/static/upgrading.html

	To migrate existing data from a previous minor version (9.0-9.4) of PosgresSQL, see:
	  http://www.postgresql.org/docs/9.5/static/pgupgrade.html

	  You will need your previous PostgreSQL installation from brew to perform `pg_upgrade`.
	  Do not run `brew cleanup postgresql` until you have performed the migration.

	To have launchd start postgresql at login:
	  ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
	Then to load postgresql now:
	  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
	Or, if you don't want/need launchctl, you can just run:
	  postgres -D /usr/local/var/postgres
	==> Summary
	🍺  /usr/local/Cellar/postgresql/9.5.1: 3,118 files, 35M

# Sending Data-Rich Emails using Action Mailer

>> "Unlike controllers, the mailer instance doesn't have any context about the incoming request" => I think that I have to use a helper to pull data in, then reference the helper in the ActionMailer(!) -- see http://guides.rubyonrails.org/action_mailer_basics.html#using-action-mailer-helpers

creating app on heroku
15-2012-Macbook-Pro:rails_zestimator rachael$ heroku create
Creating app... done, stack is cedar-14
https://morning-beyond-67227.herokuapp.com/ | https://git.heroku.com/morning-beyond-67227.git 

notes from heroku deployment:

remote: ###### WARNING:
remote:        You have not declared a Ruby version in your Gemfile.
remote:        To set your Ruby version add this line to your Gemfile:
remote:        ruby '2.2.4'
remote:        # See https://devcenter.heroku.com/articles/ruby-versions for more information.
remote: 
remote: ###### WARNING:
remote:        No Procfile detected, using the default web server.
remote:        We recommend explicitly declaring how to boot your server process via a Procfile.
remote:        https://devcenter.heroku.com/articles/ruby-default-web-server
remote: 
remote: -----> Discovering process types
remote:        Procfile declares types     -> (none)
remote:        Default types for buildpack -> console, rake, web, worker
remote: 
remote: -----> Compressing...
remote:        Done: 33.9M
remote: -----> Launching...
remote:        Released v6
remote:        https://morning-beyond-67227.herokuapp.com/ deployed to Heroku
