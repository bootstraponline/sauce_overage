# sauce_overage

[![Gem Version](https://badge.fury.io/rb/sauce_overage.svg)](https://rubygems.org/gems/sauce_overage)
[![Build Status](https://travis-ci.org/bootstraponline/sauce_overage.svg)](https://travis-ci.org/bootstraponline/sauce_overage)
[![Coverage Status](https://coveralls.io/repos/bootstraponline/sauce_overage/badge.svg?branch=master&service=github&nocache)](https://coveralls.io/github/bootstraponline/sauce_overage?branch=master)

Automatically prevent tests from running on overage minutes by tracking remaining time.

#### Jenkins CI Integration

```bash
export SAUCE_USERNAME="..."
export SAUCE_ACCESS_KEY="..."
# if available minutes are below the limit then the job will fail
export SAUCE_OVERAGE_LIMIT="300" # minutes

sauce_overage
if [ "$?" -ne 0 ]; then
  echo "Jenkins build failed due to lack of sauce minutes"
  exit 1
fi
```
