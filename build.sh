#以下两行docker里面运行需要sudo 如果pve里面运行请删除sudo
sudo apt-get update
sudo apt-get install -y pve-qemu-kvm gcc-aarch64-linux-gnu gcc-riscv64-linux-gnu libacl1-dev libaio-dev libattr1-dev libcap-ng-dev libcurl4-gnutls-dev libepoxy-dev libfdt-dev libgbm-dev libgnutls28-dev libiscsi-dev libjpeg-dev libnuma-dev libpci-dev libpixman-1-dev libproxmox-backup-qemu0-dev librbd-dev libsdl1.2-dev libseccomp-dev libslirp-dev libspice-protocol-dev libspice-server-dev libsystemd-dev liburing-dev libusb-1.0-0-dev libusbredirparser-dev libvirglrenderer-dev meson python3-sphinx python3-sphinx-rtd-theme quilt xfslibs-dev
ls
df -h
git clone git://git.proxmox.com/git/pve-edk2-firmware.git
cd pve-edk2-firmware
# pve8 4.2025.02-4~bpo12+1
#git reset --hard d6d1dfa76c6eb6e27c0cd873e902c4387571bd3a
# pve9 bump version to 4.2026.08-1
git reset --hard f37039e52d228a7844a90aa2aaf1e161ebd04fcd
sudo apt install devscripts -y
yes | sudo mk-build-deps --install
git submodule update --init --recursive
cp ../Logo1.bmp debian/Logo.bmp
cp ../sedPatch-pve-edk2-firmware-anti-dection.sh edk2/
cd edk2
meson subprojects download
chmod +x sedPatch-pve-edk2-firmware-anti-dection.sh
bash sedPatch-pve-edk2-firmware-anti-dection.sh
git diff > edk2-autoGenPatch.patch
cp edk2-autoGenPatch.patch ../
cd ..
make #改为一次编译
cd edk2
git checkout .
cd ..
