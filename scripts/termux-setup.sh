#!/bin/bash
pkg update -y
pkg upgrade -y
pkg install nodejs-lts -y
pkg install git -y
pkg install flutter -y
pkg install openjdk-17 -y
echo "✅ Ambiente Termux configurado para Willa IA"
