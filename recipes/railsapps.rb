# Application template recipe for the rails_apps_composer. Change the recipe here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/railsapps.rb

raise if (defined? defaults) || (defined? preferences) # Shouldn't happen.
if options[:verbose]
  print "\nrecipes: ";p recipes
  print "\ngems: "   ;p gems
  print "\nprefs: "  ;p prefs
  print "\nconfig: " ;p config
end

case Rails::VERSION::MAJOR.to_s
when "3"
  prefs[:railsapps] = multiple_choice "Install an example application for Rails 3.2?",
    [["I want to build my own application", "none"],
    ["membership/subscription/saas", "saas"],
    ["rails-prelaunch-signup", "rails-prelaunch-signup"],
    ["rails3-bootstrap-devise-cancan", "rails3-bootstrap-devise-cancan"],
    ["rails3-devise-rspec-cucumber", "rails3-devise-rspec-cucumber"],
    ["rails3-mongoid-devise", "rails3-mongoid-devise"],
    ["rails3-mongoid-omniauth", "rails3-mongoid-omniauth"],
    ["rails3-subdomains", "rails3-subdomains"]] unless prefs.has_key? :railsapps
when "4"
  prefs[:apps4] = multiple_choice "Build a starter application?",
    [["Build a RailsApps example application", "railsapps"],
    ["Contributed applications (none available)", "contributed_app"],
    ["Custom application (experimental)", "none"]] unless prefs.has_key? :apps4
  case prefs[:apps4]
    when 'railsapps'
      if rails_4_1?
        prefs[:apps4] = prefs[:rails_4_1_starter_app] || (multiple_choice "Starter apps for Rails 4.1. More to come.",
        [["learn-rails", "learn-rails"],
        ["rails-bootstrap", "rails-bootstrap"],
        ["rails-foundation", "rails-foundation"],
        ["rails-omniauth", "rails-omniauth"],
        ["rails-devise", "rails-devise"],
        ["rails-devise-pundit", "rails-devise-pundit"],
        ["rails-signup-download", "rails-signup-download"]])
      else
        say_wizard "Please upgrade to Rails 4.1 to get the starter apps."
      end
    when 'contributed_app'
      prefs[:apps4] = multiple_choice "No contributed applications are available.",
        [["create custom application", "railsapps"]]
  end
end

case prefs[:railsapps]
  when 'saas'
    prefs[:railsapps] = prefs[:billing] || (multiple_choice "Billing with Stripe or Recurly?",
      [["Stripe", "rails-stripe-membership-saas"],
      ["Recurly", "rails-recurly-subscription-saas"]])
end

