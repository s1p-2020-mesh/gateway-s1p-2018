#!/bin/bash

#!/bin/bash

if [[ $1 == "cora" ]]; then
  FROM_REG=marygabry1508
  TO_REG=ciberkleid
  FROM_DMN=marygabry\.name
  TO_DMN=springone\.coraiberkleid\.xyz
else
  FROM_REG=ciberkleid
  TO_REG=marygabry1508
  FROM_DMN=springone\.coraiberkleid\.xyz
  TO_DMN=marygabry\.name
fi

find ./yaml -type f \( -name "*.yaml" -o -name "*.yml" \) -print0 | xargs -0 sed -i '' "s/${FROM_REG}/${TO_REG}/g"
find ./yaml -type f \( -name "*.yaml" -o -name "*.yml" \) -print0 | xargs -0 sed -i '' "s/${FROM_DMN}/${TO_DMN}/g"

sed -i '' "s/${FROM_REG}/${TO_REG}/g" docker-push.sh

sed -i '' "s/${FROM_DMN}/${TO_DMN}/g" test.sh
sed -i '' "s/${FROM_DMN}/${TO_DMN}/g" istio-demo-steps.sh
