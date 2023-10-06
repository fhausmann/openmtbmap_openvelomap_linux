FROM alpine:3.18

RUN apk add --no-cache zsh p7zip wget openjdk11
RUN wget http://www.gmaptool.eu/sites/default/files/lgmt08220.zip && \
    unzip lgmt08220.zip gmt && \
    mv gmt /usr/local/bin/


RUN wget https://www.mkgmap.org.uk/download/mkgmap-r4912.zip && \
    unzip mkgmap-r4912.zip && \
    mkdir -p /usr/local/share/mkgmap/ && \
    mv mkgmap-r4912/* /usr/local/share/mkgmap/

COPY create_omtb_garmin_img.sh /usr/local/bin/
RUN chmod uog+x /usr/local/bin/gmt /usr/local/bin/create_omtb_garmin_img.sh
ENTRYPOINT ["/usr/local/bin/create_omtb_garmin_img.sh", "-m", "/usr/local/share/mkgmap/mkgmap.jar"]



