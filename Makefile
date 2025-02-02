# Имя и версия curl
CURL_VERSION = 7.88.1
CURL_ARCHIVE = curl-$(CURL_VERSION).tar.gz
CURL_URL = https://curl.se/download/$(CURL_ARCHIVE)
CURL_DIR = curl-$(CURL_VERSION)

# Цели сборки
all: build

# Скачивание исходного кода
$(CURL_ARCHIVE):
    wget $(CURL_URL)

# Распаковка архива
$(CURL_DIR): $(CURL_ARCHIVE)
    tar -xvzf $(CURL_ARCHIVE)

# Конфигурирование сборки
configure: $(CURL_DIR)
    cd $(CURL_DIR) && ./configure --disable-all --enable-http --enable-https --enable-telnet --with-openssl

# Сборка curl
build: configure
    $(MAKE) -C $(CURL_DIR)

# Проверка собранного curl
check: build
    $(CURL_DIR)/src/curl --version

# Очистка временных файлов
clean:
    rm -rf $(CURL_DIR) $(CURL_ARCHIVE)

# Полная очистка (включая собранные файлы)
distclean: clean
    rm -rf $(CURL_DIR)/src/curl

.PHONY: all configure build check clean distclean