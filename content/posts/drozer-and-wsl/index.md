---
title: "Run Drozer on WSL2 on Windows"
date: 2024-01-30T19:04:24+02:00
draft: false
resources:
- name: "featured-image"
  src: "dozerandwsl.png"
tags: ["Android", "Drozer", "WSL2", "Pentest"]
categories: ["Mobile Pentesting"]
---

## Run Drozer on Windows on WSL2 with the Docker image

On Windows:
``` cmd
adb kill-server
adb -a nodaemon server start
```

Modify the firewall rule for `adb.exe` when prompted by the Windows Defender Firewall Popup on its initial usage or through the Windows Defender Firewall settings. Ensure that access is granted for the public profile, as the vEthernet (WSL) adapter is associated with the public profile.

Get the `<WINDOWS-IP>` IP from the `/etc/resolv.conf` in WSL. If this does not work, get the IP of the Windows network adapter called `vEthernet (WSL)` (Control Panel\Network and Internet\Network Connections).

On Linux:
``` bash
socat -d -d TCP-LISTEN:5037,reuseaddr,fork TCP:<WINDOWS-IP>:5037
```
``` bash
adb forward tcp:31415 tcp:31415
sudo docker run --net host -it withsecurelabs/drozer console connect --server <WINDOWS-IP>
```

This allows us to use Drozers Docker image inside WSL2.

## Install Drozer
Drozer, also known as Mercury or Android Hacking Suite, is a security testing framework for Android devices. It is designed to assist security professionals, developers, and penetration testers in assessing the security of Android applications and devices. Drozer provides a set of tools and modules that can be used to identify and exploit vulnerabilities in Android applications.

Drozer can be installed as described at the git repository <https://github.com/WithSecureLabs/drozer>.
As drozer uses Python 2.7, and we do not want to install this outdated dependency, we use the Drozer Docker image.

## Configure the Setup

First, we plug in our Android smartphone via USB, and ADB should be enabled already. After that, we open the Windows PowerShell and kill all running adb instances with `adb kill-server`. After that, we can start a new adb server with the `-a` option (`adb -a nodaemon server start`), which will make adb listen on all network interfaces. Keep the window open; adb needs to be kept running. All the following adb commands will use this adb server. This is important for routing the data from WSL to Windows.

We start WSL2 and run `cat /etc/resolv.conf` to look up the IP set as nameserver. For me, this IP did not work, and I got the correct IPv4 address from the Windows Adapter Options (Control Panel\Network and Internet\Network Connections). Now it's time to start our Linux system, WSL. Install socat and run `socat -d -d TCP-LISTEN:5037,reuseaddr,fork TCP:<WINDOWS-IP>:5037`. `<WINDOWS-IP>` is the IP we collected earlier. The TCP port 31415 that is used by drozer, we forward it with `adb forward tcp:31415 tcp:31415` from the Android smartphone to the computer. This works like USB tethering. Lastly, run `sudo docker run --net host -it withsecurelabs/drozer console connect --server <WINDOWS-IP>` with the Windows IP we already used above. Drozer connects from within the Docker container, forwarded by socat and then over USB to the drozer-agent running on Android.

<img src="https://vg04.met.vgwort.de/na/478156c694b64186accf88f85b5b419b" width="1" height="1" alt="">

<script data-goatcounter="https://martin-renze.goatcounter.com/count"
        async src="//gc.zgo.at/count.js"></script>

