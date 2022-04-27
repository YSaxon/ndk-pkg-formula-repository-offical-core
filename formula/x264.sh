pkg_set summary "H.264/AVC encoder"
pkg_set webpage "https://www.videolan.org/developers/x264.html"
pkg_set git.url "https://code.videolan.org/videolan/x264.git"
pkg_set git.sha "5db6aa6cab1b146e07b60cc1736a01f21da01154"
pkg_set version "r3060"
pkg_set license "GPL-2.0-only|COPYING|https://code.videolan.org/videolan/x264/-/raw/master/COPYING"
pkg_set bsystem "configure"

prepare() {
    sed_in_place 's/define fseek fseeko/true/' configure &&
    sed_in_place 's/define ftell ftello/true/' configure
}

build() {
    configure \
        --disable-asm \
        --enable-cli \
        --enable-pic \
        --enable-lto \
        --enable-strip
}
