#!/bin/sh

icondir="$1"

if test ! -d "$icondir"; then
  echo "Pass a directory to the theme dir in the argument"
  exit 1;
fi

if test ! -f "$icondir/index.theme"; then
  echo "Not an icontheme directory!"
  exit 1;
fi

cmd="svgtopng/svgtopng"

echo "== Processing $1"

echo " * Creating png icons from svg files and symlinks"
#ignore list customized for elementary-xfce
find "$icondir" -iname "*.svg" -not \( -wholename "*/scalable/*" -o -wholename "*/symbolic/*" -o -wholename "*/animations/*process-*" -o -wholename "*/animations/*gnome-spinner*" -o -wholename "*/animations*pk-action-refresh*" \) -exec $cmd {} +

echo " * Cleanup icon directory"
find "$icondir" -name "untitled folder" -type d -exec rm -rf {} +

echo " * Deleting svg files"
find "$icondir" -iname '*.svg' -not \( -wholename "*/scalable/*" -o -wholename "*/symbolic/*" -o -wholename "*/animations/*process-*" -o -wholename "*/animations/*gnome-spinner*" -o -wholename "*/animations*pk-action-refresh*" \) -delete

#ignore the output if the theme depends on another one (e.g. elementary-xfce-dark needs to be converted before elementary-xfce)
echo " * Checking dangling symlinks"
find -L "$icondir" -type l -exec /bin/ls -go {} \;
