# Lorem Ipsum MD

[![Build Status](https://travis-ci.org/geekjuice/doctor_ipsum.png)](https://travis-ci.org/geekjuice/doctor_ipsum)

__Still under development__

Markdown formatted Lorem Ipsum generator. Lorem Ipsum generator cherry-picked
from the [Faker](https://github.com/stympy/faker) Lorem Ipsum generator.

Rather than use generator plain, unformatted placeholders, why not Markdown
placeholders

## Installation

Add this line to your application's Gemfile:

    gem 'doctor_ipsum'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doctor_ipsum

## Usage

For basic [Faker](https://github.com/stympy/faker) Lorem Ipsum:

```ruby

    DoctorIpsum::Lorem.sentence
    => "Qui assumenda mollitia error dolorum nostrum et."

    DoctorIpsum::Lorem.words
    => ["sit", "vel", "possimus"]

    ...

```

For Markdown:

```ruby

  DoctorIpsum::Markdown.header
  => "# Aliquam Dolore Voluptatem"

  DoctorIpsum::Markdown.emphasis
  => "_qui maxime quia_"

  DoctorIpsum::Markdown.blockquote
  => "> Laborum et sed quisquam rerum\n> ipsum. Est soluta omnis fugit\n> unde.
  Et totam eaque illo\n> exercitationem itaque neque. Hic unde\n> fugit
  deserunt non et. Et\n> est velit voluptate nemo quia."

  DoctorIpsum::Markdown.list
  => "* quis nostrum\n* labore error\n* soluta voluptatem\n* totam expedita\n*
  dlectus et"

  DoctorIpsum::Markdown.horizontal
  => "----------"

  DoctorIpsum::Markdown.link
  => "[Dignissimos omnis aut et deleniti](http://google.com \"et\")"

  DoctorIpsum::Markdown.image
  => "![Suscipit nostrum distinctio eligendi voluptates repudiandae
  doloribus](http://placehold.it/459x466 \"consectetur\")"

  # To produce random blog entry with every random markdown elements
  DoctorIpsum::Markdown.entry

```

Most of the above functions also take arguments and can be found by
[here](https://github.com/geekjuice/doctor_ipsum/blob/master/lib/doctor_ipsum/markdown.rb)


## Future Plans

Features to look for in future updates:

* Code blocks (regular and Github flavor)
* More flexibility for each method


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Doctor Ipsum is released under the MIT License.

