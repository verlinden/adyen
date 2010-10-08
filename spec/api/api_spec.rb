require File.expand_path('../spec_helper', __FILE__)

describe Adyen::API do
  include APISpecHelper

  describe "shortcut methods" do
    it "performs a `authorise payment' request" do
      payment = mock('PaymentService')
      Adyen::API::PaymentService.should_receive(:new).with(:reference => 'order-id').and_return(payment)
      payment.should_receive(:authorise_payment)
      Adyen::API.authorise_payment(:reference => 'order-id')
    end

    it "performs a `authorise recurring payment' request" do
      payment = mock('PaymentService')
      Adyen::API::PaymentService.should_receive(:new).with(:reference => 'order-id').and_return(payment)
      payment.should_receive(:authorise_recurring_payment)
      Adyen::API.authorise_recurring_payment(:reference => 'order-id')
    end

    it "performs a `disable recurring contract' request for all details" do
      recurring = mock('RecurringService')
      Adyen::API::RecurringService.should_receive(:new).
        with(:shopper => { :reference => 'user-id' }, :recurring_detail_reference => nil).
          and_return(recurring)
      recurring.should_receive(:disable)
      Adyen::API.disable_recurring_contract('user-id')
    end

    it "performs a `disable recurring contract' request for a specific detail" do
      recurring = mock('RecurringService')
      Adyen::API::RecurringService.should_receive(:new).
        with(:shopper => { :reference => 'user-id' }, :recurring_detail_reference => 'detail-id').
          and_return(recurring)
      recurring.should_receive(:disable)
      Adyen::API.disable_recurring_contract('user-id', 'detail-id')
    end
  end
end
