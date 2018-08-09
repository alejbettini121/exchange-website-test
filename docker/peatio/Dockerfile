# Use an official ubuntu runtime as a parent image tatlis
FROM ubuntu

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git-core curl zlib1g-dev build-essential \
                     libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
                     libxml2-dev libxslt1-dev libcurl4-openssl-dev \
                     python-software-properties libffi-dev

RUN apt-get install rbenv -y

#RUN git clone git://github.com/sstephenson/rbenv.git .rbenv
#RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
#RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#RUN exec $SHELL

RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
RUN exec $SHELL

RUN rbenv install 2.4.2
RUN rbenv global 2.4.2

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install bundler
RUN rbenv rehash

RUN apt-get update
RUN apt-get install -y build-essential chrpath git-core libssl-dev libfontconfig1-dev
RUN cd /usr/local/share
RUN apt-get install -y wget
ENV PHANTOMJS_VERISON 1.9.8
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERISON-linux-x86_64.tar.bz2
RUN tar xjf phantomjs-$PHANTOMJS_VERISON-linux-x86_64.tar.bz2
RUN ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
RUN ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
RUN ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
RUN apt-get install nodejs -y

RUN apt-get install imagemagick -y

RUN git clone git://github.com/peatio/peatio.git
#RUN cd peatio
WORKDIR peatio

RUN bundle config --global git.allow_insecure true
RUN bundle config --global silence_root_warning 1
RUN bundle install

RUN bundle exec rake daemons:start

# Make port X available to the world outside this container
EXPOSE 3000

# Run app.py when the container launches
CMD ["bundle", "exec", "rails", "server"]

