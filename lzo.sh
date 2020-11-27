summary  "Real-time data compression library"
homepage "https://www.oberhumer.com/opensource/lzo"
url      "https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz"
sha256   "c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072"

build() {
    cmake \
    -DENABLE_STATIC=ON \
    -DENABLE_SHARED=ON
}
