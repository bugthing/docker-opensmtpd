FROM base/archlinux
RUN pacman -Syy && pacman -S --noconfirm --quiet opensmtpd && mkdir /etc/smtpd/conf
VOLUME ["/etc/smtpd"]
EXPOSE [25]
CMD ["/usr/bin/smtpd", "-d"]
