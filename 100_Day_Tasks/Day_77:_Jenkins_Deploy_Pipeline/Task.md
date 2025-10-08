### Task : Jenkins Deploy Pipeline


### What I Did

Jumphost terminal
```
(66/143): libXau-1.0.9-8.el9.x86_64.rpm                                                         917 kB/s |  31 kB     00:00    
(67/143): libXcomposite-0.4.5-7.el9.x86_64.rpm                                                  702 kB/s |  24 kB     00:00    
(68/143): libXcursor-1.2.0-7.el9.x86_64.rpm                                                     901 kB/s |  31 kB     00:00    
(69/143): libXdamage-1.1.5-7.el9.x86_64.rpm                                                     670 kB/s |  23 kB     00:00    
(70/143): libXext-1.3.4-8.el9.x86_64.rpm                                                        1.1 MB/s |  40 kB     00:00    
(71/143): libXfixes-5.0.3-16.el9.x86_64.rpm                                                     578 kB/s |  20 kB     00:00    
(72/143): libXft-2.3.3-8.el9.x86_64.rpm                                                         1.7 MB/s |  62 kB     00:00    
(73/143): libXi-1.7.10-8.el9.x86_64.rpm                                                         1.1 MB/s |  40 kB     00:00    
(74/143): libXinerama-1.1.4-10.el9.x86_64.rpm                                                   438 kB/s |  15 kB     00:00    
(75/143): libXrandr-1.5.2-8.el9.x86_64.rpm                                                      835 kB/s |  28 kB     00:00    
(76/143): libXrender-0.9.10-16.el9.x86_64.rpm                                                   818 kB/s |  28 kB     00:00    
(77/143): libXtst-1.2.3-16.el9.x86_64.rpm                                                       626 kB/s |  21 kB     00:00    
(78/143): libappstream-glib-0.7.18-5.el9.x86_64.rpm                                              10 MB/s | 395 kB     00:00    
(79/143): libasyncns-0.8-22.el9.x86_64.rpm                                                      892 kB/s |  30 kB     00:00    
(80/143): libcanberra-0.30-27.el9.x86_64.rpm                                                    2.4 MB/s |  86 kB     00:00    
(81/143): libcanberra-gtk3-0.30-27.el9.x86_64.rpm                                               927 kB/s |  32 kB     00:00    
(82/143): libdatrie-0.2.13-4.el9.x86_64.rpm                                                     969 kB/s |  33 kB     00:00    
(83/143): libepoxy-1.5.5-4.el9.x86_64.rpm                                                       6.6 MB/s | 241 kB     00:00    
(84/143): libfontenc-1.1.3-17.el9.x86_64.rpm                                                    897 kB/s |  31 kB     00:00    
(85/143): libjpeg-turbo-2.0.90-7.el9.x86_64.rpm                                                 4.8 MB/s | 175 kB     00:00    
(86/143): libldac-2.0.2.3-10.el9.x86_64.rpm                                                     1.2 MB/s |  41 kB     00:00    
(87/143): libnotify-0.7.9-8.el9.x86_64.rpm                                                      1.2 MB/s |  44 kB     00:00    
(88/143): libogg-1.3.4-6.el9.x86_64.rpm                                                         981 kB/s |  34 kB     00:00    
(89/143): libproxy-webkitgtk4-0.4.15-35.el9.x86_64.rpm                                          635 kB/s |  22 kB     00:00    
(90/143): librsvg2-2.50.7-3.el9.x86_64.rpm                                                       41 MB/s | 3.2 MB     00:00    
(91/143): libsbc-1.4-9.el9.x86_64.rpm                                                           1.3 MB/s |  45 kB     00:00    
(92/143): libsndfile-1.0.31-9.el9.x86_64.rpm                                                    5.5 MB/s | 206 kB     00:00    
(93/143): libsoup-2.72.0-10.el9.x86_64.rpm                                                      9.6 MB/s | 403 kB     00:00    
(94/143): libstemmer-0-18.585svn.el9.x86_64.rpm                                                 2.4 MB/s |  83 kB     00:00    
(95/143): libthai-0.1.28-8.el9.x86_64.rpm                                                       5.6 MB/s | 208 kB     00:00    
(96/143): libtiff-4.4.0-15.el9.x86_64.rpm                                                       5.3 MB/s | 197 kB     00:00    
(97/143): libtracker-sparql-3.1.2-3.el9.x86_64.rpm                                              8.1 MB/s | 324 kB     00:00    
(98/143): libvorbis-1.3.7-5.el9.x86_64.rpm                                                      5.2 MB/s | 193 kB     00:00    
(99/143): libwayland-client-1.21.0-1.el9.x86_64.rpm                                             980 kB/s |  33 kB     00:00    
(100/143): libwayland-cursor-1.21.0-1.el9.x86_64.rpm                                            567 kB/s |  19 kB     00:00    
(101/143): libwayland-egl-1.21.0-1.el9.x86_64.rpm                                               373 kB/s |  13 kB     00:00    
(102/143): libwebp-1.2.0-8.el9.x86_64.rpm                                                       7.2 MB/s | 277 kB     00:00    
(103/143): libxcb-1.13.1-9.el9.x86_64.rpm                                                       6.4 MB/s | 243 kB     00:00    
(104/143): libxkbcommon-1.0.3-4.el9.x86_64.rpm                                                  3.7 MB/s | 133 kB     00:00    
(105/143): low-memory-monitor-2.1-4.el9.x86_64.rpm                                              1.0 MB/s |  36 kB     00:00    
(106/143): lua-5.4.4-4.el9.x86_64.rpm                                                           5.1 MB/s | 188 kB     00:00    
(107/143): lua-posix-35.0-8.el9.x86_64.rpm                                                      4.2 MB/s | 151 kB     00:00    
(108/143): mkfontscale-1.2.1-3.el9.x86_64.rpm                                                   937 kB/s |  32 kB     00:00    
(109/143): nspr-4.36.0-4.el9.x86_64.rpm                                                         3.7 MB/s | 133 kB     00:00    
(110/143): nss-3.112.0-4.el9.x86_64.rpm                                                          16 MB/s | 722 kB     00:00    
(111/143): nss-softokn-3.112.0-4.el9.x86_64.rpm                                                 9.7 MB/s | 399 kB     00:00    
(112/143): polkit-libs-0.117-14.el9.x86_64.rpm                                                  1.7 MB/s | 8.3 MB     00:04    
(113/143): nss-softokn-freebl-3.112.0-4.el9.x86_64.rpm                                          8.6 MB/s | 413 kB     00:00    
(114/143): nss-util-3.112.0-4.el9.x86_64.rpm                                                    2.5 MB/s |  88 kB     00:00    
(115/143): opus-1.3.1-10.el9.x86_64.rpm                                                         5.3 MB/s | 200 kB     00:00    
(116/143): nss-sysinit-3.112.0-4.el9.x86_64.rpm                                                 183 kB/s |  18 kB     00:00    
(117/143): ostree-libs-2025.2-1.el9.x86_64.rpm                                                   11 MB/s | 476 kB     00:00    
(118/143): pango-1.48.7-3.el9.x86_64.rpm                                                        7.7 MB/s | 302 kB     00:00    
(119/143): pipewire-1.0.1-1.el9.x86_64.rpm                                                      3.0 MB/s | 107 kB     00:00    
(120/143): libicu-67.1-10.el9.x86_64.rpm                                                        1.7 MB/s | 9.6 MB     00:05    
(121/143): pipewire-alsa-1.0.1-1.el9.x86_64.rpm                                                 1.2 MB/s |  57 kB     00:00    
(122/143): p11-kit-server-0.25.3-2.el9.x86_64.rpm                                               1.6 MB/s | 246 kB     00:00    
(123/143): pipewire-jack-audio-connection-kit-libs-1.0.1-1.el9.x86_64.rpm                       3.7 MB/s | 135 kB     00:00    
(124/143): pipewire-jack-audio-connection-kit-1.0.1-1.el9.x86_64.rpm                            144 kB/s | 9.1 kB     00:00    
(125/143): pipewire-pulseaudio-1.0.1-1.el9.x86_64.rpm                                           5.2 MB/s | 192 kB     00:00    
(126/143): pulseaudio-libs-15.0-3.el9.x86_64.rpm                                                 15 MB/s | 676 kB     00:00    
(127/143): pipewire-libs-1.0.1-1.el9.x86_64.rpm                                                  13 MB/s | 1.9 MB     00:00    
(128/143): rtkit-0.11-29.el9.x86_64.rpm                                                         1.6 MB/s |  56 kB     00:00    
(129/143): sound-theme-freedesktop-0.8-17.el9.noarch.rpm                                        9.6 MB/s | 383 kB     00:00    
(130/143): tracker-3.1.2-3.el9.x86_64.rpm                                                        13 MB/s | 555 kB     00:00    
(131/143): pixman-0.40.0-6.el9.x86_64.rpm                                                       1.7 MB/s | 269 kB     00:00    
(132/143): ttmkfdir-3.0.9-65.el9.x86_64.rpm                                                     1.5 MB/s |  53 kB     00:00    
(133/143): tzdata-java-2025b-2.el9.noarch.rpm                                                   5.9 MB/s | 223 kB     00:00    
(134/143): webrtc-audio-processing-0.3.1-8.el9.x86_64.rpm                                       8.0 MB/s | 306 kB     00:00    
(135/143): wireplumber-0.4.14-1.el9.x86_64.rpm                                                  2.7 MB/s |  96 kB     00:00    
(136/143): wireplumber-libs-0.4.14-1.el9.x86_64.rpm                                             9.1 MB/s | 358 kB     00:00    
(137/143): xdg-dbus-proxy-0.1.3-1.el9.x86_64.rpm                                                1.2 MB/s |  42 kB     00:00    
(138/143): xdg-desktop-portal-1.12.6-1.el9.x86_64.rpm                                           9.5 MB/s | 385 kB     00:00    
(139/143): xdg-desktop-portal-gtk-1.12.0-3.el9.x86_64.rpm                                       3.3 MB/s | 134 kB     00:00    
(140/143): xml-common-0.6.3-58.el9.noarch.rpm                                                   935 kB/s |  32 kB     00:00    
(141/143): xkeyboard-config-2.33-2.el9.noarch.rpm                                                18 MB/s | 859 kB     00:00    
(142/143): xorg-x11-fonts-Type1-7.5-33.el9.noarch.rpm                                            12 MB/s | 505 kB     00:00    
(143/143): webkit2gtk3-jsc-2.48.5-1.el9.x86_64.rpm                                               34 MB/s | 8.5 MB     00:00    
--------------------------------------------------------------------------------------------------------------------------------
Total                                                                                            15 MB/s | 125 MB     00:08     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Running scriptlet: copy-jdk-configs-4.0-3.el9.noarch                                                                      1/1 
  Running scriptlet: java-17-openjdk-headless-1:17.0.16.0.8-2.el9.x86_64                                                    1/1 
  Preparing        :                                                                                                        1/1 
  Installing       : nspr-4.36.0-4.el9.x86_64                                                                             1/143 
  Installing       : libpng-2:1.6.37-12.el9.x86_64                                                                        2/143 
  Installing       : json-glib-1.6.6-1.el9.x86_64                                                                         3/143 
  Installing       : avahi-libs-0.8-23.el9.x86_64                                                                         4/143 
  Installing       : nss-util-3.112.0-4.el9.x86_64                                                                        5/143 
  Installing       : alsa-lib-1.2.14-1.el9.x86_64                                                                         6/143 
  Installing       : libstemmer-0-18.585svn.el9.x86_64                                                                    7/143 
  Installing       : libogg-2:1.3.4-6.el9.x86_64                                                                          8/143 
  Installing       : libvorbis-1:1.3.7-5.el9.x86_64                                                                       9/143 
  Installing       : atk-2.36.0-5.el9.x86_64                                                                             10/143 
  Installing       : polkit-libs-0.117-14.el9.x86_64                                                                     11/143 
  Installing       : libicu-67.1-10.el9.x86_64                                                                           12/143 
  Running scriptlet: polkit-0.117-14.el9.x86_64                                                                          13/143 
  Installing       : polkit-0.117-14.el9.x86_64                                                                          13/143 
  Running scriptlet: polkit-0.117-14.el9.x86_64                                                                          13/143 
  Installing       : polkit-pkla-compat-0.1-21.el9.x86_64                                                                14/143 
  Installing       : cups-libs-1:2.3.3op2-33.el9.x86_64                                                                  15/143 
  Installing       : pixman-0.40.0-6.el9.x86_64                                                                          16/143 
  Installing       : opus-1.3.1-10.el9.x86_64                                                                            17/143 
  Installing       : libwayland-client-1.21.0-1.el9.x86_64                                                               18/143 
  Installing       : libjpeg-turbo-2.0.90-7.el9.x86_64                                                                   19/143 
  Installing       : libXau-1.0.9-8.el9.x86_64                                                                           20/143 
  Installing       : libxcb-1.13.1-9.el9.x86_64                                                                          21/143 
  Installing       : fribidi-1.0.10-6.el9.2.x86_64                                                                       22/143 
  Installing       : dconf-0.40.0-6.el9.x86_64                                                                           23/143 
  Running scriptlet: dconf-0.40.0-6.el9.x86_64                                                                           23/143 
  Installing       : libusbx-1.0.26-1.el9.x86_64                                                                         24/143 
  Installing       : libtool-ltdl-2.4.6-46.el9.x86_64                                                                    25/143 
  Installing       : libtdb-1.4.13-1.el9.x86_64                                                                          26/143 
  Installing       : libproxy-0.4.15-35.el9.x86_64                                                                       27/143 
  Installing       : libbrotli-1.0.9-7.el9.x86_64                                                                        28/143 
  Installing       : fuse-libs-2.9.9-17.el9.x86_64                                                                       29/143 
  Installing       : libgusb-0.3.8-2.el9.x86_64                                                                          30/143 
  Installing       : libwayland-cursor-1.21.0-1.el9.x86_64                                                               31/143 
  Running scriptlet: rtkit-0.11-29.el9.x86_64                                                                            32/143 
  Installing       : rtkit-0.11-29.el9.x86_64                                                                            32/143 
  Running scriptlet: rtkit-0.11-29.el9.x86_64                                                                            32/143 
Created symlink /etc/systemd/system/graphical.target.wants/rtkit-daemon.service → /usr/lib/systemd/system/rtkit-daemon.service.

  Installing       : flac-libs-1.3.3-12.el9.x86_64                                                                       33/143 
  Installing       : nss-softokn-freebl-3.112.0-4.el9.x86_64                                                             34/143 
  Installing       : nss-softokn-3.112.0-4.el9.x86_64                                                                    35/143 
  Installing       : nss-3.112.0-4.el9.x86_64                                                                            36/143 
  Running scriptlet: nss-3.112.0-4.el9.x86_64                                                                            36/143 
  Installing       : nss-sysinit-3.112.0-4.el9.x86_64                                                                    37/143 
  Installing       : avahi-glib-0.8-23.el9.x86_64                                                                        38/143 
  Running scriptlet: xml-common-0.6.3-58.el9.noarch                                                                      39/143 
  Installing       : xml-common-0.6.3-58.el9.noarch                                                                      39/143 
  Installing       : xkeyboard-config-2.33-2.el9.noarch                                                                  40/143 
  Installing       : libxkbcommon-1.0.3-4.el9.x86_64                                                                     41/143 
  Installing       : xdg-dbus-proxy-0.1.3-1.el9.x86_64                                                                   42/143 
  Installing       : webrtc-audio-processing-0.3.1-8.el9.x86_64                                                          43/143 
  Installing       : tzdata-java-2025b-2.el9.noarch                                                                      44/143 
  Installing       : sound-theme-freedesktop-0.8-17.el9.noarch                                                           45/143 
  Running scriptlet: sound-theme-freedesktop-0.8-17.el9.noarch                                                           45/143 
  Installing       : p11-kit-server-0.25.3-2.el9.x86_64                                                                  46/143 
  Installing       : lua-posix-35.0-8.el9.x86_64                                                                         47/143 
  Installing       : lua-5.4.4-4.el9.x86_64                                                                              48/143 
  Installing       : copy-jdk-configs-4.0-3.el9.noarch                                                                   49/143 
  Installing       : low-memory-monitor-2.1-4.el9.x86_64                                                                 50/143 
  Running scriptlet: low-memory-monitor-2.1-4.el9.x86_64                                                                 50/143 
Created symlink /etc/systemd/system/basic.target.wants/low-memory-monitor.service → /usr/lib/systemd/system/low-memory-monitor.service.

  Installing       : libwebp-1.2.0-8.el9.x86_64                                                                          51/143 
  Installing       : libwayland-egl-1.21.0-1.el9.x86_64                                                                  52/143 
  Installing       : libsbc-1.4-9.el9.x86_64                                                                             53/143 
  Installing       : libldac-2.0.2.3-10.el9.x86_64                                                                       54/143 
  Installing       : libfontenc-1.1.3-17.el9.x86_64                                                                      55/143 
  Installing       : libepoxy-1.5.5-4.el9.x86_64                                                                         56/143 
  Installing       : libdatrie-0.2.13-4.el9.x86_64                                                                       57/143 
  Installing       : libthai-0.1.28-8.el9.x86_64                                                                         58/143 
  Installing       : libasyncns-0.8-22.el9.x86_64                                                                        59/143 
  Installing       : libX11-common-1.7.0-11.el9.noarch                                                                   60/143 
  Installing       : libX11-1.7.0-11.el9.x86_64                                                                          61/143 
  Installing       : libXext-1.3.4-8.el9.x86_64                                                                          62/143 
  Installing       : libXrender-0.9.10-16.el9.x86_64                                                                     63/143 
  Installing       : libXi-1.7.10-8.el9.x86_64                                                                           64/143 
  Installing       : libXfixes-5.0.3-16.el9.x86_64                                                                       65/143 
  Installing       : libXtst-1.2.3-16.el9.x86_64                                                                         66/143 
  Installing       : libXcomposite-0.4.5-7.el9.x86_64                                                                    67/143 
  Installing       : at-spi2-core-2.40.3-1.el9.x86_64                                                                    68/143 
  Installing       : at-spi2-atk-2.38.0-4.el9.x86_64                                                                     69/143 
  Installing       : libXcursor-1.2.0-7.el9.x86_64                                                                       70/143 
  Installing       : libXdamage-1.1.5-7.el9.x86_64                                                                       71/143 
  Installing       : libXrandr-1.5.2-8.el9.x86_64                                                                        72/143 
  Installing       : libXinerama-1.1.4-10.el9.x86_64                                                                     73/143 
  Installing       : lcms2-2.12-3.el9.x86_64                                                                             74/143 
  Installing       : colord-libs-1.4.5-4.el9.x86_64                                                                      75/143 
  Installing       : jbigkit-libs-2.1-23.el9.x86_64                                                                      76/143 
  Installing       : libtiff-4.4.0-15.el9.x86_64                                                                         77/143 
  Installing       : javapackages-filesystem-6.4.0-1.el9.noarch                                                          78/143 
  Installing       : hicolor-icon-theme-0.17-13.el9.noarch                                                               79/143 
  Installing       : gstreamer1-1.22.12-3.el9.x86_64                                                                     80/143 
  Installing       : gsm-1.0.19-6.el9.x86_64                                                                             81/143 
  Installing       : libsndfile-1.0.31-9.el9.x86_64                                                                      82/143 
  Installing       : pulseaudio-libs-15.0-3.el9.x86_64                                                                   83/143 
  Installing       : libcanberra-0.30-27.el9.x86_64                                                                      84/143 
  Running scriptlet: libcanberra-0.30-27.el9.x86_64                                                                      84/143 
  Installing       : flatpak-session-helper-1.12.9-4.el9.x86_64                                                          85/143 
  Installing       : fdk-aac-free-2.0.0-8.el9.x86_64                                                                     86/143 
  Installing       : composefs-libs-1.0.8-1.el9.x86_64                                                                   87/143 
  Installing       : ostree-libs-2025.2-1.el9.x86_64                                                                     88/143 
  Installing       : adwaita-cursor-theme-40.1.1-3.el9.noarch                                                            89/143 
  Installing       : adwaita-icon-theme-40.1.1-3.el9.noarch                                                              90/143 
  Installing       : abattis-cantarell-fonts-0.301-4.el9.noarch                                                          91/143 
  Installing       : shared-mime-info-2.1-5.el9.x86_64                                                                   92/143 
  Running scriptlet: shared-mime-info-2.1-5.el9.x86_64                                                                   92/143 
  Installing       : gdk-pixbuf2-2.42.6-6.el9.x86_64                                                                     93/143 
  Installing       : gdk-pixbuf2-modules-2.42.6-6.el9.x86_64                                                             94/143 
  Installing       : gtk-update-icon-cache-3.24.31-8.el9.x86_64                                                          95/143 
  Installing       : libnotify-0.7.9-8.el9.x86_64                                                                        96/143 
  Installing       : publicsuffix-list-dafsa-20210518-3.el9.noarch                                                       97/143 
  Installing       : libpsl-0.21.1-5.el9.x86_64                                                                          98/143 
  Installing       : lksctp-tools-1.0.19-2.el9.x86_64                                                                    99/143 
  Installing       : java-17-openjdk-headless-1:17.0.16.0.8-2.el9.x86_64                                                100/143 
  Running scriptlet: java-17-openjdk-headless-1:17.0.16.0.8-2.el9.x86_64                                                100/143 
  Installing       : libatomic-11.5.0-11.el9.x86_64                                                                     101/143 
  Installing       : webkit2gtk3-jsc-2.48.5-1.el9.x86_64                                                                102/143 
  Installing       : libproxy-webkitgtk4-0.4.15-35.el9.x86_64                                                           103/143 
  Installing       : graphite2-1.3.14-9.el9.x86_64                                                                      104/143 
  Installing       : harfbuzz-2.7.4-10.el9.x86_64                                                                       105/143 
  Installing       : freetype-2.10.4-11.el9.x86_64                                                                      106/143 
  Installing       : fontconfig-2.14.0-2.el9.x86_64                                                                     107/143 
  Running scriptlet: fontconfig-2.14.0-2.el9.x86_64                                                                     107/143 
  Installing       : cairo-1.17.4-7.el9.x86_64                                                                          108/143 
  Installing       : cairo-gobject-1.17.4-7.el9.x86_64                                                                  109/143 
  Installing       : libXft-2.3.3-8.el9.x86_64                                                                          110/143 
  Installing       : pango-1.48.7-3.el9.x86_64                                                                          111/143 
  Installing       : librsvg2-2.50.7-3.el9.x86_64                                                                       112/143 
  Installing       : mkfontscale-1.2.1-3.el9.x86_64                                                                     113/143 
  Installing       : ttmkfdir-3.0.9-65.el9.x86_64                                                                       114/143 
  Installing       : xorg-x11-fonts-Type1-7.5-33.el9.noarch                                                             115/143 
  Running scriptlet: xorg-x11-fonts-Type1-7.5-33.el9.noarch                                                             115/143 
  Installing       : fuse-common-3.10.2-9.el9.x86_64                                                                    116/143 
  Installing       : fuse-2.9.9-17.el9.x86_64                                                                           117/143 
  Installing       : bubblewrap-0.6.3-1.el9.x86_64                                                                      118/143 
  Installing       : bluez-libs-5.72-4.el9.x86_64                                                                       119/143 
  Running scriptlet: pipewire-1.0.1-1.el9.x86_64                                                                        120/143 
  Installing       : pipewire-1.0.1-1.el9.x86_64                                                                        120/143 
  Running scriptlet: pipewire-1.0.1-1.el9.x86_64                                                                        120/143 
Created symlink /etc/systemd/user/sockets.target.wants/pipewire.socket → /usr/lib/systemd/user/pipewire.socket.

  Installing       : pipewire-libs-1.0.1-1.el9.x86_64                                                                   121/143 
  Installing       : wireplumber-0.4.14-1.el9.x86_64                                                                    122/143 
  Installing       : wireplumber-libs-0.4.14-1.el9.x86_64                                                               123/143 
  Installing       : pipewire-jack-audio-connection-kit-libs-1.0.1-1.el9.x86_64                                         124/143 
  Installing       : adobe-source-code-pro-fonts-2.030.1.050-12.el9.1.noarch                                            125/143 
  Installing       : gsettings-desktop-schemas-40.0-7.el9.x86_64                                                        126/143 
  Installing       : glib-networking-2.68.3-3.el9.x86_64                                                                127/143 
  Installing       : libsoup-2.72.0-10.el9.x86_64                                                                       128/143 
  Installing       : tracker-3.1.2-3.el9.x86_64                                                                         129/143 
  Running scriptlet: tracker-3.1.2-3.el9.x86_64                                                                         129/143 
  Installing       : libtracker-sparql-3.1.2-3.el9.x86_64                                                               130/143 
  Installing       : libappstream-glib-0.7.18-5.el9.x86_64                                                              131/143 
  Installing       : ModemManager-glib-1.20.2-1.el9.x86_64                                                              132/143 
  Running scriptlet: geoclue2-2.6.0-7.el9.x86_64                                                                        133/143 
  Installing       : geoclue2-2.6.0-7.el9.x86_64                                                                        133/143 
  Running scriptlet: geoclue2-2.6.0-7.el9.x86_64                                                                        133/143 
  Running scriptlet: flatpak-1.12.9-4.el9.x86_64                                                                        134/143 
  Installing       : flatpak-1.12.9-4.el9.x86_64                                                                        134/143 
  Installing       : xdg-desktop-portal-1.12.6-1.el9.x86_64                                                             135/143 
  Running scriptlet: xdg-desktop-portal-1.12.6-1.el9.x86_64                                                             135/143 
  Installing       : libcanberra-gtk3-0.30-27.el9.x86_64                                                                136/143 
  Installing       : gtk3-3.24.31-8.el9.x86_64                                                                          137/143 
  Installing       : xdg-desktop-portal-gtk-1.12.0-3.el9.x86_64                                                         138/143 
  Running scriptlet: xdg-desktop-portal-gtk-1.12.0-3.el9.x86_64                                                         138/143 
  Installing       : java-17-openjdk-1:17.0.16.0.8-2.el9.x86_64                                                         139/143 
  Running scriptlet: java-17-openjdk-1:17.0.16.0.8-2.el9.x86_64                                                         139/143 
  Installing       : java-17-openjdk-devel-1:17.0.16.0.8-2.el9.x86_64                                                   140/143 
  Running scriptlet: java-17-openjdk-devel-1:17.0.16.0.8-2.el9.x86_64                                                   140/143 
  Installing       : pipewire-jack-audio-connection-kit-1.0.1-1.el9.x86_64                                              141/143 
  Installing       : pipewire-alsa-1.0.1-1.el9.x86_64                                                                   142/143 
  Installing       : pipewire-pulseaudio-1.0.1-1.el9.x86_64                                                             143/143 
  Running scriptlet: pipewire-pulseaudio-1.0.1-1.el9.x86_64                                                             143/143 
Created symlink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket → /usr/lib/systemd/user/pipewire-pulse.socket.

  Running scriptlet: dconf-0.40.0-6.el9.x86_64                                                                          143/143 
  Running scriptlet: nss-3.112.0-4.el9.x86_64                                                                           143/143 
  Running scriptlet: copy-jdk-configs-4.0-3.el9.noarch                                                                  143/143 
  Running scriptlet: java-17-openjdk-headless-1:17.0.16.0.8-2.el9.x86_64                                                143/143 
  Running scriptlet: fontconfig-2.14.0-2.el9.x86_64                                                                     143/143 
  Running scriptlet: wireplumber-0.4.14-1.el9.x86_64                                                                    143/143 
Created symlink /etc/systemd/user/pipewire-session-manager.service → /usr/lib/systemd/user/wireplumber.service.
Created symlink /etc/systemd/user/pipewire.service.wants/wireplumber.service → /usr/lib/systemd/user/wireplumber.service.

  Running scriptlet: java-17-openjdk-1:17.0.16.0.8-2.el9.x86_64                                                         143/143 
  Running scriptlet: java-17-openjdk-devel-1:17.0.16.0.8-2.el9.x86_64                                                   143/143 
  Running scriptlet: pipewire-pulseaudio-1.0.1-1.el9.x86_64                                                             143/143 
  Verifying        : ModemManager-glib-1.20.2-1.el9.x86_64                                                                1/143 
  Verifying        : adobe-source-code-pro-fonts-2.030.1.050-12.el9.1.noarch                                              2/143 
  Verifying        : avahi-libs-0.8-23.el9.x86_64                                                                         3/143 
  Verifying        : bluez-libs-5.72-4.el9.x86_64                                                                         4/143 
  Verifying        : bubblewrap-0.6.3-1.el9.x86_64                                                                        5/143 
  Verifying        : cups-libs-1:2.3.3op2-33.el9.x86_64                                                                   6/143 
  Verifying        : freetype-2.10.4-11.el9.x86_64                                                                        7/143 
  Verifying        : fuse-2.9.9-17.el9.x86_64                                                                             8/143 
  Verifying        : fuse-common-3.10.2-9.el9.x86_64                                                                      9/143 
  Verifying        : fuse-libs-2.9.9-17.el9.x86_64                                                                       10/143 
  Verifying        : glib-networking-2.68.3-3.el9.x86_64                                                                 11/143 
  Verifying        : graphite2-1.3.14-9.el9.x86_64                                                                       12/143 
  Verifying        : gsettings-desktop-schemas-40.0-7.el9.x86_64                                                         13/143 
  Verifying        : harfbuzz-2.7.4-10.el9.x86_64                                                                        14/143 
  Verifying        : json-glib-1.6.6-1.el9.x86_64                                                                        15/143 
  Verifying        : libatomic-11.5.0-11.el9.x86_64                                                                      16/143 
  Verifying        : libbrotli-1.0.9-7.el9.x86_64                                                                        17/143 
  Verifying        : libgusb-0.3.8-2.el9.x86_64                                                                          18/143 
  Verifying        : libicu-67.1-10.el9.x86_64                                                                           19/143 
  Verifying        : libpng-2:1.6.37-12.el9.x86_64                                                                       20/143 
  Verifying        : libproxy-0.4.15-35.el9.x86_64                                                                       21/143 
  Verifying        : libpsl-0.21.1-5.el9.x86_64                                                                          22/143 
  Verifying        : libtdb-1.4.13-1.el9.x86_64                                                                          23/143 
  Verifying        : libtool-ltdl-2.4.6-46.el9.x86_64                                                                    24/143 
  Verifying        : libusbx-1.0.26-1.el9.x86_64                                                                         25/143 
  Verifying        : lksctp-tools-1.0.19-2.el9.x86_64                                                                    26/143 
  Verifying        : polkit-0.117-14.el9.x86_64                                                                          27/143 
  Verifying        : polkit-libs-0.117-14.el9.x86_64                                                                     28/143 
  Verifying        : polkit-pkla-compat-0.1-21.el9.x86_64                                                                29/143 
  Verifying        : publicsuffix-list-dafsa-20210518-3.el9.noarch                                                       30/143 
  Verifying        : shared-mime-info-2.1-5.el9.x86_64                                                                   31/143 
  Verifying        : abattis-cantarell-fonts-0.301-4.el9.noarch                                                          32/143 
  Verifying        : adwaita-cursor-theme-40.1.1-3.el9.noarch                                                            33/143 
  Verifying        : adwaita-icon-theme-40.1.1-3.el9.noarch                                                              34/143 
  Verifying        : alsa-lib-1.2.14-1.el9.x86_64                                                                        35/143 
  Verifying        : at-spi2-atk-2.38.0-4.el9.x86_64                                                                     36/143 
  Verifying        : at-spi2-core-2.40.3-1.el9.x86_64                                                                    37/143 
  Verifying        : atk-2.36.0-5.el9.x86_64                                                                             38/143 
  Verifying        : avahi-glib-0.8-23.el9.x86_64                                                                        39/143 
  Verifying        : cairo-1.17.4-7.el9.x86_64                                                                           40/143 
  Verifying        : cairo-gobject-1.17.4-7.el9.x86_64                                                                   41/143 
  Verifying        : colord-libs-1.4.5-4.el9.x86_64                                                                      42/143 
  Verifying        : composefs-libs-1.0.8-1.el9.x86_64                                                                   43/143 
  Verifying        : copy-jdk-configs-4.0-3.el9.noarch                                                                   44/143 
  Verifying        : dconf-0.40.0-6.el9.x86_64                                                                           45/143 
  Verifying        : fdk-aac-free-2.0.0-8.el9.x86_64                                                                     46/143 
  Verifying        : flac-libs-1.3.3-12.el9.x86_64                                                                       47/143 
  Verifying        : flatpak-1.12.9-4.el9.x86_64                                                                         48/143 
  Verifying        : flatpak-session-helper-1.12.9-4.el9.x86_64                                                          49/143 
  Verifying        : fontconfig-2.14.0-2.el9.x86_64                                                                      50/143 
  Verifying        : fribidi-1.0.10-6.el9.2.x86_64                                                                       51/143 
  Verifying        : gdk-pixbuf2-2.42.6-6.el9.x86_64                                                                     52/143 
  Verifying        : gdk-pixbuf2-modules-2.42.6-6.el9.x86_64                                                             53/143 
  Verifying        : geoclue2-2.6.0-7.el9.x86_64                                                                         54/143 
  Verifying        : gsm-1.0.19-6.el9.x86_64                                                                             55/143 
  Verifying        : gstreamer1-1.22.12-3.el9.x86_64                                                                     56/143 
  Verifying        : gtk-update-icon-cache-3.24.31-8.el9.x86_64                                                          57/143 
  Verifying        : gtk3-3.24.31-8.el9.x86_64                                                                           58/143 
  Verifying        : hicolor-icon-theme-0.17-13.el9.noarch                                                               59/143 
  Verifying        : java-17-openjdk-1:17.0.16.0.8-2.el9.x86_64                                                          60/143 
  Verifying        : java-17-openjdk-devel-1:17.0.16.0.8-2.el9.x86_64                                                    61/143 
  Verifying        : java-17-openjdk-headless-1:17.0.16.0.8-2.el9.x86_64                                                 62/143 
  Verifying        : javapackages-filesystem-6.4.0-1.el9.noarch                                                          63/143 
  Verifying        : jbigkit-libs-2.1-23.el9.x86_64                                                                      64/143 
  Verifying        : lcms2-2.12-3.el9.x86_64                                                                             65/143 
  Verifying        : libX11-1.7.0-11.el9.x86_64                                                                          66/143 
  Verifying        : libX11-common-1.7.0-11.el9.noarch                                                                   67/143 
  Verifying        : libXau-1.0.9-8.el9.x86_64                                                                           68/143 
  Verifying        : libXcomposite-0.4.5-7.el9.x86_64                                                                    69/143 
  Verifying        : libXcursor-1.2.0-7.el9.x86_64                                                                       70/143 
  Verifying        : libXdamage-1.1.5-7.el9.x86_64                                                                       71/143 
  Verifying        : libXext-1.3.4-8.el9.x86_64                                                                          72/143 
  Verifying        : libXfixes-5.0.3-16.el9.x86_64                                                                       73/143 
  Verifying        : libXft-2.3.3-8.el9.x86_64                                                                           74/143 
  Verifying        : libXi-1.7.10-8.el9.x86_64                                                                           75/143 
  Verifying        : libXinerama-1.1.4-10.el9.x86_64                                                                     76/143 
  Verifying        : libXrandr-1.5.2-8.el9.x86_64                                                                        77/143 
  Verifying        : libXrender-0.9.10-16.el9.x86_64                                                                     78/143 
  Verifying        : libXtst-1.2.3-16.el9.x86_64                                                                         79/143 
  Verifying        : libappstream-glib-0.7.18-5.el9.x86_64                                                               80/143 
  Verifying        : libasyncns-0.8-22.el9.x86_64                                                                        81/143 
  Verifying        : libcanberra-0.30-27.el9.x86_64                                                                      82/143 
  Verifying        : libcanberra-gtk3-0.30-27.el9.x86_64                                                                 83/143 
  Verifying        : libdatrie-0.2.13-4.el9.x86_64                                                                       84/143 
  Verifying        : libepoxy-1.5.5-4.el9.x86_64                                                                         85/143 
  Verifying        : libfontenc-1.1.3-17.el9.x86_64                                                                      86/143 
  Verifying        : libjpeg-turbo-2.0.90-7.el9.x86_64                                                                   87/143 
  Verifying        : libldac-2.0.2.3-10.el9.x86_64                                                                       88/143 
  Verifying        : libnotify-0.7.9-8.el9.x86_64                                                                        89/143 
  Verifying        : libogg-2:1.3.4-6.el9.x86_64                                                                         90/143 
  Verifying        : libproxy-webkitgtk4-0.4.15-35.el9.x86_64                                                            91/143 
  Verifying        : librsvg2-2.50.7-3.el9.x86_64                                                                        92/143 
  Verifying        : libsbc-1.4-9.el9.x86_64                                                                             93/143 
  Verifying        : libsndfile-1.0.31-9.el9.x86_64                                                                      94/143 
  Verifying        : libsoup-2.72.0-10.el9.x86_64                                                                        95/143 
  Verifying        : libstemmer-0-18.585svn.el9.x86_64                                                                   96/143 
  Verifying        : libthai-0.1.28-8.el9.x86_64                                                                         97/143 
  Verifying        : libtiff-4.4.0-15.el9.x86_64                                                                         98/143 
  Verifying        : libtracker-sparql-3.1.2-3.el9.x86_64                                                                99/143 
  Verifying        : libvorbis-1:1.3.7-5.el9.x86_64                                                                     100/143 
  Verifying        : libwayland-client-1.21.0-1.el9.x86_64                                                              101/143 
  Verifying        : libwayland-cursor-1.21.0-1.el9.x86_64                                                              102/143 
  Verifying        : libwayland-egl-1.21.0-1.el9.x86_64                                                                 103/143 
  Verifying        : libwebp-1.2.0-8.el9.x86_64                                                                         104/143 
  Verifying        : libxcb-1.13.1-9.el9.x86_64                                                                         105/143 
  Verifying        : libxkbcommon-1.0.3-4.el9.x86_64                                                                    106/143 
  Verifying        : low-memory-monitor-2.1-4.el9.x86_64                                                                107/143 
  Verifying        : lua-5.4.4-4.el9.x86_64                                                                             108/143 
  Verifying        : lua-posix-35.0-8.el9.x86_64                                                                        109/143 
  Verifying        : mkfontscale-1.2.1-3.el9.x86_64                                                                     110/143 
  Verifying        : nspr-4.36.0-4.el9.x86_64                                                                           111/143 
  Verifying        : nss-3.112.0-4.el9.x86_64                                                                           112/143 
  Verifying        : nss-softokn-3.112.0-4.el9.x86_64                                                                   113/143 
  Verifying        : nss-softokn-freebl-3.112.0-4.el9.x86_64                                                            114/143 
  Verifying        : nss-sysinit-3.112.0-4.el9.x86_64                                                                   115/143 
  Verifying        : nss-util-3.112.0-4.el9.x86_64                                                                      116/143 
  Verifying        : opus-1.3.1-10.el9.x86_64                                                                           117/143 
  Verifying        : ostree-libs-2025.2-1.el9.x86_64                                                                    118/143 
  Verifying        : p11-kit-server-0.25.3-2.el9.x86_64                                                                 119/143 
  Verifying        : pango-1.48.7-3.el9.x86_64                                                                          120/143 
  Verifying        : pipewire-1.0.1-1.el9.x86_64                                                                        121/143 
  Verifying        : pipewire-alsa-1.0.1-1.el9.x86_64                                                                   122/143 
  Verifying        : pipewire-jack-audio-connection-kit-1.0.1-1.el9.x86_64                                              123/143 
  Verifying        : pipewire-jack-audio-connection-kit-libs-1.0.1-1.el9.x86_64                                         124/143 
  Verifying        : pipewire-libs-1.0.1-1.el9.x86_64                                                                   125/143 
  Verifying        : pipewire-pulseaudio-1.0.1-1.el9.x86_64                                                             126/143 
  Verifying        : pixman-0.40.0-6.el9.x86_64                                                                         127/143 
  Verifying        : pulseaudio-libs-15.0-3.el9.x86_64                                                                  128/143 
  Verifying        : rtkit-0.11-29.el9.x86_64                                                                           129/143 
  Verifying        : sound-theme-freedesktop-0.8-17.el9.noarch                                                          130/143 
  Verifying        : tracker-3.1.2-3.el9.x86_64                                                                         131/143 
  Verifying        : ttmkfdir-3.0.9-65.el9.x86_64                                                                       132/143 
  Verifying        : tzdata-java-2025b-2.el9.noarch                                                                     133/143 
  Verifying        : webkit2gtk3-jsc-2.48.5-1.el9.x86_64                                                                134/143 
  Verifying        : webrtc-audio-processing-0.3.1-8.el9.x86_64                                                         135/143 
  Verifying        : wireplumber-0.4.14-1.el9.x86_64                                                                    136/143 
  Verifying        : wireplumber-libs-0.4.14-1.el9.x86_64                                                               137/143 
  Verifying        : xdg-dbus-proxy-0.1.3-1.el9.x86_64                                                                  138/143 
  Verifying        : xdg-desktop-portal-1.12.6-1.el9.x86_64                                                             139/143 
  Verifying        : xdg-desktop-portal-gtk-1.12.0-3.el9.x86_64                                                         140/143 
  Verifying        : xkeyboard-config-2.33-2.el9.noarch                                                                 141/143 
  Verifying        : xml-common-0.6.3-58.el9.noarch                                                                     142/143 
  Verifying        : xorg-x11-fonts-Type1-7.5-33.el9.noarch                                                             143/143 

Installed:
  ModemManager-glib-1.20.2-1.el9.x86_64                             abattis-cantarell-fonts-0.301-4.el9.noarch                  
  adobe-source-code-pro-fonts-2.030.1.050-12.el9.1.noarch           adwaita-cursor-theme-40.1.1-3.el9.noarch                    
  adwaita-icon-theme-40.1.1-3.el9.noarch                            alsa-lib-1.2.14-1.el9.x86_64                                
  at-spi2-atk-2.38.0-4.el9.x86_64                                   at-spi2-core-2.40.3-1.el9.x86_64                            
  atk-2.36.0-5.el9.x86_64                                           avahi-glib-0.8-23.el9.x86_64                                
  avahi-libs-0.8-23.el9.x86_64                                      bluez-libs-5.72-4.el9.x86_64                                
  bubblewrap-0.6.3-1.el9.x86_64                                     cairo-1.17.4-7.el9.x86_64                                   
  cairo-gobject-1.17.4-7.el9.x86_64                                 colord-libs-1.4.5-4.el9.x86_64                              
  composefs-libs-1.0.8-1.el9.x86_64                                 copy-jdk-configs-4.0-3.el9.noarch                           
  cups-libs-1:2.3.3op2-33.el9.x86_64                                dconf-0.40.0-6.el9.x86_64                                   
  fdk-aac-free-2.0.0-8.el9.x86_64                                   flac-libs-1.3.3-12.el9.x86_64                               
  flatpak-1.12.9-4.el9.x86_64                                       flatpak-session-helper-1.12.9-4.el9.x86_64                  
  fontconfig-2.14.0-2.el9.x86_64                                    freetype-2.10.4-11.el9.x86_64                               
  fribidi-1.0.10-6.el9.2.x86_64                                     fuse-2.9.9-17.el9.x86_64                                    
  fuse-common-3.10.2-9.el9.x86_64                                   fuse-libs-2.9.9-17.el9.x86_64                               
  gdk-pixbuf2-2.42.6-6.el9.x86_64                                   gdk-pixbuf2-modules-2.42.6-6.el9.x86_64                     
  geoclue2-2.6.0-7.el9.x86_64                                       glib-networking-2.68.3-3.el9.x86_64                         
  graphite2-1.3.14-9.el9.x86_64                                     gsettings-desktop-schemas-40.0-7.el9.x86_64                 
  gsm-1.0.19-6.el9.x86_64                                           gstreamer1-1.22.12-3.el9.x86_64                             
  gtk-update-icon-cache-3.24.31-8.el9.x86_64                        gtk3-3.24.31-8.el9.x86_64                                   
  harfbuzz-2.7.4-10.el9.x86_64                                      hicolor-icon-theme-0.17-13.el9.noarch                       
  java-17-openjdk-1:17.0.16.0.8-2.el9.x86_64                        java-17-openjdk-devel-1:17.0.16.0.8-2.el9.x86_64            
  java-17-openjdk-headless-1:17.0.16.0.8-2.el9.x86_64               javapackages-filesystem-6.4.0-1.el9.noarch                  
  jbigkit-libs-2.1-23.el9.x86_64                                    json-glib-1.6.6-1.el9.x86_64                                
  lcms2-2.12-3.el9.x86_64                                           libX11-1.7.0-11.el9.x86_64                                  
  libX11-common-1.7.0-11.el9.noarch                                 libXau-1.0.9-8.el9.x86_64                                   
  libXcomposite-0.4.5-7.el9.x86_64                                  libXcursor-1.2.0-7.el9.x86_64                               
  libXdamage-1.1.5-7.el9.x86_64                                     libXext-1.3.4-8.el9.x86_64                                  
  libXfixes-5.0.3-16.el9.x86_64                                     libXft-2.3.3-8.el9.x86_64                                   
  libXi-1.7.10-8.el9.x86_64                                         libXinerama-1.1.4-10.el9.x86_64                             
  libXrandr-1.5.2-8.el9.x86_64                                      libXrender-0.9.10-16.el9.x86_64                             
  libXtst-1.2.3-16.el9.x86_64                                       libappstream-glib-0.7.18-5.el9.x86_64                       
  libasyncns-0.8-22.el9.x86_64                                      libatomic-11.5.0-11.el9.x86_64                              
  libbrotli-1.0.9-7.el9.x86_64                                      libcanberra-0.30-27.el9.x86_64                              
  libcanberra-gtk3-0.30-27.el9.x86_64                               libdatrie-0.2.13-4.el9.x86_64                               
  libepoxy-1.5.5-4.el9.x86_64                                       libfontenc-1.1.3-17.el9.x86_64                              
  libgusb-0.3.8-2.el9.x86_64                                        libicu-67.1-10.el9.x86_64                                   
  libjpeg-turbo-2.0.90-7.el9.x86_64                                 libldac-2.0.2.3-10.el9.x86_64                               
  libnotify-0.7.9-8.el9.x86_64                                      libogg-2:1.3.4-6.el9.x86_64                                 
  libpng-2:1.6.37-12.el9.x86_64                                     libproxy-0.4.15-35.el9.x86_64                               
  libproxy-webkitgtk4-0.4.15-35.el9.x86_64                          libpsl-0.21.1-5.el9.x86_64                                  
  librsvg2-2.50.7-3.el9.x86_64                                      libsbc-1.4-9.el9.x86_64                                     
  libsndfile-1.0.31-9.el9.x86_64                                    libsoup-2.72.0-10.el9.x86_64                                
  libstemmer-0-18.585svn.el9.x86_64                                 libtdb-1.4.13-1.el9.x86_64                                  
  libthai-0.1.28-8.el9.x86_64                                       libtiff-4.4.0-15.el9.x86_64                                 
  libtool-ltdl-2.4.6-46.el9.x86_64                                  libtracker-sparql-3.1.2-3.el9.x86_64                        
  libusbx-1.0.26-1.el9.x86_64                                       libvorbis-1:1.3.7-5.el9.x86_64                              
  libwayland-client-1.21.0-1.el9.x86_64                             libwayland-cursor-1.21.0-1.el9.x86_64                       
  libwayland-egl-1.21.0-1.el9.x86_64                                libwebp-1.2.0-8.el9.x86_64                                  
  libxcb-1.13.1-9.el9.x86_64                                        libxkbcommon-1.0.3-4.el9.x86_64                             
  lksctp-tools-1.0.19-2.el9.x86_64                                  low-memory-monitor-2.1-4.el9.x86_64                         
  lua-5.4.4-4.el9.x86_64                                            lua-posix-35.0-8.el9.x86_64                                 
  mkfontscale-1.2.1-3.el9.x86_64                                    nspr-4.36.0-4.el9.x86_64                                    
  nss-3.112.0-4.el9.x86_64                                          nss-softokn-3.112.0-4.el9.x86_64                            
  nss-softokn-freebl-3.112.0-4.el9.x86_64                           nss-sysinit-3.112.0-4.el9.x86_64                            
  nss-util-3.112.0-4.el9.x86_64                                     opus-1.3.1-10.el9.x86_64                                    
  ostree-libs-2025.2-1.el9.x86_64                                   p11-kit-server-0.25.3-2.el9.x86_64                          
  pango-1.48.7-3.el9.x86_64                                         pipewire-1.0.1-1.el9.x86_64                                 
  pipewire-alsa-1.0.1-1.el9.x86_64                                  pipewire-jack-audio-connection-kit-1.0.1-1.el9.x86_64       
  pipewire-jack-audio-connection-kit-libs-1.0.1-1.el9.x86_64        pipewire-libs-1.0.1-1.el9.x86_64                            
  pipewire-pulseaudio-1.0.1-1.el9.x86_64                            pixman-0.40.0-6.el9.x86_64                                  
  polkit-0.117-14.el9.x86_64                                        polkit-libs-0.117-14.el9.x86_64                             
  polkit-pkla-compat-0.1-21.el9.x86_64                              publicsuffix-list-dafsa-20210518-3.el9.noarch               
  pulseaudio-libs-15.0-3.el9.x86_64                                 rtkit-0.11-29.el9.x86_64                                    
  shared-mime-info-2.1-5.el9.x86_64                                 sound-theme-freedesktop-0.8-17.el9.noarch                   
  tracker-3.1.2-3.el9.x86_64                                        ttmkfdir-3.0.9-65.el9.x86_64                                
  tzdata-java-2025b-2.el9.noarch                                    webkit2gtk3-jsc-2.48.5-1.el9.x86_64                         
  webrtc-audio-processing-0.3.1-8.el9.x86_64                        wireplumber-0.4.14-1.el9.x86_64                             
  wireplumber-libs-0.4.14-1.el9.x86_64                              xdg-dbus-proxy-0.1.3-1.el9.x86_64                           
  xdg-desktop-portal-1.12.6-1.el9.x86_64                            xdg-desktop-portal-gtk-1.12.0-3.el9.x86_64                  
  xkeyboard-config-2.33-2.el9.noarch                                xml-common-0.6.3-58.el9.noarch                              
  xorg-x11-fonts-Type1-7.5-33.el9.noarch                           

Complete!
[root@ststor01 natasha]# java --version
openjdk 17.0.16 2025-07-15 LTS
OpenJDK Runtime Environment (Red_Hat-17.0.16.0.8-1) (build 17.0.16+8-LTS)
OpenJDK 64-Bit Server VM (Red_Hat-17.0.16.0.8-1) (build 17.0.16+8-LTS, mixed mode, sharing)
[root@ststor01 natasha]# cd /var/www/
[root@ststor01 www]# ls
html
[root@ststor01 www]# ls -l
total 4
drwxr-xr-x 3 sarah sarah 4096 Oct  8 09:17 html
[root@ststor01 www]# chown -R natasha html/
[root@ststor01 www]# ls -l
total 4
drwxr-xr-x 3 natasha sarah 4096 Oct  8 09:17 html
[root@ststor01 www]# cd html/
[root@ststor01 html]# ls
index.html  remoting  remoting.jar
[root@ststor01 html]# rm index.html 
rm: remove regular file 'index.html'? y
[root@ststor01 html]# ls
remoting  remoting.jar
[root@ststor01 html]# ls
caches  index.html  remoting  remoting.jar  workspace
[root@ststor01 html]# rm index.html 
rm: remove regular file 'index.html'? y
[root@ststor01 html]# ls
caches  index.html  remoting  remoting.jar  workspace
[root@ststor01 html]# history |cut -c 8-
java
yum install java-17-openjdk-17 -y
yum search java | grep openjdk
yum install java-17-openjdk-devel.x86_64
java --version
cd /var/www/
ls
ls -l
chown -R natasha html/
ls -l
cd html/
ls
rm index.html 
ls
ls
rm index.html 
ls
history |cut -c 8-
[root@ststor01 html]# 
```

### Pipeline Code

```
pipeline {
    agent {
        label 'ststor01'
    }
    
    stages {
        stage('Deploy') {
            steps {
                git branch: "master",
                    url: "http://git.stratos.xfusioncorp.com/sarah/web_app.git"
                
                sh "cp -r /var/www/html/workspace/xfusion-webapp-job/* /var/www/html/"
            }
        }
    }
}
```

OR

```
pipeline {
    agent {
        label 'ststor01'
    }
    stages {
        stage('Deploy') {
            steps {
                git url: "http://git.stratos.xfusioncorp.com/sarah/web_app.git", 
                    branch: "master"
                sh "cp -r * /var/www/html/"
            }
        }
    }
}
```
