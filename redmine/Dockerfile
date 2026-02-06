FROM sameersbn/redmine:6.1.1

ENV SESSION_KEY_SUFFIX=""

# Install tools
RUN set -ux \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        gosu \
        curl \
        #gzip \
        #unzip \
    # Uninstall MariaDB
    && apt-get remove -y \
        mariadb-client-core \
        mariadb-client \
    # For Xapian
    && apt-get install -y --no-install-recommends \
        xapian-omega \
        libxapian-dev \
        poppler-utils \
        antiword \
        unzip \
        catdoc \
        libwpd-tools \
        libwps-tools \
        gzip \
        unrtf \
        catdvi \
        djview \
        djview3 \
        uuid \
        uuid-dev \
        xz-utils \
        libemail-outlook-message-perl \
        tesseract-ocr \
        markdown \
    # clean
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy MySQL Installer
# URL:https://dev.mysql.com/downloads/mysql/
COPY tmp_mysql_installer/*.deb /tmp/

# install MySQL
RUN set -ux \
    && dpkg -i /tmp/mysql-common_*.deb \
    && dpkg -i /tmp/mysql-community-client-plugins_*.deb \
    && dpkg -i /tmp/mysql-community-client-core_*.deb \
    && dpkg -i /tmp/mysql-community-client_*.deb \
    && apt-get -f install

# Copy gems
#COPY vendor/cache/ vendor/cache/

RUN set -ux \
    # Change gems folder authority
    #&& chown -R redmine:redmine vendor/cache \
# Install Plugins And Themes
    && gosu redmine git config --global http.sslverify false \
# Install plugins
    && gosu redmine git clone -b v1.2.0 --depth 1 https://github.com/redmica/redmine_issues_panel.git plugins/redmine_issues_panel \
    && gosu redmine git clone -b 1.2.0 --depth 1 https://github.com/haru/redmine_wiki_extensions.git plugins/redmine_wiki_extensions \
    && gosu redmine git clone -b v3.5.4 --depth 1 https://github.com/onozaty/redmine-view-customize.git plugins/view_customize \
    && gosu redmine git clone -b v4.0.4 --depth 1 https://github.com/xelkano/redmine_xapian.git plugins/redmine_xapian \
    \
# Install themes
    && gosu redmine git clone -b v2.0.2 --depth 1 https://github.com/farend/redmine_theme_farend_bleuclair.git themes/bleuclair \
    \
# Install gems
    && gosu redmine bundle config set --local without "development test" \
    && gosu redmine bundle install --no-cache 
    #&& gosu redmine bundle config set --local without development test \
    #&& gosu redmine bundle install --local --no-cache \
# For View Customize Plugins
    #&& gosu redmine bundle exec rake redmine:plugins:migrate RAILS_ENV=production \
# For Xapian Plugins
    #&& gosu redmine bundle exec rake assets:precompile RAILS_ENV=production \
    #&& ruby /home/redmine/redmine/plugins/redmine_xapian/extra/xapian_indexer.rb -v \
    #&& supervisorctl restart puma

# MySQL Configuration
RUN set -ux \
    && echo "default-character-set = utf8mb4" >> /etc/mysql/conf.d/mysql.cnf

# Rails Configuration
RUN set -ux \
    && sed -i -r "s/# config.time_zone/config.time_zone/" config/application.rb \
    && sed -i -r "s/Central Time \(US \& Canada\)/Tokyo/" config/application.rb

# Add Text Mime Types
RUN set -ux \
    && sed -i -r "s/'txt,tpl,properties,patch,diff,ini,readme,install,upgrade,sql'/'txt,tpl,properties,patch,diff,ini,readme,install,upgrade,sql,log'/" lib/redmine/mime_type.rb

# Set SESSION_KEY_SUFFIX
RUN set -ux \
    \
    && sed -i -r "s/(:key => '_redmine_session')/\1 + ENV['SESSION_KEY_SUFFIX']/" config/application.rb

# Prevent plugin deletion by removing --delete from rsync
RUN set -ux \
    && sed -i 's/rsync -avq --delete/rsync -avq/' /sbin/entrypoint.sh
