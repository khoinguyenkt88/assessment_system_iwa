class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :label, :description

  has_many :options
end
