<div>
    <img title="Mail icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/internet-mail.png" />
    <img title="Desktop search icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/catfish.png" />
    <img title="Web browser icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/web-browser.png" />
    <img title="Photos icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/multimedia-photo-manager.png" />
    <img title="Network error icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/network-error.png" />
    <img title="Notification icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/xfce4-notifyd.png" />
    <img title="Power Manager icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/preferences-system-power.png" />
    <img title="Menu Editor icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/menulibre.png" />
    <img title="Gmusicbrowser icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/gmusicbrowser.png" />
    <img title="Parole Video player icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/parole.png" />
    <img title="Libreoffice Writer icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/libreoffice-writer.png" />
    <img title="Terminal icon" src="https://simon.shimmerproject.org/wp-content/uploads/2018/05/utilities-terminal.png" />
 </div>

# elementary-xfce Icon theme

This is an icon-theme maintained with Xfce in mind, but it should work on other desktops like Gnome3 as well.

It is a fork of the upstream [elementary project](http://elementary.io). The reason for forking was that the project decided to focus on its own desktop environment and dropped a ton of (ugly, but necessary) symlinks. This icon-theme is supposed to keep everything working, but gets updates from upstream occasionally.

We'd like to encourage you to not only consider contributing to this, but also to the original icon-set.

## Installation

You can use the Makefile to install the theme locally (default prefix is /usr/local).

### Build dependencies
- optipng
- GTK3

### Installation for the current user only (without admin privileges)

```
./configure --prefix=$HOME/.local
make
make install
make icon-caches
```

### Installation for all users

```
./configure
make
sudo make install
sudo make icon-caches
