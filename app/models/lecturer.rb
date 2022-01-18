class Lecturer < ApplicationRecord
  belongs_to :department
  has_many :lectures

  validates :name, presence: true
  validates :academic_degree, numericality: {only_integer: true, minimum: 1, maximum: 5}
  validates :post, presence: false
  validates :curatorial_group, presence: true, if: :curator?

  def curator?
    if post == 'куратор'
      if Lecturer.exists?(curatorial_group: curatorial_group)
        errors.add(:curatorial_group, 'group already has curator')
        return false
      else
        errors.add(:curatorial_group, 'there is no such group') unless Group.exists?(id: curatorial_group)
        return false
      end
      true
    end
  end

end
