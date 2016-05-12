module BSON
  class ObjectId
    def to_json(*)
      to_s.to_json
    end

    def as_json(*)
      to_s.as_json
    end
  end
end
