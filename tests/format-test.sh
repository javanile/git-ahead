#!/usr/bin/env bash

source src/main.sh

cat << 'EOL' | git_ahead_sort | git_ahead_format 10
I2697 229 1
I2954 216 1
I3105 144 6
I3199 91 6
I3351 8 24
I3489 38 1
I3644 0 30
I3748 8 1
I4037 0 3
EOL

