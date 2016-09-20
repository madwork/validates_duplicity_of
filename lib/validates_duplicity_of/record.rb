module ValidatesDuplicityOf
  class Record < SimpleDelegator
    attr_reader :attr_name, :scope

    def initialize(record, attr_name, scope)
      super(record)
      @attr_name = attr_name.to_s
      @scope = scope
    end

    # Callback attribute getter
    def attr_value
      __getobj__[attr_name]
    end

    # Callback attribute setter
    def attr_value=(value)
      __getobj__[attr_name] = value
    end

    def update_required?
      value_changed? && value_present? && record_exists?
    end

    def attr_changed_value
      changed_attributes[attr_name]
    end

    def where_match(pattern)
      scoped_relation.where klass.arel_table[attr_name].matches(pattern)
    end

    private

    def value_changed?
      changed.include? attr_name
    end

    def value_present?
      attr_value.present?
    end

    def record_exists?
      scoped_relation.where(attr_name => attr_value).exists?
    end

    def scoped_relation
      scope ? klass.where(scope => __getobj__[scope]) : klass
    end

    def klass
      __getobj__.class
    end
  end
end
