#!/bin/bash

# the directory of this script (so it does not matter where it is run from)
dir=$(readlink -f $(dirname $0))

# the top-level directory for source
src="${dir}/src"

# choose one of the following, git repo URL prefix
# Note: git@github.com requires SSH key
url='git@github.com:SecureSECO'
# url='https://github.com/SecureSECO'

# create directory structure for illustration, some are empty
mkdir -p ${src}/modules/{fair,search,trust,use}
touch ${src}/modules/{fair,search,trust,use}/README.md

case "${1}" in
  clone)
    # TrustSECO-Portal would be better named SecureSECO-Portal
    git clone "${url}/TrustSECO-Portal.git"      "${src}/miner/portal"

    git clone "${url}/SecureSECO.git"            "${src}/miner/server"

    # these are all "miners", more or less(?)
    git clone "${url}/FAIRSECO-Ideas.git"        "${src}/modules/fair/ideas"
    git clone "${url}/SearchSECOController.git"  "${src}/modules/search/controller"
    git clone "${url}/SearchSECOCrawler.git"     "${src}/modules/search/crawler"
    git clone "${url}/SearchSECOParser.git"      "${src}/modules/search/parser"
    git clone "${url}/SearchSECOSpider.git"      "${src}/modules/search/spider"
    git clone "${url}/TrustSECO-DLT.git"         "${src}/modules/trust/DLT"
    git clone "${url}/TrustSECO-Spider.git"      "${src}/modules/trust/spider"

    # these are different from others
    git clone "${url}/SearchSECODatabaseAPI"     "${src}/modules/search/DatabaseAPI"
    git clone "${url}/SearchSECOPortal.git"      "${src}/modules/search/portal"
    ;;

  pull)
    dirs=(
        "${src}/miner/portal"
        "${src}/miner/server"
        "${src}/modules/fair/ideas"
        "${src}/modules/search/controller"
        "${src}/modules/search/crawler"
        "${src}/modules/search/parser"
        "${src}/modules/search/spider"
        "${src}/modules/trust/DLT"
        "${src}/modules/trust/spider"
        "${src}/modules/search/DatabaseAPI"
        "${src}/modules/search/portal"
      )
      for d in ${dirs[@]}
      do
        echo "git pull ${d}" | sed -e "s|${src}/||"
        cd ${d} && git pull
        echo
      done
    ;;

  *)
    echo "USAGE: ${0} <clone|pull>"
    exit 1
    ;;
esac

exit 0
