summary  "Subtitle renderer for the ASS/SSA subtitle format"
homepage "https://github.com/libass/libass"
url      "https://github.com/libass/libass/releases/download/0.14.0/libass-0.14.0.tar.xz"
sha256   "881f2382af48aead75b7a0e02e65d88c5ebd369fe46bc77d9270a94aa8fd38a2"
license  "ISC"
dependencies "freetype fribidi harfbuzz"

build() {
    configure
}
