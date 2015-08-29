# to start
```bash
ruby scripts/make_steps_seed.rb
ruby scripts/make_features_seed.rb
ruby scripts/cleanup.rb
```

## to adjust settings
edit the very bottom of `lib/words.rb`, i.e.
```ruby
N_FEATURE_FILES=200
FEATURES_PER_FILE=15
N_STEP_FILES=400
N_STEP_DEFINITIONS_PER_FILE=10
SLEEP_RANGE=5
```

# cycle
``` bash
ruby scripts/cleanup.rb && \
ruby scripts/make_steps_seed.rb && \
ruby scripts/make_features_seed.rb
```

