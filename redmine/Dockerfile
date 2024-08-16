FROM sameersbn/redmine:5.1.3

ENV SESSION_KEY_SUFFIX=""

# Copy gems
#COPY vendor/cache/ vendor/cache/

# Change gems authority
#RUN set -ux \
#    \
#    && chown -R redmine:redmine vendor/cache

# Install tools
RUN set -ux \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        gosu \
        gzip \
        #make \
        #unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Plugins And Themes
RUN set -ux \
    && gosu redmine git config --global http.sslverify false \
# Install plugins
    #&& gosu redmine git clone -b 0.3.4 --depth 1 https://github.com/akiko-pusu/redmine_banner.git plugins/redmine_banner \
    && gosu redmine git clone -b v1.0.2 --depth 1 https://github.com/redmica/redmine_issues_panel.git plugins/redmine_issues_panel \
    && gosu redmine git clone -b 0.9.5 --depth 1 https://github.com/haru/redmine_wiki_extensions.git plugins/redmine_wiki_extensions \
    && gosu redmine git clone -b v3.5.2 --depth 1 https://github.com/onozaty/redmine-view-customize.git plugins/view_customize \
    \
# Install themes
    && gosu redmine git clone -b 0.5.0 --depth 1 https://github.com/farend/redmine_theme_farend_bleuclair.git public/themes/bleuclair \
    && gosu redmine git clone -b 1.4 --depth 1 https://github.com/farend/redmine_theme_farend_basic.git public/themes/farend_basic \
    && gosu redmine git clone -b v1.2.1 --depth 1 https://github.com/makotokw/redmine-theme-gitmike.git public/themes/gitmike \
    \
# Install gems
    && gosu redmine bundle config set without development test \
    #&& gosu redmine bundle install --local --no-cache
    && gosu redmine bundle install --no-cache


# set SESSION_KEY_SUFFIX
RUN set -ux \
    \
    #&& sed -i -r "s/(:filter_html => true)/#\1/" lib/redmine/wiki_formatting/markdown/formatter.rb \
    && sed -i -r "s/(:key => '_redmine_session')/\1 + ENV['SESSION_KEY_SUFFIX']/" config/application.rb
