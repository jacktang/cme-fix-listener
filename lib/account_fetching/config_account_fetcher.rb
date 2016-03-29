# Fetches account information.
# Given account details in a config file (config/account-config.json) it will read and parse the information.
# All accounts in the account-config.json are considered "active".
class ConfigAccountFetcher < AccountFetcher
  def self.fetch_details_for_account_id(account_id)
    config = read_config_file(config_file_path)
    config_object = parse_json(config, [])
    config_object.detect { |config| config['id'] == account_id }.try(:to_json)
  end

  def self.fetch_active_accounts
    read_config_file(config_file_path)
  end

  def self.read_config_file(config_path)
    @data ||= File.read(config_path)
  rescue StandardError
    puts "Unable to read config file: #{config_path}\n"
    nil
  end

  def self.config_file_path
    "config/account-config.json"
  end
end
