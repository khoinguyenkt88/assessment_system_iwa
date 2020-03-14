class TestSerializer < ActiveModel::Serializer
  self.root = :test
  attributes :id, :name, :description, :questions_count

  def questions_count
    object.questions.size
  end
end
