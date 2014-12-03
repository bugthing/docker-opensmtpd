FROM base/archlinux
RUN pacman -Syy && pacman -S --noconfirm --quiet opensmtpd
VOLUME ["/etc/smtpd"]
EXPOSE 25
CMD ["/usr/bin/smtpd", "-d"]
