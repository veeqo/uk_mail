module UKMail
  class ConsignmentResponse
    attr_reader :consignment_number, :labels, :invoice

    def initialize(consignment_number, labels, invoice)
      @consignment_number = consignment_number
      @labels = labels
      @invoice = invoice
    end
  end
end
