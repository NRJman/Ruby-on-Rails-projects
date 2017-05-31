class Product < ApplicationRecord
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :img_url, presence: true;
	validates :price, numericality: {greater_than_or_equal_to: 0.01};
	validates :title, uniqueness: true;
	validates :img_url, allow_blank:true, format: {
		with: %r{\.(gif|jpg|jpeg|png)\Z},
		message: " must point at GIF, JPG, JPEG or PNG image format"
	}
	def self.latest
		Product.order(:updated_at).last
	end

	private

	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'there are some line_items')
			return false
		end
	end
end
