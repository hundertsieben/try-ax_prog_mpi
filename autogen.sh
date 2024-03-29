#! /bin/sh

# generate ChangeLog from git shortlog
# default directory to put this stuff in is the local one
lcl="."
distdir=${1:-${lcl}} # 
top_src_dir=${2:-${lcl}}
echo "srcdir=${top_src_dir} distdir=${distdir}"
# eat the two first options
shift
shift
# loop through sequential tags to build ChangeLog
# 0.0.1..0.0.2
# 0.0.2..0.0.3
# etc
#
# rebuild if we can see the git repo and
#  there's no ChangeLog,
#  the ChangeLog is short, or
#  there's newer tags
touch ChangeLog
if ( [[ -d ${top_src_dir}/.git/refs/tags ]] && \
      ( [[ ! -f ${distdir}/ChangeLog ]] || \
        [[ $(wc -l ${distdir}/ChangeLog | cut -f 1 -d ' ' ) -lt 10 ]] || \
        [[ ${top_src_dir}/.git/refs/tags -nt ${distdir}/ChangeLog ]] ) )
    then
        echo "rebuilding ChangeLog"
        [[ -f ${distdir}/ChangeLog ]] && rm ${distdir}/ChangeLog
        T=( $(git tag -l) )
        for i in $(seq 1 $((${#T[@]}-1)) | tac); do
            echo -ne "Release ${T[$i]}:                                          " >> ${distdir}/ChangeLog
            date --date=- +'%b %d, %Y' --date="$(git show -s --format="%ci" ${T[$i]} | tail -1)" >> ${distdir}/ChangeLog
            git shortlog -w79,6,9 ${T[$i-1]}..${T[$i]} | grep -v 'minor:' | grep -v 'WIP:' | grep -e '^ ' >> ${distdir}/ChangeLog
            echo "" >> ${distdir}/ChangeLog
        done
else
    echo "opting to NOT rebuild ChangeLog"
fi

echo "get macros"
[ ! -d m4 ] && mkdir m4

echo "update configure.ac, etc"
cd ${distdir} && autoreconf --install --warnings=all --include=m4 $*

