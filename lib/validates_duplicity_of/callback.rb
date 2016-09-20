module ValidatesDuplicityOf
  class Callback
    attr_reader :attr_name, :scope

    def initialize(attr_name, scope)
      @attr_name = attr_name
      @scope = scope
    end

    def before_save(record)
      duplicator = Duplicator.new self, record
      duplicator.validate
    end
  end
end
