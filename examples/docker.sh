#!/bin/bash -e

cd "$( dirname "${BASH_SOURCE[0]}" )"/..

image=vmck/vagrant-vmck:latest
options=(--rm --interactive --tty)

while [[ $# -gt 0 ]]; do
  arg=$1
  shift
  case "$arg" in
    "--dev")
      options+=('--volume' "$(pwd)/lib:/src/lib")
      options+=('--volume' "$(pwd)/examples:/src/examples")
      ;;
    "--env")
      options+=('--env' "$1")
      shift
      ;;
    *)
      echo "Unknown option $arg" >&2
      exit 1
  esac
done

set -x
exec docker run ${options[@]} $image
