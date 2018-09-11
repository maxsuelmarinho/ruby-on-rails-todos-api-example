#!/bin/bash -x

#nohup bundle exec shoryuken -R -C config/shoryuken.yml > /dev/null 2>&1 &
bundle exec shoryuken -R -C config/shoryuken.yml -L ./log/jobs.log

