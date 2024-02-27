#!/usr/bin/env bash
set -e

function printHelp() {
  echo "Usage: ./build.sh [--run] [--gdb] FILE"
  echo
  echo "  --run       run program after assembly"
  echo "  --gdb       run program with gdb after assembly"
  echo "  FILE        name of file, without extension"
}

POS_ARGS=()
IS_HELP=0
IS_RUN=0
IS_GDB=0
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      IS_HELP=1
      shift
      ;;
    --run)
      IS_RUN=1
      shift
      ;;
    --gdb)
      IS_GDB=1
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      echo
      printHelp
      exit 1
      ;;
    *)
      POS_ARGS+=("$1")
      shift
      ;;
  esac
done

if [[ "$IS_HELP" == 1 ]]; then
  printHelp
  exit 0
fi

if [[ "$IS_RUN" == 1 ]] && [[ "$IS_GDB" == 1 ]]; then
  echo "Can't use both --run and --gdb"
  printHelp
  exit 1
fi

FILE="${POS_ARGS[0]}"

if [[ "$FILE" == "" ]]; then
  echo "No file specified"
  printHelp
  exit 1
fi

function runCmd() {
  echo "$ $@"
  eval $@
}

mkdir -p dist


runCmd yasm -g dwarf2 -f elf64 -l "dist/$FILE.lst" -o "dist/$FILE.o" "$FILE.asm"
runCmd ld -g -o "dist/$FILE" "dist/$FILE.o"

if [[ "$IS_RUN" == 1 ]]; then
  runCmd "./dist/$FILE"
fi
if [[ "$IS_GDB" == 1 ]]; then
  runCmd cd ./dist && gdb "$FILE" -tui -ex 'starti'
fi
