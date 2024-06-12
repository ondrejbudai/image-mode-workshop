# Image mode workshop

A simple workshop for playing with image mode and bootc.

## Step 1: Clone me!

```
git clone https://github.com/ondrejbudai/image-mode-workshop.git
cd image-mode-workshop
```

## Step 2: Build a derived bootable container image

```
sudo podman build -t image-mode-workshop .
```

## Step 3: Convert it to a disk image!
```
mkdir output
sudo podman run --rm -it --privileged --pull=newer --security-opt label=type:unconfined_t \
  -v $(pwd)/output:/output \
  -v /var/lib/containers/storage:/var/lib/containers/storage \
  -v ./config.toml:/config.toml \
  quay.io/centos-bootc/bootc-image-builder:latest --local \
  --type raw \
  --rootfs ext4 \
  localhost/image-mode-workshop
```

## Step 4: Boot it!
```
qemu-system-x86_64 -M accel=kvm -cpu host  -smp 2 -m 4096 -net nic,model=virtio -net user,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80 -snapshot output/image/disk.raw
```
