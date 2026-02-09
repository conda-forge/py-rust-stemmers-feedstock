#!/bin/bash

set -euxo pipefail

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" == "1" ]]; then
    export PYO3_CROSS_PYTHON_VERSION=${PY_VER}
    "${BUILD_PREFIX}/bin/maturin" build --release --strip --interpreter "python${PY_VER}" --target $CARGO_BUILD_TARGET --out dist
    ${PYTHON} -m pip install dist/*.whl --no-deps -vv
else
    $PYTHON -m pip install . -vv
fi
cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
