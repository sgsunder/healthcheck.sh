# Contributor: Shyam Sunder <sgsunder1@gmail.com>
# Maintainer: Shyam Sunder <sgsunder1@gmail.com>
pkgname=healthcheck-httpd
pkgver=0.2
pkgrel=0
pkgdesc="A simple shell-based health checking REST API that runs via /bin/sh"
url="https://github.com/sgsunder/healthcheck.sh"
arch="noarch"
license="AGPL-3.0-or-later"
depends="lsblk smartmontools procps zfs socat"
makedepends=""
options="!check" # No test suite
install=""
source="
		healthcheck-httpd.sh
		openrc.service
		"
builddir="$srcdir/"

package() {
	install -Dm755 "$srcdir"/healthcheck-httpd.sh \
		"$pkgdir"/usr/sbin/healthcheck-httpd
	install -Dm755 "$srcdir"/openrc.service \
		"$pkgdir"/etc/init.d/healthcheck-httpd
}

sha512sums="dd56249be113953c6ecf220b7451e29f5c92d0a327b0268a4bba94e3c8bf9d410ab1473de4a03d6fe9759ba572b439511323f8b17285ecf4a6a1512bf7f5baa3  healthcheck-httpd.sh
28022a966ecb24c8390936070da5eb6dc2cddf11b8b60ee389771ed2a17012021b62d310432cd962d1155bce5493e7b6676e6d9a163a7762a87e6d61da501edf  openrc.service"
