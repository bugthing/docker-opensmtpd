FROM base/archlinux
RUN sed -i "s/^SigLevel.*/SigLevel = Never/g" /etc/pacman.conf \
    && pacman --noconfirm -Sy archlinux-keyring \
    && pacman-key --populate \
    && pacman-key --refresh-keys \
    && pacman --noconfirm -Syyuu \
    && pacman-db-upgrade
RUN pacman -S --noconfirm --quiet opensmtpd
VOLUME ["/etc/smtpd"]
EXPOSE 25
CMD ["/usr/bin/smtpd", "-d"]
