#define NS_IMPL
#include "ns.h"

// cli args
typedef struct {
    Slice(str) args;
    bool help;
    str infile;
} Input;

static Input parse(cstr* argv);

int main(int argc, cstr* argv) {
    log_set_level(LOG_LVL_DBG);

    Input input = parse(argv);

    log_dbg("hello world!");
}

// ---

void usage(int code, cstr name) {
    eprintln("Usage: %s [options]", name);
    eprintln("Options:");
    eprintln("  -h, --help | print help");
    exit(code);
}

static Input parse(cstr* argv) {
    Input input = { 0 };
    Cli cli = cli_init();

    // define args here
    cli_flag(&cli, &input.help, "-h", "--help");
    cli_arg_cstr(&cli, &input.infile);

    err_t err = cli_parse(&cli, argv);
    if (!err.ok) {
        log_err(STR_FMT, STR_FMT_ARG(err.msg));
        usage(1, cli.prog_name);
    }
    if (input.help) {
        usage(0, cli.prog_name);
    }
    input.args = cli.extra_args.array;
    return input;
}
