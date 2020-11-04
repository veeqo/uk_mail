module UKMail
  class ConsignmentResponse
    attr_reader :consignment_number, :labels

    def initialize(consignment_number, labels)
      @consignment_number = consignment_number
      @labels = labels
    end
  end
end
