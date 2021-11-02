### fdisk
```
fdisk /dev/sda
p - partition
n - new
```
### create new pv
```
### pvcreate /dev/sda4
```
```
vgdisplay
```
### add new pv to vg
```
vgextend ubuntu-vg /dev/sda4
```
### check rootfs lv path
```
vgdisplay
lvdisplay
```
### resize root fix
```
lvextend --size +19.99G --resizefs /dev/ubuntu-vg/ubuntu-lv
```
