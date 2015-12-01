FROM base/archlinux
RUN sed -i "s/^SigLevel.*/SigLevel = Never/g" /etc/pacman.conf \
    && pacman -Sc \
    && pacman -Syy \
    && pacman -S --noconfirm --quiet opensmtpd
VOLUME ["/etc/smtpd"]
EXPOSE 25
CMD ["/usr/bin/smtpd", "-d"]
