# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="An alternative implementation of the zfs-auto-snapshot service for Linux"
HOMEPAGE="https://github.com/zfsonlinux/zfs-auto-snapshot"
EGIT_REPO_URI="https://github.com/zfsonlinux/zfs-auto-snapshot.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="systemd vanilla +cron"

DEPEND=""
RDEPEND="${DEPEND} sys-fs/zfs cron? ( virtual/cron )"

inherit git-r3

src_prepare() {
	if ! use vanilla; then
		### change the snapshot name to
		### @PREFIX_DATE_LABEL instead of @PREFIX-LABEL_DATE
		### (the following makes the snapshots nicely sorted by time)
		sed -r -i \
			-e 's@^(SNAPNAME="\$)(opt_prefix)(.*)-\$DATE@\1{\2}_$DATE\3@' \
			-e 's@^(SNAPGLOB="\$)(opt_prefix)(.*})([?]+)@\1{\2}\4\3@' \
			src/zfs-auto-snapshot.sh

		### Fix --fast mode sorting improperly when the patch above is applied
		patch -p1 -N <<'EOF'
--- a/src/zfs-auto-snapshot.sh
+++ b/src/zfs-auto-snapshot.sh
@@ -375,3 +375,3 @@ if [ -n "$opt_fast_zfs_list" ]
 then
-	SNAPSHOTS_OLD=$(env LC_ALL=C zfs list -H -t snapshot -o name -s name|grep $opt_prefix |awk '{ print substr( $0, length($0) - 14, length($0) ) " " $0}' |sort -r -k1,1 -k2,2|awk '{ print substr( $0, 17, length($0) )}') \
+	SNAPSHOTS_OLD=$(env LC_ALL=C zfs list -H -t snapshot -o name -s name | grep $opt_prefix | sort -t'@' -k2r,2 -k1,1) \
	  || { print_log error "zfs list $?: $SNAPSHOTS_OLD"; exit 137; }
EOF
	fi

	if use systemd; then
		mkdir -p systemd
		### "Label|NumberOfKeptSnapshots|systemd-timer-spec" of snapshots,
		### eg. timer and service files, being created adjust/extend if required
		declare -a arr=(
			"frequent|4|*:0/15"
			"hourly|24|hourly"
			"daily|31|daily"
			"weekly|8|weekly"
			"monthly|12|monthly"
		)

		for i in "${arr[@]}"; do
			_label="$(echo $i | cut -d'|' -f1)"
			_keep="$(echo $i | cut -d'|' -f2)"
			_OnCalendarSpec="$(echo $i | cut -d'|' -f3)"
			_prefix="--prefix=znap"
			cat > systemd/zfs-auto-snapshot-${_label}.service <<EOF
[Unit]
Description=ZFS $_label snapshot service

[Service]
ExecStart=$EPREFIX/sbin/zfs-auto-snapshot --skip-scrub $_prefix --label=$_label --keep=$_keep //
EOF

			# write timer files
			cat > systemd/zfs-auto-snapshot-${_label}.timer <<EOF
# See systemd.timers and systemd.time manpages for details
[Unit]
Description=ZFS $_label snapshot timer

[Timer]
OnCalendar=$_OnCalendarSpec
Persistent=true

[Install]
WantedBy=timers.target
EOF
		done
	fi
	default
}

src_install() {
	emake DESTDIR="${D}" PREFIX="$EPREFIX" install || die "emake install failed"

	chmod -x ${D}/etc/cron.d/zfs-auto-snapshot
	if !use cron; then
		rm -f ${D}/etc/cron.d/zfs-auto-snapshot
		rm -f ${D}/etc/cron.daily/zfs-auto-snapshot
		rm -f ${D}/etc/cron.hourly/zfs-auto-snapshot
		rm -f ${D}/etc/cron.weekly/zfs-auto-snapshot
		rm -f ${D}/etc/cron.monthly/zfs-auto-snapshot
	fi

	if use systemd; then
		install -d "${D}/usr/lib/systemd/system"
		install -m 644 systemd/* "${D}/usr/lib/systemd/system"
	fi
}

pkg_postinst() {
    elog "To enable snapshotting, set the auto-snapshot property on zfs:"
	elog ""
	elog "zfs set com.sun:auto-snapshot=[true|false]"
	elog "or"
	elog "zfs set com.sun:auto-snapshot:<frequent|hourly|daily|weekly|monthly>=[true|false]"
    elog ""
    elog "Details: http://docs.oracle.com/cd/E19082-01/817-2271/ghzuk/"
}
