FROM ruby:3.2.3

RUN apt-get update -qq && apt-get install -y nodejs sqlite3 libsqlite3-dev
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

EXPOSE 3000

CMD ["rails", "db:create"]
CMD ["rails", "server", "-b", "0.0.0.0"]