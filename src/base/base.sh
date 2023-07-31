#!/usr/bin/env bash
# 可以本地安装repo
curr=$(pwd)
echo $curr
package_path=../package
function yum_l() {
    echo $1;
    if [ ! -d "../package"]; then
        yum $1;
    fi

}
# 先从本地取，取不到从网络取。
function wget_l() {
  echo $1;
  param=$1;
  filename=${param##*/}
  if [ -f "$package_path/$1" ]
    echo '11'
#  sudo cp $package_path/$1 $curr
  fi
  echo $filename;
}
wget=wget_l
yum=yum_l
