#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install

rails db:create --trace
rails db:migrate --trace