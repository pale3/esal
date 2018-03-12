# Author: ava1ar <mail(at)ava1ar(dot)info>

_pkgname=esal

pkgname=esal-git
pkgrel=1
pkgver=1.0.r0.g4fd5f66
pkgdesc="Environment select archhlinux utility"
url="https://github.com:pale3/esal.git"
license=('GPL')
arch=('any')
depends=('bash' 'findutils' 'xmlstarlet')
source=(git+https://github.com/pale3/esal.git)
sha1sums=('SKIP')
backup=("etc/esalrc")

pkgver() {
	cd ${_pkgname}
    echo $(git describe --long --abbr=6) | sed 's/\([^-]*-g\)/r\1/;s/-/./g'
}

package() {
    cd ${_pkgname}
    make DESTDIR="$pkgdir/" install
}
