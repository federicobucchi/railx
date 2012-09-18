
## ATTENTION: Still in development phase, use only for testing

# railx

The goal of rails is to make easy a full customizable ajax experience within a rails application, managing:

* ajax calls
* flash messages
* redirect_to
* deep linking
* browser history
* page title



## Installation

Add this line to your application's Gemfile:

    gem 'railx'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install railx

## Usage

Add following lines to your app/assets/javascripts/application.js

		//= require jquery
		//= require jquery_ujs
		//= require_tree .

then in app/assets/stylesheets/application.css

		*= require_self
		*= require_tree .
		*= require railx
		*/
Now all your links will trigger an ajax call, filling the body with the content of the response.

You can configure a default target for all links in your javascript files in this way:

window.Railx.default_target = "#container"

or specify it on Html side 

		<a href="some_url" data-target="#left-div"> Link </a>
 
from a controller you can update the content of mor divs other than the main content.

	  def index
	    # do something
	    updatediv "#header", "layouts/header"
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @feeds }
	    end
	  end
		 
the target div will be filled with the content of index.html.erb
and the div with id "header" with the content of partial layouts/_header.haml (or erb or other formats)
 
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
