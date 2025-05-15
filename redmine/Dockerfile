FROM sameersbn/redmine:6.0.3

ENV SESSION_KEY_SUFFIX=""

# Install tools
RUN set -ux \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        gosu \
        #gzip \
        #make \
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
    # clean
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy MySQL Installer
# URL:https://dev.mysql.com/downloads/mysql/
COPY tmp_mysql_installer/*.deb /tmp/

# install MySQL
RUN set -ux \
    && dpkg-preconfigure /tmp/mysql-community-server_*.deb \
    && dpkg -i /tmp/mysql-common_*.deb \
    && dpkg -i /tmp/mysql-community-client-plugins_*.deb \
    && dpkg -i /tmp/mysql-community-client-core_*.deb \
    && dpkg -i /tmp/mysql-community-client_*.deb \
    && dpkg -i /tmp/mysql-client_*.deb \
    && apt-get -f install

# Copy gems
#COPY vendor/cache/ vendor/cache/

# Change gems authority
#RUN set -ux \
#    \
#    && chown -R redmine:redmine vendor/cache

# Install Plugins And Themes
RUN set -ux \
    && gosu redmine git config --global http.sslverify false \
# Install plugins
    #&& gosu redmine git clone -b 0.3.5 --depth 1 https://github.com/agileware-jp/redmine_banner.git plugins/redmine_banner \
    #&& gosu redmine git clone -b v1.1.2 --depth 1 https://github.com/redmica/redmine_issues_panel.git plugins/redmine_issues_panel \
    #&& gosu redmine git clone -b 1.0.1 --depth 1 https://github.com/haru/redmine_wiki_extensions.git plugins/redmine_wiki_extensions \
    #&& gosu redmine git clone -b v3.5.2 --depth 1 https://github.com/onozaty/redmine-view-customize.git plugins/view_customize \
    #&& gosu redmine git clone -b v4.0.2 --depth 1 https://github.com/xelkano/redmine_xapian.git plugins/redmine_xapian \
    #&& gosu redmine git clone -b v0.4.1 --depth 1 https://github.com/redmica/redmica_ui_extension.git plugins/redmica_ui_extension \
    \
# Install themes
    && gosu redmine git clone -b v1.0.2 --depth 1 https://github.com/farend/redmine_theme_farend_bleuclair.git themes/bleuclair \
    && gosu redmine git clone -b 1.5 --depth 1 https://github.com/farend/redmine_theme_farend_basic.git themes/farend_basic \
    \
# Install gems
    && gosu redmine bundle config set without development test \
    && gosu redmine bundle install --no-cache
    #&& gosu redmine bundle install --local --no-cache
    #&& gosu redmine supervisorctl restart puma

# Set SESSION_KEY_SUFFIX
RUN set -ux \
    \
    #&& sed -i -r "s/(:filter_html => true)/#\1/" lib/redmine/wiki_formatting/markdown/formatter.rb \
    && sed -i -r "s/(:key => '_redmine_session')/\1 + ENV['SESSION_KEY_SUFFIX']/" config/application.rb
