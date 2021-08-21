ARG USER_ID=1000
ARG GROUP_ID=1000

FROM heroku/heroku:20

ARG USER_ID
ARG GROUP_ID

ENV GEM_HOME="/home/ordway/.gem/"
ARG RAILS_ENV="development"
ARG RAILS_LOG_TO_STDOUT=true
ARG BUNDLE_WITHOUT=""
ARG DEBIAN_FRONTEND="noninteractive"

RUN sed -i "s/999/499/" /etc/group
RUN addgroup --gid $GROUP_ID ordway &&\
  adduser --disabled-login --gecos '' --uid $USER_ID --gid $GROUP_ID ordway
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
  && apt update -qq && apt install -y --no-install-recommends ruby-dev libpq-dev g++ yarn nodejs

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh

RUN mkdir /app && chown ${USER_ID}:${GROUP_ID} /app
USER ordway
WORKDIR /app

RUN gem install --user-install bundler
ENV PATH "$PATH:/home/ordway/.gem/ruby/2.7.0/bin"
RUN bundle config set path "/home/ordway/.gem/"

COPY --chown=${USER_ID}:${GROUP_ID} Gemfile Gemfile.lock ./

RUN bundle install -j4 --retry 3 \
  && bundle binstubs rake \
  && rm -rf "${GEM_HOME}/cache" \
  "${GEM_HOME}/bundler/gems/*/.git" \
  && find "${GEM_HOME}/gems" -regex '.+\.[co]$' -delete
COPY --chown=${USER_ID}:${GROUP_ID} . .
RUN rake webpacker:install:react

ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "bin/rails", "server", "-b", "0.0.0.0"]
