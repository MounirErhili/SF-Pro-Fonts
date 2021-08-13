#!/bin/bash



if [[ $UID -eq 0 ]]; then fonts_dir=/usr/share/fonts/
else fonts_dir=~/.local/share/fonts/; fi

err=0
current_dir="$(pwd)"
font_name=SF-Pro-Fonts

commands=(fc-cache)
for i in ${commands[@]}; do
    command -v $i >&/dev/null || { err=2 && echo "command ($i) not found!"; }
done

if [[ $err -ne 0 ]]; then exit $err; fi

if [ ! -d ${fonts_dir} ]; then
    echo -e "path (${fonts_dir}) not exists!\ncreate path '${fonts_dir}'..."
    mkdir -p "${fonts_dir}"
fi

if [ -d "${fonts_dir}${font_name}" ]; then rm -rf "${fonts_dir}${font_name}"; fi

echo "installing '${font_name}' ..."

mkdir -p "${fonts_dir}${font_name}"

cp -rf . "${fonts_dir}${font_name}/"

echo "update fonts cache..."

fc-cache -f

echo "clean up..."

rm -rf "${fonts_dir}${font_name}/"{.git,images,install.sh}

echo "${font_name} installed successfully!"
