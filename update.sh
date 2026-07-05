#!/bin/bash
git clone -b tcec --depth 1 https://github.com/Sp00ph/icarus
cd icarus
make
EXE=$PWD/icarus