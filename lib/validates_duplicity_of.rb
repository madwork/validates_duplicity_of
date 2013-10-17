require 'validates_duplicity_of/version'
require 'active_record'

module ValidatesDuplicityOf
  def validates_duplicity_of(attr_name, scope: nil)
    before_save do
      return unless send "#{attr_name}_changed?"
      attr_value = read_attribute(attr_name)
      condition = Hash[*[attr_name].zip([attr_value]).flatten]
      if self.class.exists?(condition)
        names = self.class.where(["#{attr_name} LIKE ?", "#{attr_value} (%)"]).pluck(:name)
        name_ids = names.map{ |name| name.match(/\((\d+)\)$/)[1].to_i }
        index = name_ids.sort.last.to_i + 1
        send "#{attr_name}=", "#{attr_value} (#{index})"
      end
    end
  end
end

ActiveRecord::Base.extend ValidatesDuplicityOf