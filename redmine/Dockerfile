FROM sameersbn/redmine:4.1.1-9

ENV SESSION_KEY_SUFFIX=""

COPY vendor/cache/ vendor/cache/

RUN set -ux \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        #antiword \
        #catdoc \
        #catdvi \
        #djview \
        #djview3 \
        #gcc \
        gosu \
        #gzip \
        #libemail-outlook-message-perl \
        #libwpd-tools \
        #libwps-tools \
        #libxapian-dev \
        #make \
        #poppler-utils \
        #ruby-xapian \
        #uuid \
        #uuid-dev \
        #unrtf \
        #unzip \
        #xapian-omega \
        #xpdf \
        #xz-utils \
    && rm -rf /var/lib/apt/lists/* \
    && chown -R redmine:redmine vendor/cache \
    \
# install plugins
    && gosu redmine git config --global http.sslverify false \
    #&& gosu redmine git clone --depth 1 https://github.com/clear-code/redmine_full_text_search.git plugins/full_text_search \
    && gosu redmine git clone --depth 1 https://github.com/akiko-pusu/redmine_banner.git plugins/redmine_banner \
    #&& gosu redmine git clone --depth 1 https://github.com/jbbarth/redmine_base_deface.git plugins/redmine_base_deface \
    #&& gosu redmine git clone --depth 1 https://github.com/danmunn/redmine_dmsf.git plugins/redmine_dmsf \
    #&& gosu redmine git clone --depth 1 https://github.com/jbbarth/redmine_drafts.git plugins/redmine_drafts \
    #&& gosu redmine git clone --depth 1 https://github.com/akiko-pusu/redmine_issue_badge.git plugins/redmine_issue_badge \
    && gosu redmine git clone --depth 1 https://github.com/redmica/redmine_issues_panel.git plugins/redmine_issues_panel \
    #&& gosu redmine git clone --depth 1 https://github.com/akiko-pusu/redmine_issue_templates.git  plugins/redmine_issue_templates \
    && gosu redmine git clone --depth 1 https://github.com/AlphaNodes/redmine_messenger.git plugins/redmine_messenger \
    #&& gosu redmine git clone --depth 1 https://github.com/farend/scm-creator.git plugins/redmine_scm \
    && gosu redmine git clone --depth 1 https://github.com/haru/redmine_wiki_extensions.git plugins/redmine_wiki_extensions \
    && gosu redmine git clone --depth 1 https://github.com/gtt-project/sidebar_hide.git plugins/sidebar_hide \
    #&& gosu redmine git clone --depth 1 https://gitlab.com/bdemirkir/sidebar_hide.git plugins/sidebar_hide \
    && gosu redmine git clone --depth 1 https://github.com/onozaty/redmine-view-customize.git plugins/view_customize \
    \
# install themes
    && gosu redmine git clone -b redmine4.1 --depth 1 https://github.com/farend/redmine_theme_farend_bleuclair.git public/themes/bleuclair \
    && gosu redmine git clone --depth 1 https://github.com/farend/redmine_theme_farend_basic.git public/themes/farend_basic \
    \
# install gems
    && gosu redmine bundle install --local --no-cache

RUN set -ux \
    \
    && sed -i -r "s/(:filter_html => true)/#\1/" lib/redmine/wiki_formatting/markdown/formatter.rb \
    && sed -i -r "s/(:key => '_redmine_session')/\1 + ENV['SESSION_KEY_SUFFIX']/" config/application.rb
