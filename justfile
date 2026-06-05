set unstable

host_target := `rustc --print host-tuple`
ext := if os() == "windows" { ".exe" } else { "" }

download-net:
    python3 download-net.py

[default]
build-native: (build "native")

build-raw $RUSTFLAGS: download-net
    cargo build --release --target={{ host_target }}

build arch outname="icarus":
    just build-raw "--remap-path-prefix={{ env("HOME") }}=/ -Ctarget-cpu={{ arch }}"
    cp target/{{ host_target }}/release/icarus{{ ext }} {{ outname }}{{ ext }}

bench: build-native
    ./icarus{{ ext }} bench

build-x86-releases:
    just build "x86-64" icarus-{{ os() }}-generic
    just build "x86-64-v3" icarus-{{ os() }}-avx2
    just build "znver5" icarus-{{ os() }}-avx512
