#/usr/bin/env bash

function variate() {
    set -o errexit
    
    _VER="$1"
    _SCHED="$2"
    _YIELD="$3"
    _MARCH="$4"

    _PKGBASE="linux-tkg-${_SCHED}-${_MARCH}"
    if [ "${_MARCH}" == 'generic' ]; then
        _PKGBASE="linux-tkg-${_SCHED}"
    elif [ "${_MARCH}" == 'lts' ]; then # LTS is generic-only
        _PKGBASE="linux-lts-tkg-${_SCHED}"
    fi

    _TIMER_FREQ=750
    if [ "${_SCHED}" == 'muqss' ]; then
        _TIMER_FREQ=100
    fi

    _RQ='none'
    if [ "${_MARCH}" == 'zen' ]; then
        _RQ='mc-llc'
    fi

    sed -i'' "
    s/_distro=\"[^\"]*\"/_distro=\"Arch\"/g
    s/_version=\"[^\"]*\"/_version=\"${_VER}\"/g
    s/_NUKR=\"[^\"]*\"/_NUKR=\"false\"/g
    s/_OPTIPROFILE=\"[^\"]*\"/_OPTIPROFILE=\"1\"/g
    s/_modprobeddb=\"[^\"]*\"/_modprobeddb=\"false\"/g
    s/_menunconfig=\"[^\"]*\"/_menunconfig=\"false\"/g
    s/_diffconfig=\"[^\"]*\"/_diffconfig=\"false\"/g
    s/_configfile=\"[^\"]*\"/_configfile=\"config.x86_64\"/g
    s/_cpusched=\"[^\"]*\"/_cpusched=\"${_SCHED}\"/g
    s/_compiler=\"[^\"]*\"/_compiler=\"gcc\"/g
    s/_rr_interval=\"[^\"]*\"/_rr_interval=\"default\"/g
    s/_sched_yield_type=\"[^\"]*\"/_sched_yield_type=\"${_YIELD}\"/g
    s/_ftracedisable=\"[^\"]*\"/_ftracedisable=\"true\"/g
    s/_numadisable=\"[^\"]*\"/_numadisable=\"false\"/g
    s/_tickless=\"[^\"]*\"/_tickless=\"2\"/g
    s/_voluntary_preempt=\"[^\"]*\"/_voluntary_preempt=\"false\"/g
    s/_acs_override=\"[^\"]*\"/_acs_override=\"true\"/g
    s/_ksm_uksm=\"[^\"]*\"/_ksm_uksm=\"true\"/g
    s/_bcachefs=\"[^\"]*\"/_bcachefs=\"true\"/g
    s/_bfqmq=\"[^\"]*\"/_bfqmq=\"true\"/g
    s/_zfsfix=\"[^\"]*\"/_zfsfix=\"true\"/g
    s/_fsync=\"[^\"]*\"/_fsync=\"true\"/g
    s/_processor_opt=\"[^\"]*\"/_processor_opt=\"${_MARCH}\"/g
    s/_smt_nice=\"[^\"]*\"/_smt_nice=\"true\"/g
    s/_random_trust_cpu=\"[^\"]*\"/_random_trust_cpu=\"true\"/g
    s/_runqueue_sharing=\"[^\"]*\"/_runqueue_sharing=\"${_RQ}\"/g
    s/_timer_freq=\"[^\"]*\"/_timer_freq=\"${_TIMER_FREQ}\"/g
    s/_user_patches=\"[^\"]*\"/_user_patches=\"false\"/g
    s/_custom_pkgbase=\"[^\"]*\"/_custom_pkgbase=\"${_PKGBASE}\"/g
    s/_misc_adds=\"[^\"]*\"/_misc_adds=\"true\"/g
    " customization.cfg

    echo '_nofallback="true"' >> customization.cfg

}
