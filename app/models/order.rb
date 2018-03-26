class Order < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :order_status
  has_many :order_items, dependent: :destroy
  before_create :set_placed_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def set_shipped_status
    self.order_status_id = 2
  end

  # Sends activation email.
  def send_sent_email
    UserMailer.order_sent(self).deliver_now
  end

  private
    def set_placed_status
      self.order_status_id = 1
    end

    def update_subtotal
      self[:subtotal] = subtotal
    end
end