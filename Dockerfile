FROM brimstone/debian:sid

ENTRYPOINT ["/loader"]

EXPOSE 22

# Install needed packages
RUN package weechat-curses vim rsync libwww-perl \
       ssh tmux zsh sudo cron libtext-charwidth-perl less git psmisc \
       python-potr bitlbee \
       curl python-websocket \
    && rm /etc/ssh/ssh_host_* \
    && sed '/%sudo/s/^.*$/%sudo   ALL=(ALL:ALL) NOPASSWD: ALL/' -i /etc/sudoers \
    && sed '/pam_loginuid.so/s/^/#/g' -i  /etc/pam.d/* \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && echo "LANG=\"en_US.UTF-8\"" > /etc/default/locale \
    && locale-gen en_US.UTF-8

COPY loader /loader
