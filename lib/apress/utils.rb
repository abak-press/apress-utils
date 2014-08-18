# coding: utf-8
require 'rails'
require 'active_support/dependencies'
require 'action_view'
require 'active_record'
require 'action_dispatch'
require 'authlogic'

module Apress
  module Utils
    module Extensions
      module ActionView

        autoload :ResolverSortLocals, 'apress/utils/extensions/action_view/resolver_sort_locals'

        module Helpers
          autoload :FormBuilder, 'apress/utils/extensions/action_view/helpers/form_builder'
          autoload :InstanceTag, 'apress/utils/extensions/action_view/helpers/instance_tag'
        end
      end

      module ActionDispatch
        autoload :RoutesLoader, 'apress/utils/extensions/action_dispatch/routes_loader'

        module Routing
          autoload :Mapper, 'apress/utils/extensions/action_dispatch/routing/mapper'
        end
      end

      module ActiveRecord
        autoload :Migration, 'apress/utils/extensions/active_record/migration'
        autoload :MigrationProxy, 'apress/utils/extensions/active_record/migration_proxy'
      end

      module Authlogic
        autoload :Login, 'apress/utils/extensions/authlogic/login'
      end
    end
  end
end

require 'apress/utils/version'
require 'apress/utils/engine'
