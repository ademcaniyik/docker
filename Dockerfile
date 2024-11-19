# Dockerfile: Kendi image dosyalarmızı olusturmak için kullanılır.
# diyez işareti yorum satırı için kullanılır.

#Image olarak Node.js kullandık

# FROM: Çalışacağımız image'ı gösteririz
FROM node:14

# LABEL: Bilgilendirmek
LABEL maintainer="Ademcan Iyık"

# ENV: Ortam değişkenleri
ENV APP_NAME="Nojde Js ile Dockerfile"
ENV VERSION="1.0.0"
ENV PORT=9999

RUN echo "App Name : ${APP_NAME}"
RUN echo "VERSION : ${VERSION}"
RUN echo "PORT : ${PORT}"



# VOLUME: Kalıcılık (Persist)
VOLUME /tmp


# WORKDIR: Çalışma dizini (uygulama için dosya yolu dizini)
WORKDIR /usr/src/app

# COPY: Image kopyalama için kullanırız
# package.json ve package-lock.json dosyalarını kopyala
COPY package*.json ./

# RUN: İmage için gerekli yüklemeler
# bağımlılıkları yükle
RUN npm install

# Uygulamada kodları kopyala
COPY . .

# EXPOSE: Port numarasını yazıyoruz dış dünyaya açılacak olan port
EXPOSE 1111

# CMD: Gerekli yüklemelerden sonra çalışmasını istediğimiz komutları buraya veririz
# Uygulamayı başlatmak için kullanırız
CMD [ "npm", "start" ]

# HEALTCHECK: Bu container çalışıyor mu çalışmıyor mu kontrolü için (sağlık kontrolü gibi düşünebiliriz)

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl --fail http://localhost:1111 || exit 1
# --interval=30s = Sağlık kontrolünü her 30 saniyede bir çalıştırsın
# --timeout=30s = 30 saniye boyunca sağlık kontrolunu yap
# --start-period=5s = 5 saniye sonra sağlık kontrolunu başlat
# --retries=3 = 3 kez sağlık kontrolunu yap
# CMD curl --fail http://localhost:1111 || exit 1 = Belirtilen url'de bunları yap

# USER: Kullanıcı göstersin USER poweruser
# ADD: Eklemeler
# ARG: Argumentler
# ENTRYPOINT: Çalıştırılacak komut yolunu veririz

#########################################################################
#########################################################################

# 1) Dockerfile Çalıştırma (image dosyasını alıyoruz aslında)
# docker build -t app_project .

# 2) Dockerfile'mızı container'e eklemek (imageyi conteinera ekliyoruz)
# docker container run --name project_node -d -p 1111:1111 app_project

# 3) Container'i kontrol etmek
# docker ps