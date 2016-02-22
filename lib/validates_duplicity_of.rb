require 'validates_duplicity_of/version'
require 'active_record'

module ValidatesDuplicityOf
  autoload :Callback,   'validates_duplicity_of/callback'
  autoload :Duplicator, 'validates_duplicity_of/duplicator'
  autoload :Record,     'validates_duplicity_of/record'

  # Creates a before save callback for duplicate value
  # @param attr_name [Symbol] the ActiveRecord attribute
  # @param scope [Symbol] a scope for the query
  def validates_duplicity_of(attr_name, scope: nil)
    set_callback :save, :before, Callback.new(attr_name, scope)
  end
end

ActiveRecord::Base.extend ValidatesDuplicityOf
