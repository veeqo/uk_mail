module UKMail
  module Service
    class Consignment < ServiceBase
      def add_domestic_consignment(params = {})
        make_request(AddDomesticConsignmentRequest, params)
      end

      def soap
        SoapService::Consignment
      end

      def soap_service
        @soap_service ||= soap::IUKMConsignmentService.new
      end

      # def add_international_consignment(params = {})
      #   service.addInternationlConsignment(soap::AddInternationalConsignment.new(soap::AddInternationalConsignmentWebRequest.new(

      #     @session.auth_token,
      #     params[:username],
      #     params[:account_number],
      #     address_web_model(params[:address]),
      #     params[:alternative_ref],
      #     params[:business_name],
      #     params[:collection_job_number],
      #     params[:confirmation_of_delivery],
      #     params[:contact_name],
      #     params[:customers_ref],
      #     params[:email],
      #     params[:items],
      #     params[:service_key],
      #     params[:special_instructions_1],
      #     params[:special_instructions_2],
      #     params[:telephone],
      #     params[:weight],
      #     params[:currency_code],
      #     params[:documents_only],
      #     params[:extended_cover_required],
      #     params[:goods_description_1],
      #     params[:goods_description_2],
      #     params[:goods_description_3],
      #     params[:height],
      #     params[:in_free_circulation_eu],
      #     params[:invoice_type],
      #     params[:length],
      #     params[:no_dangerous_goods],
      #     params[:value],
      #     params[:width]

      #   ))).addInternationalConsignmentResult
      # end

      # def add_packets_consignment(params = {})
      #   service.addPacketConsignment(soap::AddPacketConsignment.new(soap::AddPacketConsignmentWebRequest.new(

      #     @session.auth_token,
      #     params[:authentication_token],
      #     params[:username],
      #     params[:account_number],
      #     params[:collection_job_number],
      #     params[:contact_name],
      #     params[:business_name],
      #     packet_address_web_model(params[:address]),
      #     params[:customers_ref],
      #     params[:alternative_ref],
      #     params[:weight_in_grams],
      #     params[:packet_length],
      #     params[:packet_width],
      #     params[:packet_height],
      #     params[:delivery_message_1],
      #     params[:delivery_message_2]

      #   ))).addPacketConsignmentResult
      # end

      # def packet_address_web_model(address)
      #   soap::PacketAddressWebModel.new(
      #     address[:address_1],
      #     address[:address_2],
      #     address[:address_3],
      #     address[:county],
      #     address[:postal_town],
      #     address[:postcode]
      #   )
      # end
    end
  end
end
