### fdisk

```sh
fdisk /dev/sda
p - partition
n - new
```

### Create new pv

```sh
pvcreate /dev/sda4
vgdisplay
```

### Add new pv to vg

```sh
vgextend ubuntu-vg /dev/sda4
```

### Check rootfs lv path

```sh
vgdisplay
lvdisplay
```

### Resize root fix

```sh
lvextend --size +19.99G --resizefs /dev/ubuntu-vg/ubuntu-lv
```
