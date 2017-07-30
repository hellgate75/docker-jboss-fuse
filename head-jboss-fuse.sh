#!/bin/bash
RUNNING_FUSE="$(ps -eaf|grep -v grep|grep karaf)"
RUNNING_EAP="$(ps -eaf|grep -v grep|grep -e standalone)"

FLAG_EAP="false"
FLAG_FUSE="false"
if ! [[ -z "$RUNNING_EAP" ]]; then
  FLAG_EAP="true"
fi
if ! [[ -z "$RUNNING_FUSE" ]]; then
  FLAG_FUSE="true"
fi
netstat -anp
   echo '          ____                  ' \
&& echo '         |  _ \            _   _  ' \
&& echo '         | | | | ___  ___ | | / /___  _  __' \
&& echo '         | | | |/ _ \/  _|| |/ // _ \| |/ _|' \
&& echo '         | |_| | (_) | |__| |\ \  __||  ꜥ' \
&& echo '         |____/ \___/\___/|_| \_\___||__|' \
&& echo '      _ ____                  ______' \
&& echo '     | |  _ \                |  ____|             ' \
&& echo '     | | |_) | ___  ___ ___  | |__ _   _ ___  ___' \
&& echo ' _   | |  _ < / _ \/ __/ __| |  __| | | / __|/ _ \' \
&& echo '| |__| | |_) | (_) \__ \__ \ | |  | |_| \__ \  __/' \
&& echo ' \____/|____/ \___/|___/___/ |_|   \__,_|___/\___|' \
&& echo "" \
&& echo "JBoss Fuse (6.3.0.redhat-187)" \
&& echo "JBoss EAP (6.4.0)" \
&& echo "JBoss BPEL, Apache Camel" \
&& echo "" \
&& echo "JBoss EAP Console: http://0.0.0.0:9990" \
&& echo "JBoss Fuse Console: http://0.0.0.0:8181" \
&& echo "" \
&& echo "JBoss  EAP Running : $FLAG_EAP" \
&& echo "JBoss Fuse Running : $FLAG_FUSE" \
&& echo "" \
&& echo ""
