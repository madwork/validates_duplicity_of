require 'validates_duplicity_of/version'
require 'active_record'

module ValidatesDuplicityOf
  def validates_duplicity_of(attr_name, scope: nil, callback: :before_save)
    validates = -> do
      return unless changed.include? attr_name.to_s
      return unless self[attr_name].present?
      if self.class.exists?(Hash[*[attr_name, self[attr_name], scope, self[scope]].compact])
        if /#{Regexp.escape(self[attr_name])} \(\d+\)$/.match changed_attributes[attr_name.to_s]
          self[attr_name] = changed_attributes[attr_name.to_s]
        else
          relation = scope ? self.class.where(Hash[*[scope, self[scope]]]) : self.class
          names = relation.where(self.class.arel_table[attr_name].matches("#{self[attr_name]} (%)")).pluck(attr_name)
          name_ids = names.flat_map{ |name| name.match(/\((\d+)\)$/).captures }.map(&:to_i)
          index = name_ids.sort.last.to_i + 1
          self[attr_name].concat " (#{index})"
        end
      end
    end
    set_callback *callback.to_s.split('_').reverse.map(&:to_sym), &validates # default: set_callback :save, :before, &validates
  end
end

ActiveRecord::Base.extend ValidatesDuplicityOf
