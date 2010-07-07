# Almost Happy #

Almost happy is a set of content management tools for ActiveRecord 3 and higher. It's built
on a simple, clean code base that makes it easy to do trivial content management tools.

## Usage ##

First off, you'll need to add the gem to the Gemfile. For most cases, the following line should do:

    gem "almost-happy"
    
Then, run `bundle install`.

Currently it provides two sets of functionality - publishable and convertable.

E.g. to make a model publishable:

    class Page < ActiveRecord::Base
      is_publishable
    end
    
And, for each content field, declare it convertable:

    class Page < ActiveRecord::Base
      is_publishable
      is_convertable :content
    end
    
And before each save it will automatically convert the content to html
using the specific format etc.

### is\_publishable ###

When a model is marked as publishable, it provides the following instance methods:

* `published?` - returns a boolean indicating if it's published. also aliased to `published` for forms.
* `publish!` - mark the post as published right now.
* `published=(value)` - mark items as published in forms.

And, the following class methods:

* `published` - returns a relation with all published posts
* `ordered` - returns a relation ordered by the published at time
* `ordered_for_preview` - returns a relation ordered by the published at time, those unpublished first.

### is\_convertable ###

When a model is marked as convertable, it adds hooks (inc. validation) to convert
raw content in one format to another.

the `is_convertable` call accepts field names as the argument and an optional options hash.

The options hash currently has one options - `:validate` - defaulting to true, determining whether
the presence and format is validated.

For each field passed to `is_convertable`, it will provide the following methods:

* `#{field}_as_html` - rendered version as a html safe string

When using on a model, it expects a format (string) column exists and for each field the following:

* `#{field}` - stores the original, editable content (in whichever format is specified)
* `rendered_#{field}` - stores the converted field value

When rendering a form, please note you can also get a set of formats for a select field using
`AlmostHappy::Convertor.for_select`.

## Note on Patches/Pull Requests ##
 
1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2010 Darcy Laycock. See LICENSE for details.

