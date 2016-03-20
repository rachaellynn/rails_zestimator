split_config = YAML.load_file(Rails.root.join('config', 'split.yml'))
Split.redis = split_config[Rails.env]