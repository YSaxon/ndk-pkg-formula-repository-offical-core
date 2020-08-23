summary="XML 1.0 parser"
homepage="https://libexpat.github.io/"
url="https://github.com/libexpat/libexpat/releases/download/R_2_2_9/expat-2.2.9.tar.xz"
sha256="1ea6965b15c2106b6bbe883397271c80dfa0331cdf821b2c319591b55eadc0a4"

build() {
    cmake \
    -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$DIR_INSTALL_PREFIX" \
    -DEXPAT_BUILD_DOCS=OFF \
    -DEXPAT_BUILD_TESTS=OFF \
    -DEXPAT_BUILD_FUZZERS=OFF \
    -DEXPAT_BUILD_EXAMPLES=OFF \
    -DEXPAT_BUILD_TOOLS=ON \
    -DEXPAT_SHARED_LIBS=ON \
    -DANDROID_TOOLCHAIN=clang \
    -DANDROID_ABI="$TARGET_ABI" \
    -DANDROID_PLATFORM="$TARGET_API" \
    -G "Unix Makefiles" \
    -Wno-dev \
    -S . \
    -B "$DIR_BUILD" &&
    make --directory="$DIR_BUILD" -j$(nproc) install
}
