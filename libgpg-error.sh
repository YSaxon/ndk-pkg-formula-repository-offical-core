summary="Common error values for all GnuPG components"
homepage="https://www.gnupg.org/related_software/libgpg-error"
url="https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.37.tar.bz2"
sha256="b32d6ff72a73cf79797f7f2d039e95e9c6f92f0c1450215410840ab62aea9763"

prepare() {
    cp src/syscfg/lock-obj-pub.arm-unknown-linux-androideabi.h src/syscfg/lock-obj-pub.armv7a-unknown-linux-androideabi.h &&
    cp src/syscfg/lock-obj-pub.aarch64-unknown-linux-gnu.h     src/syscfg/lock-obj-pub.aarch64-unknown-linux-android.h &&
    cp src/syscfg/lock-obj-pub.i686-unknown-linux-gnu.h        src/syscfg/lock-obj-pub.i686-unknown-linux-android.h &&
    cp src/syscfg/lock-obj-pub.x86_64-unknown-linux-gnu.h      src/syscfg/lock-obj-pub.x86_64-unknown-linux-android.h
}

build() {
    ./configure \
        --host="$TARGET_HOST" \
        --prefix="$DIR_INSTALL_PREFIX" \
        --with-sysroot="$SYSROOT" \
        --disable-build-timestamp \
        --disable-languages \
        --disable-tests \
        --disable-nls \
        --enable-static \
        --enable-shared \
        --enable-largefile \
        --enable-doc \
        --enable-threads=posix \
        --enable-werror \
        CC="$CC" \
        CFLAGS="$CFLAGS" \
        CPPFLAGS="$CPPFLAGS" \
        LDFLAGS="$LDFLAGS" \
        AR="$AR" \
        RANLIB="$RANLIB" \
        PKG_CONFIG='' && \
    make clean &&
    make install
}
