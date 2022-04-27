pkg_set summary "High performance message passing library"
pkg_set webpage "https://www.open-mpi.org"
pkg_set git.url "https://github.com/open-mpi/ompi.git"
pkg_set src.url "https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.3.tar.bz2"
pkg_set src.sha "3d81d04c54efb55d3871a465ffb098d8d72c1f48ff1cbaf2580eb058567c0a3b"
pkg_set license "BSD-3-Clause|LICENSE|https://raw.githubusercontent.com/open-mpi/ompi/main/LICENSE"
pkg_set dep.pkg "libevent"
pkg_set dep.cmd "perl"
pkg_set bsystem "configure"
pkg_set cdefine "POSIX_MADV_DONTNEED=MADV_DONTNEED"

# int shmctl(int __shm_id, int __cmd, struct shmid_ds* __buf) __INTRODUCED_IN(26);
pkg_set sdk.api 26

prepare() {
    sed_in_place 's/#define HAS_SHMDT/#define XXXXXXXXX/' opal/mca/memory/patcher/memory_patcher_component.c &&
    sed_in_place 's/#define HAS_SHMAT/#define YYYYYYYYY/' opal/mca/memory/patcher/memory_patcher_component.c &&
    sed_in_place 's/HAS_SHMDT/(defined(SYS_shmdt) || (defined(IPCOP_shmdt) \&\& defined(SYS_ipc)))/' opal/mca/memory/patcher/memory_patcher_component.c &&
    sed_in_place 's/HAS_SHMAT/(defined(SYS_shmat) || (defined(IPCOP_shmat) \&\& defined(SYS_ipc)))/' opal/mca/memory/patcher/memory_patcher_component.c &&
    sed_in_place '/#include <stdlib.h>/a #include "../include/opal_config.h"' opal/util/malloc.h &&
    sed_in_place 's/rindex(/strrchr(/g' orte/mca/plm/rsh/plm_rsh_module.c &&
    sed_in_place 's/rindex(/strrchr(/g' oshmem/mca/memheap/base/memheap_base_static.c &&
    sed_in_place 's/bcmp(/memcmp(/g'    ompi/mca/topo/treematch/treematch/tm_malloc.c &&
    sed_in_place '1i static int getdtablesize(void);' orte/mca/state/base/state_base_fns.c &&
    cat >> orte/mca/state/base/state_base_fns.c <<EOF
#include <sys/cdefs.h>
#include <sys/resource.h>
#include <linux/kernel.h>
static int getdtablesize(void) {
    struct rlimit r;
    if (getrlimit(RLIMIT_NOFILE, &r) < 0) {
        return sysconf(_SC_OPEN_MAX);
    }
    return r.rlim_cur;
}
EOF
}

build() {
    configure \
        --disable-coverage \
        --disable-mpi-fortran \
        --disable-mpi-java \
        --disable-oshmem-fortran \
        --disable-builtin-atomics \
        --enable-sysv-shmem=no \
        --enable-sysv-sshmem=no \
        --enable-binaries \
        --with-libevent="$libevent_INSTALL_DIR" \
        FC=''
}
