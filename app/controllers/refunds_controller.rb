class RefundsController < ApplicationController
  def new 
	  @refund = Refund.new
	end

	def edit 
    @refund = Refund.find(params[:id])
	end

	def create
    booking = Booking.find_by(order_number: params[:refund][:order_number])
	  if booking.present?
		@refund = Refund.create(
			customer_id: booking.customer_id,
			booking_id: booking.id,
			state: 'accepted'
		)
		redirect_to edit_refund_path(@refund), notice: "Your booking request is valid. Please fill other details to process your refund request."
   	else
		  redirect_to new_refund_path, alert: "You provided invalid booking ID #{ params[:refund][:order_number] }. We found no booking with this booking id. PLease provide valid booking ID."
		end
	end
end
