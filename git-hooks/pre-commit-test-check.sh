#!/bin/sh
# shellcheck disable=SC2164

cd postprocess/py && pytest-3 --cov=nestpp tests
