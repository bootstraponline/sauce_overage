# sauce_overage

[![Gem Version](https://badge.fury.io/rb/sauce_overage.svg)](https://rubygems.org/gems/sauce_overage)
[![Build Status](https://travis-ci.org/bootstraponline/sauce_overage.svg)](https://travis-ci.org/bootstraponline/sauce_overage)
[![Coverage Status](https://coveralls.io/repos/bootstraponline/sauce_overage/badge.svg?branch=master&service=github&nocache)](https://coveralls.io/github/bootstraponline/sauce_overage?branch=master)

Automatically prevent tests from running on overage minutes by tracking remaining time.

#### Jenkins CI Integration

```bash
export SAUCE_USERNAME="..."
export SAUCE_ACCESS_KEY="..."
export SAUCE_OVERAGE_LIMIT="300"

# if the limit is breached an error is raised and
# the job is marked as failed.
sauce_overage
if [ "$?" -ne 0 ]; then
  echo "Jenkins build failed due to lack of sauce minutes"
  exit 1
fi
```
