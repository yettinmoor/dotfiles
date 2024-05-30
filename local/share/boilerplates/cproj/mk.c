#define NS_IMPL
#include "./src/ns/ns.h"

int main(int argc, cstr* argv) {
    unused(argc);
    unused(argv);

    log_set_level(LOG_LVL_DBG);
    rebuild_self(argv);

    Mk mk = { 0 };

    mk_add(&mk, "cc");
    mk_add(&mk, "-g");
    mk_add(&mk, "-Og");
    mk_add(&mk, "-Wall", "-Wextra");
    mk_add(&mk, "-Isrc", "-Isrc/ns");
    mk_add(&mk, "-o", "%NAME");
    mk_add_src_dir(&mk, "src");

    int code = mk_run(&mk);
    if (code == 0) {
        log_info("build ok.");
    } else {
        log_err("build error <%d>.", code);
    }
}
