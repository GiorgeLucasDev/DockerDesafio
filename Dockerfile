# definição da imagem base que será utilizada
FROM php:8.2-fpm

# A variável DEBIAN_FRONTEND é definida como noninteractive
# que define o modo de interação do apt-get durante a instalação de pacotes.

ENV DEBIAN_FRONTEND noninteractive

# curl: uma ferramenta de linha de comando para transferência de dados;
# libmemcached-dev: uma biblioteca para uso do Memcached;
# libz-dev: uma biblioteca de compressão de dados;
# libpq-dev: uma biblioteca para acesso ao banco de dados PostgreSQL;
# libjpeg-dev, libpng-dev, libfreetype6-dev, libwebp-dev e libxpm-dev: bibliotecas para processamento de imagens;
# libssl-dev: uma biblioteca criptográfica;
# libmcrypt-dev: uma biblioteca para criptografia;
# libonig-dev: uma biblioteca para manipulação de strings.

RUN set -eux; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y --no-install-recommends \
            curl \
            libmemcached-dev \
            libz-dev \
            libpq-dev \
            libjpeg-dev \
            libpng-dev \
            libfreetype6-dev \
            libssl-dev \
            libwebp-dev \
            libxpm-dev \
            libmcrypt-dev \
            libonig-dev; \
    rm -rf /var/lib/apt/lists/*

# extensão pdo_mysql é instalada para suporte ao banco de dados MySQL
# extensão pdo_pgsql é instalada para suporte ao banco de dados PostgreSQL. 
# Também é instalada a biblioteca GD para manipulação de imagens no PHP.

RUN set -eux; \
    
    docker-php-ext-install pdo_mysql; \
    
    docker-php-ext-install pdo_pgsql; \
    
    docker-php-ext-configure gd \
            --prefix=/usr \
            --with-jpeg \
            --with-webp \
            --with-xpm \
            --with-freetype; \
    docker-php-ext-install gd; \
    php -r 'var_dump(gd_info());'

# a imagem é verificada com a execução do comando php -r 'var_dump(gd_info());'
# que exibe informações sobre a biblioteca GD instalada.