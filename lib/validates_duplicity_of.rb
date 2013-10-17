require 'validates_duplicity_of/version'
require 'active_record'

module ValidatesDuplicityOf
  def validates_duplicity_of(attr_name, scope: nil)
    before_save do
      return unless changed.include? attr_name.to_s
      if self.class.exists?(Hash[*[attr_name, self[attr_name], scope, self[scope]].compact])
        realtion = scope ? self.class.where(Hash[*[scope, self[scope]]]) : self.class
        names = realtion.where(self.class.arel_table[attr_name].matches("#{self[attr_name]} (%)")).pluck(attr_name)
        name_ids = names.map{ |name| name.match(/\((\d+)\)$/)[1].to_i }
        index = name_ids.sort.last.to_i + 1
        self[attr_name].concat " (#{index})"
      end
    end
  end
end

ActiveRecord::Base.extend ValidatesDuplicityOf