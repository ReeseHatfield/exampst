#!/usr/bin/env bash

#linux version of this, see readme

export TYPST_FONT_PATHS=$(realpath Fonts)

if [[ "$OSTYPE" == "darwin"* ]]; then
	DEST="$HOME/Library/Application Support/typst/packages/local/typst-utils/1.0.0"
else
	DEST="$HOME/.local/share/typst/packages/local/typst-utils/1.0.0"
fi

mkdir -p "$DEST"

cp -R Fonts Themes project_tools.typ typst.toml "$DEST"
