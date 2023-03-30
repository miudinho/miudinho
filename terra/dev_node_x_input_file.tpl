#!/bin/bash
sudo apt update -y &&
sudo touch /tmp/test_file.txt
sudo echo $DATE >> /tmp/test_file.txt
