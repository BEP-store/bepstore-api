# rubocop:disable all

module ActiveModel
  class Serializer
    module Associations
      class HasMany
        def polymorphic?
          option :polymorphic
        end

        def key
          if key = option(:key)
            key
          elsif embed_ids? && !polymorphic?
            "#{@name.to_s.singularize}_ids".to_sym
          else
            @name
          end
        end

        def serialize_ids
          if polymorphic?
            associated_object.map do |item|
              {
                type: item.class.to_s.demodulize.underscore.to_sym,
                id: item.read_attribute_for_serialization(embed_key)
              }
            end
          else
            ids_key = "#{@name.to_s.singularize}_ids".to_sym
            if !option(:embed_key) && !source_serializer.respond_to?(@name.to_s) && source_serializer.object.respond_to?(ids_key)
              source_serializer.object.read_attribute_for_serialization(ids_key)
            else
              associated_object.map do |item|
                item.read_attribute_for_serialization(embed_key)
              end
            end
          end
        end
      end
    end
  end
end
