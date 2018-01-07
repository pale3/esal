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

pkgver() {
	cd ${_pkgname}
	echo $(git describe --long) | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'
}

package() {
	cd ${_pkgname}
	install -D -m 755 ${_pkgname} "${pkgdir}"/usr/bin/${_pkgname}

	mkdir -p "${pkgdir}"/usr/lib/$_pkgname
	cp -R lib/*.bash "${pkgdir}"/usr/lib/$_pkgname
	cp -r modules "${pkgdir}"/usr/lib/$_pkgname

	mkdir -p "${pkgdir}"/etc/
	cp esalrc "${pkgdir}"/etc/
}
