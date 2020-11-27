summary  "BSD-style licensed readline alternative"
homepage "https://thrysoee.dk/editline"
url      "https://thrysoee.dk/editline/libedit-20191231-3.1.tar.gz"
sha256   "dbb82cb7e116a5f8025d35ef5b4f7d4a3cdd0a3909a146a39112095a2d229071"
dependencies "ncurses"

build() {
    export CPPFLAGS="$CPPFLAGS -D__STDC_ISO_10646__ -DNBBY=1"

    configure --disable-examples
}
