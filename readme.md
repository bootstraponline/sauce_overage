# sauce_overage

Automatically prevent tests from running on overage minutes by tracking remaining time

```bash
export ENV['SAUCE_USERNAME']="..."
export ENV['SAUCE_ACCESS_KEY']="..."
export ENV['SAUCE_OVERAGE_LIMIT']="300"

# will raise error if the limit is breached
sauce_overage
```
