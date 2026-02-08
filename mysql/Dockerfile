FROM mysql:8.0.45

LABEL maintainer="jumborin"

ENV TZ=Asia/Tokyo

RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

RUN echo "[mysqld]" > /etc/mysql/conf.d/custom.cnf \
    && echo "character-set-server = utf8mb4" >> /etc/mysql/conf.d/custom.cnf \
    && echo "collation-server = utf8mb4_unicode_ci" >> /etc/mysql/conf.d/custom.cnf \
    && echo "skip_name_resolve" >> /etc/mysql/conf.d/custom.cnf \
    && echo "lower_case_table_names = 2" >> /etc/mysql/conf.d/custom.cnf \
    && echo "" >> /etc/mysql/conf.d/custom.cnf \
    && echo "[client]" >> /etc/mysql/conf.d/custom.cnf \
    && echo "default-character-set = utf8mb4" >> /etc/mysql/conf.d/custom.cnf

CMD ["mysqld"]