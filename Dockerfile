FROM ruby:2.5-stretch

ARG COMMIT=unknown
ARG BRANCH=unknown
LABEL gitcommit=COMMIT
LABEL branch=BRANCH

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

RUN echo $COMMIT; echo $BRANCH

# Update
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get -y install supervisor ca-certificates git postgresql-client build-essential catdoc elinks \
 gettext ghostscript gnuplot-nox imagemagick unzip \
 libicu-dev libmagic-dev libmagickwand-dev libmagickcore-dev libpq-dev libxml2-dev libxslt1-dev links \
 sqlite3 lockfile-progs mutt pdftk poppler-utils \
 postgresql-client tnef unrtf uuid-dev wkhtmltopdf wv xapian-tools rsync \
 redis-server supervisor

ENV RAILS_ENV production

# Clone develop branch
COPY Gemfile Gemfile.lock /opt/alaveteli/
# https://stackoverflow.com/questions/26504846/copy-directory-to-other-directory-at-docker-using-add-command
COPY gems /opt/alaveteli/gems
WORKDIR /opt/alaveteli/
RUN bundle install --without development debug test --deployment --retry=10 --clean

COPY . /opt/alaveteli/

# Add yaml configuration which take environment variables
COPY script/docker/database.yml config/database.yml.erb
COPY script/docker/general.yml config/general.yml.erb
COPY script/docker/xapian.yml config/xapian.yml
COPY script/docker/supervisor-*.conf /etc/supervisor/

RUN mkdir -p cache; echo $COMMIT > gitcommit.txt

CMD ./script/docker/setup.sh
