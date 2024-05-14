FROM alpine:3.19

ENV MKGMAP_VERSION=r4919

RUN apk add --no-cache zsh p7zip wget openjdk11
RUN wget http://www.gmaptool.eu/sites/default/files/lgmt08220.zip && \
    unzip lgmt08220.zip gmt && \
    mv gmt /usr/local/bin/


RUN wget https://www.mkgmap.org.uk/download/mkgmap-$MKGMAP_VERSION.zip && \
    unzip mkgmap-$MKGMAP_VERSION.zip && \
    mkdir -p /usr/local/share/mkgmap/ && \
    mv mkgmap-$MKGMAP_VERSION/* /usr/local/share/mkgmap/

COPY create_omtb_garmin_img.sh /usr/local/bin/
RUN chmod uog+x /usr/local/bin/gmt /usr/local/bin/create_omtb_garmin_img.sh
ENTRYPOINT ["/usr/local/bin/create_omtb_garmin_img.sh", "-m", "/usr/local/share/mkgmap/mkgmap.jar"]



