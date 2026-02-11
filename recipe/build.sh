#!/bin/bash

set -euxo pipefail

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" == "1" ]]; then
    export PYO3_CROSS=1
    export PYO3_CROSS_LIB_DIR="${PREFIX}/lib"
    export PYO3_CROSS_PYTHON_VERSION=${PY_VER}
    "${BUILD_PREFIX}/bin/maturin" build --release --strip --target $CARGO_BUILD_TARGET -i "${BUILD_PREFIX}/bin/python" --out dist
    "${BUILD_PREFIX}/bin/python" -m pip install dist/*.whl --no-deps --no-build-isolation --prefix="${PREFIX}" --no-index -vv
else
    $PYTHON -m pip install . -vv
fi
cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
