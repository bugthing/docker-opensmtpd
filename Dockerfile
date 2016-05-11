FROM base/archlinux

RUN sed -i "s/^SigLevel.*/SigLevel = Never/g" /etc/pacman.conf \
    && pacman --noconfirm -Sy archlinux-keyring \
    && pacman-key --populate \
    && pacman-key --refresh-keys \
    && pacman --noconfirm -Syyuu \
    && pacman-db-upgrade
RUN pacman -S --noconfirm --quiet opensmtpd spamassassin

# For AUR - Add user, enable user for sudo, add base-devel, build and install cower and pacaur
RUN echo "%wheel        ALL=NOPASSWD: ALL" >> /etc/sudoers \
    && pacman -S --noconfirm --quiet base-devel wget \
    && useradd -m -g users -G wheel -s /bin/bash --home-dir /home/user user \
    && echo 'user:user' | chpasswd

USER user

RUN mkdir -p /home/user/src \
    && cd /home/user/src \
    && wget -O cower.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz \
    && tar xzf cower.tar.gz \
    && cd cower \
    && makepkg --noconfirm --skippgpcheck -s \
    && sudo pacman -U --noconfirm cower-*.pkg.tar.xz \
    && cd /home/user/src \
    && wget -O pacaur.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/pacaur.tar.gz \
    && tar xzf pacaur.tar.gz \
    && cd pacaur \
    && makepkg --noconfirm --skippgpcheck -s \
    && sudo pacman -U --noconfirm pacaur-*.pkg.tar.xz

RUN pacaur -S opensmtpd-extras

USER root

VOLUME ["/etc/smtpd"]
EXPOSE 25

CMD ["/usr/bin/smtpd", "-d"]
