# to start
```bash
ruby scripts/make_steps_seed.rb
ruby scripts/make_features_seed.rb
ruby scripts/cleanup.rb
```

# cycle
``` bash
ruby scripts/cleanup.rb && \
ruby scripts/make_steps_seed.rb && \
ruby scripts/make_features_seed.rb
```

