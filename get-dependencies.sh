#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm --needed \
	base-devel      \
	bluez-libs      \
	curl            \
	git             \
	lazarus         \
	qt6pas          \
	strace          \
	unzip           \
	wget            \
	xorg-server-xvfb

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building APRSMap from source..."
echo "---------------------------------------------------------------"
export LAZARUS_DIR=/usr/lib/lazarus
git clone https://github.com/andreaspeters/aprsmap ./aprsmap
cd ./aprsmap

if [ "${DEVEL_RELEASE-}" = 1 ]; then
	git rev-parse --short HEAD > ~/version
else
	git fetch --tags origin
	TAG=$(git tag --sort=-v:refname | grep -vi 'rc\|alpha\|beta' | head -1)
	git checkout "$TAG"
	echo "${TAG#v}" > ~/version
fi

# use/bluetoothlaz is declared in .gitmodules but its gitlink was never
# committed upstream, so git submodule update does not fetch it
git submodule update --init --recursive --force
git clone --depth=1 https://github.com/afriess/bluetoothlaz ./use/bluetoothlaz

# Lazarus packages the project needs, as listed in use/components.txt
while IFS= read -r pkg; do
	[ -n "$pkg" ] || continue
	[ -d "use/$pkg" ] && continue
	curl -fL --retry 3 -o "/tmp/$pkg.zip" "https://packages.lazarus-ide.org/$pkg.zip"
	unzip -q -o "/tmp/$pkg.zip" -d "use/$pkg"
done < use/components.txt

# register every package we just fetched with lazbuild
find use -type f -name '*.lpk' -exec lazbuild --lazarusdir="$LAZARUS_DIR" --add-package-link {} +

lazbuild --lazarusdir="$LAZARUS_DIR" --build-all --recursive --no-write-project \
	--build-mode=Release --widgetset=qt6 src/aprsmap.lpi

install -Dm755 src/aprsmap /usr/bin/aprsmap
cp -v assets/icons/aprsmap.png ../aprsmap.png
