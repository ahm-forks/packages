#/usr/bin/env bash

_LINUX_LTS='5.4'
_LINUX_STABLE='5.9'

_LINUX_SCHED=(
    'bmq 1'
    'pds 0'
    'cfs 0'
    'muqss 0'
)

readonly _LINUX_MARCH=('generic'
    'atom' 'barcelona' 'bobcat' 'broadwell'
    'bulldozer' {cannon,cascade,cooper}'lake'
    'core2' 'excavator' 'goldmont'{,plus}
    'haswell' 'icelake' 'ivybridge' 'jaguar'
    'k10' 'k8' 'k8sse3' 'mpsc' 'nehalem'
    'piledriver' 'sandybridge' 'silvermont'
    'skylake' 'skylakex' 'steamroller'
    'westmere' 'zen' 'zen2'
)

# lts
for _VAR_SCHED in "${_LINUX_SCHED[@]}" 'muqss 0'; do
    echo "$_LINUX_LTS" "$_VAR_SCHED" 'lts'
done

# stable
for _VAR_SCHED in "${_LINUX_SCHED[@]}"; do
    for _VAR_MARCH in "${_LINUX_MARCH[@]}"; do
        echo $_LINUX_STABLE $_VAR_SCHED $_VAR_MARCH
    done
done

# 58-upds
_VAR_SCHED='upds 0'
_LINUX_STABLE='5.8'
for _VAR_MARCH in "${_LINUX_MARCH[@]}"; do
    echo $_LINUX_STABLE $_VAR_SCHED $_VAR_MARCH
done

