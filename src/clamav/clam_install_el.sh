#!/usr/bin/env bash

#https://docs.clamav.net/manual/Installing/Packages.html

dnf install -y epel-release
dnf install -y clamav clamd clamav-update


sudo freshclam

