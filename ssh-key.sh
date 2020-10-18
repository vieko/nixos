#! /usr/bin/env fish

ssh-keygen -t rsa -b 4096 -C "vieko.franetovic@gmail.com"
eval (ssh-agent -s)
ssh-add $HOME/.ssh/id_rsa