case prefs[:railsapps]
  when 'rails-stripe-membership-saas'
    prefs[:git] = true
    prefs[:database] = 'sqlite'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'factory_girl'
    prefs[:frontend] = 'bootstrap2'
    prefs[:email] = 'gmail'
    prefs[:authentication] = 'devise'
    prefs[:devise_modules] = 'default'
    prefs[:authorization] = 'cancan'
    prefs[:starter_app] = 'admin_app'
    prefs[:form_builder] = 'simple_form'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
  when 'rails-recurly-subscription-saas'
    prefs[:git] = true
    prefs[:database] = 'sqlite'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'factory_girl'
    prefs[:frontend] = 'bootstrap2'
    prefs[:email] = 'gmail'
    prefs[:authentication] = 'devise'
    prefs[:devise_modules] = 'default'
    prefs[:authorization] = 'cancan'
    prefs[:starter_app] = 'admin_app'
    prefs[:form_builder] = 'simple_form'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
  when 'rails-prelaunch-signup'
    prefs[:git] = true
    prefs[:database] = 'sqlite'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'factory_girl'
    prefs[:frontend] = 'bootstrap2'
    prefs[:email] = 'mandrill'
    prefs[:authentication] = 'devise'
    prefs[:devise_modules] = 'confirmable'
    prefs[:authorization] = 'cancan'
    prefs[:starter_app] = 'admin_app'
    prefs[:form_builder] = 'simple_form'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
    if prefer :git, true
      prefs[:prelaunch_branch] = multiple_choice "Git branch for the prelaunch app?",
        [["wip (work-in-progress)", "wip"],
        ["master", "master"],
        ["prelaunch", "prelaunch"],
        ["staging", "staging"]] unless prefs.has_key? :prelaunch_branch

      prefs[:main_branch] = unless 'master' == prefs[:prelaunch_branch]
        'master'
      else
        multiple_choice "Git branch for the main app?",
          [["None", "none"],
          ["wip (work-in-progress)", "wip"],
          ["edge", "edge"]]
      end unless prefs.has_key? :main_branch
    end
  when 'rails3-bootstrap-devise-cancan'
    prefs[:git] = true
    prefs[:database] = 'sqlite'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'factory_girl'
    prefs[:frontend] = 'bootstrap2'
    prefs[:email] = 'gmail'
    prefs[:authentication] = 'devise'
    prefs[:devise_modules] = 'default'
    prefs[:authorization] = 'cancan'
    prefs[:starter_app] = 'admin_app'
    prefs[:form_builder] = 'simple_form'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
  when 'rails3-devise-rspec-cucumber'
    prefs[:git] = true
    prefs[:database] = 'sqlite'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'factory_girl'
    prefs[:frontend] = 'none'
    prefs[:email] = 'gmail'
    prefs[:authentication] = 'devise'
    prefs[:devise_modules] = 'default'
    prefs[:authorization] = 'none'
    prefs[:starter_app] = 'users_app'
    prefs[:form_builder] = 'none'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
  when 'rails3-devise-rspec-cucumber-fabrication'
    prefs[:git] = true
    prefs[:database] = 'sqlite'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'fabrication'
    prefs[:frontend] = 'none'
    prefs[:email] = 'gmail'
    prefs[:authentication] = 'devise'
    prefs[:devise_modules] = 'default'
    prefs[:authorization] = 'none'
    prefs[:starter_app] = 'users_app'
    prefs[:form_builder] = 'none'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
  when 'rails3-mongoid-devise'
    prefs[:git] = true
    prefs[:database] = 'mongodb'
    prefs[:orm] = 'mongoid'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'factory_girl'
    prefs[:frontend] = 'none'
    prefs[:email] = 'gmail'
    prefs[:authentication] = 'devise'
    prefs[:devise_modules] = 'default'
    prefs[:authorization] = 'none'
    prefs[:starter_app] = 'users_app'
    prefs[:form_builder] = 'none'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
  when 'rails3-mongoid-omniauth'
    prefs[:git] = true
    prefs[:database] = 'mongodb'
    prefs[:orm] = 'mongoid'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'factory_girl'
    prefs[:frontend] = 'none'
    prefs[:email] = 'none'
    prefs[:authentication] = 'omniauth'
    prefs[:omniauth_provider] = 'twitter'
    prefs[:authorization] = 'none'
    prefs[:starter_app] = 'users_app'
    prefs[:form_builder] = 'none'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
  when 'rails3-subdomains'
    prefs[:git] = true
    prefs[:database] = 'mongodb'
    prefs[:orm] = 'mongoid'
    prefs[:unit_test] = 'rspec'
    prefs[:integration] = 'cucumber'
    prefs[:fixtures] = 'factory_girl'
    prefs[:frontend] = 'none'
    prefs[:email] = 'gmail'
    prefs[:authentication] = 'devise'
    prefs[:devise_modules] = 'default'
    prefs[:authorization] = 'none'
    prefs[:starter_app] = 'subdomains_app'
    prefs[:form_builder] = 'none'
    prefs[:quiet_assets] = true
    prefs[:local_env_file] = 'figaro'
    prefs[:better_errors] = true
    prefs[:pry] = false
    prefs[:deployment] = 'none'
end

__END__

name: railsapps
description: "Install RailsApps example applications."
author: RailsApps

requires: [core]
run_after: [git]
category: configuration
