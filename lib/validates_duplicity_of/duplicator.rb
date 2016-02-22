module ValidatesDuplicityOf
  class Duplicator < SimpleDelegator
    def initialize(callback, record)
      super(callback)
      @record = record
    end

    # Updates the attribute of the record
    def validate!
      return unless value_changed?
      return unless value_present?
      return unless record_exists?

      if changed_attribute_match?
        @record[attr_name] = @record.changed_attributes[attr_name]
      else
        @record[attr_name].concat(next_index)
      end
    end

    private

    # Computes the next index
    def next_index
      match_ids = previous_record_names.flat_map{ |name| name.match(/\((\d+)\)$/) }.compact
      name_ids = match_ids.flat_map(&:captures).map(&:to_i)
      index = name_ids.sort.last.to_i + 1
      " (#{index})"
    end

    # Finds the record names with this match
    def previous_record_names
      pattern = "#{attr_value} (%)"
      record_relation.where(@record.class.arel_table[attr_name].matches(pattern)).pluck(attr_name)
    end

    def changed_attribute_match?
      /#{Regexp.escape(attr_value)} \(\d+\)$/.match @record.changed_attributes[attr_name]
    end

    def attr_name
      __getobj__.attr_name.to_s
    end

    def attr_value
      @record[attr_name]
    end

    def record_relation
      scope ? @record.class.where(scope => @record[scope]) : @record.class
    end

    def record_exists?
      record_relation.where(attr_name => attr_value).exists?
    end

    def value_changed?
      @record.changed.include? attr_name
    end

    def value_present?
      attr_value.present?
    end
  end
end
