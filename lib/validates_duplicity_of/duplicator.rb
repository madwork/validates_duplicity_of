module ValidatesDuplicityOf
  class Duplicator
    def initialize(callback, record)
      @callback = callback
      @record = Record.new record, callback.attr_name, callback.scope
    end

    # Updates the attribute of the record
    def validate!
      return unless @record.update_required?

      if changed_attribute_match?
        @record.attr_value = @record.attr_changed_value
      else
        @record.attr_value.concat(next_index)
      end
    end

    private

    # Computes the next index
    def next_index
      match_names = record_names.flat_map{ |name| name.match(/\((\d+)\)$/) }.compact
      match_ids = match_names.flat_map(&:captures).map(&:to_i)
      index = match_ids.sort.last.to_i + 1
      " (#{index})"
    end

    # Finds the record names with this match
    def record_names
      @record.where_match("#{@record.attr_value} (%)").pluck(@record.attr_name)
    end

    def changed_attribute_match?
      /#{Regexp.escape(@record.attr_value)} \(\d+\)$/.match @record.attr_changed_value
    end
  end
end
