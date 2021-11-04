# Discover

`pkg/daemon/discover/discover.go`

```shell
## discover device
$ lsblk --all --noheadings --list --output KNAME
$ lsblk /dev/vdd --bytes --nodeps --pairs --paths --output SIZE,ROTA,RO,TYPE,PKNAME,NAME,KNAME
$ udevadm info --query=property /dev/vdd
$ lsblk --noheadings --pairs /dev/vdd
## discover ceph inventory
$ ceph-volume inventory --format json
if device has ceph inv, device.CephVolumeData = CVData
## put device info into configmap per node
```
