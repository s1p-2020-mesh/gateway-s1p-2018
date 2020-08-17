#!/bin/bash

if [[ $1 == "cora" ]]; then

  sed -i '' 's/marygabry1508/ciberkleid/g' docker-push.sh
  sed -i '' 's/marygabry\.name/springone\.coraiberkleid\.xyz/g' test.sh
  sed -i '' 's/marygabry\.name/springone\.coraiberkleid\.xyz/g' istio-demo-steps.sh

  pushd yaml/eureka
  sed -i '' 's/marygabry1508/ciberkleid/g' *.yaml
  popd

  pushd yaml/istio
  sed -i '' 's/marygabry1508/ciberkleid/g' *.yaml
  sed -i '' 's/marygabry\.name/springone\.coraiberkleid\.xyz/g' *.yaml
  popd

else

  sed -i '' 's/ciberkleid/marygabry1508/g' docker-push.sh
  sed -i '' 's/springone\.coraiberkleid\.xyz/marygabry\.name/g' test.sh
  sed -i '' 's/springone\.coraiberkleid\.xyz/marygabry\.name/g' istio-demo-steps.sh

  pushd yaml/eureka
  sed -i '' 's/ciberkleid/marygabry1508/g' *.yaml
  popd

  pushd yaml/istio
  sed -i '' 's/ciberkleid/marygabry1508/g' *.yaml
  sed -i '' 's/springone\.coraiberkleid\.xyz/marygabry\.name/g' *.yaml
  popd

fi


