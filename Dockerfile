FROM ruby:3.2
RUN apt-get update -qq && apt-get install
WORKDIR /estagioSRE
COPY Gemfile /estagioSRE/Gemfile
COPY Gemfile.lock /estagioSRE/Gemfile.lock
RUN bundle install

VOLUME /output_data

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]