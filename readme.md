# sauce_overage

[![Coverage Status](https://coveralls.io/repos/bootstraponline/sauce_overage/badge.svg?branch=master&service=github&nocache)](https://coveralls.io/github/bootstraponline/sauce_overage?branch=master)
[![Build Status](https://travis-ci.org/bootstraponline/sauce_overage.svg)](https://travis-ci.org/bootstraponline/sauce_overage)

Automatically prevent tests from running on overage minutes by tracking remaining time

```bash
export ENV['SAUCE_USERNAME']="..."
export ENV['SAUCE_ACCESS_KEY']="..."
export ENV['SAUCE_OVERAGE_LIMIT']="300"

# will raise error if the limit is breached
sauce_overage
```
