class FormatSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
