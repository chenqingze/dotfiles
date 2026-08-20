#!/usr/bin/env zsh
find ~/.vim/pack/plugins -type d -name .git -exec git -C {}/.. pull --ff-only \;
