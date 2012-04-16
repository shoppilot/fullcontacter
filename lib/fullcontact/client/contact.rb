module FullContact
  class Client
    module Contact
      # Public: Creates/Modifies a contact
      #
      # list_id - id of the contact list to which this contact is to be added
      # options - Hash containing contact data and other options
      #           :contact_data       - Hash representing the contact information in POCO format
      #           :generateIds(0|1)   - Whether or not ids need to be generated by the system (optional) (default: 0)
      #           :queue(true|false)  - Check for updates on creation if true (optional) (default: false)
      #
      # Example
      #
      #   contact = FullContact.update_contact(list_id, { :contact_data => data , :generateIds => 1 })
      #   # 'contact' contains the newly created contact
      def update_contact(list_id, options)
        options[:content_type] = 'application/json'
        options[:request_body] = options[:contact_data]
        options.delete(:contact_data)
        contacts = post("contactLists/#{list_id}", options)
      end

      # Public: Retrieves a contact
      #
      # list_id    - id of the contact list from which this contact is to be retrieved
      # contact_id - id of the contact which is to be retrieved
      # options    - Hash containing additonal arguments (optional) (default: {})
      #              :eTag - represents a unique version of the contact. Retrieves latest version if not specified (optional)
      #
      # Example
      #
      #   contact = FullContact.get_contact(list_id, contact_id)
      #   # contact now contains details about this contact
      def get_contact(list_id, contact_id, options = {})
        get("contactLists/#{list_id}/#{contact_id}", options)
      end

      # Public: Delete contact
      #
      # list_id    - id of the contact list from which this contact is to be deleted
      # contact_id - id of the contact which is to be deleted
      #
      # Example
      #
      #   FullContact.delete_contact(list_id, contact_id)
      def delete_contact(list_id, contact_id)
        delete("contactLists/#{list_id}/#{contact_id}")
      end

      # Public: Checks if a contact has new enrichment updates available
      #
      # list_id    - id of the contact list to which this contact belongs
      # contact_id - id of the contact which needs to be checked for enrichment updates
      # options    - Hash containing additonal arguments (optional) (default: {})
      #              :eTag - represents a unique version of the contact. Retrieves latest version if not specified (optional)
      #
      # Example
      #
      #   response = FullContact.has_enriched_updates?(list_id, contact_id)
      #   response.hasUpdates is now either true/false
      def has_enriched_updates?(list_id, contact_id, options = {})
        get("contactLists/#{list_id}/#{contact_id}/hasUpdates", options)
      end

      # Public: Gets latest updates for this contact
      #
      # list_id    - id of the contact list to which this contact belongs
      # contact_id - id of the contact whose updates are needed
      #
      # Example
      #
      #   response = FullContact.get_updates(list_id, contact_id)
      #   response.updates now contains the hash denoting the updates for this user
      def get_updates(list_id, contact_id)
        get("contactLists/#{list_id}/#{contact_id}/updates")
      end

      # Public: Gets fully enriched version of the contact
      #
      # list_id    - id of the contact list to which this contact belongs
      # contact_id - id of the contact whose enriched version is needed
      #
      # Example
      #
      #   response = FullContact.get_enriched_contact(list_id, contact_id)
      #   response.data now contains the hash denoting the enriched information for this contact
      def get_enriched_contact(list_id, contact_id)
        get("contactLists/#{list_id}/#{contact_id}/enriched")
      end

      # Public: Saves fully enriched version of the contact
      #
      # list_id    - id of the contact list to which this contact belongs
      # contact_id - id of the contact whose enriched version is to be saved
      #
      # Example
      #
      #   response = FullContact.save_enriched_contact(list_id, contact_id)
      def save_enriched_contact(list_id, contact_id)
        post("contactLists/#{list_id}/#{contact_id}/enriched")
      end

      # Public: Retrieves a list of eTags representing the history of a contact
      #
      # list_id    - id of the contact list to which this contact belongs
      # contact_id - id of the contact whose history is needed
      # options    - Hash containing additional arguments (optional) (default: {})
      #              :actionType("Added"|"Updated"|"Deleted"|"Enriched") - filters list based on the given action type
      #
      # Example
      #
      #   response = FullContact.history(list_id, contact_id, "Updated")
      #   response.history now contains a list of 'Update' actions, with corresponding eTags for this contact
      def contact_history(list_id, contact_id, options = {})
        get("contactLists/#{list_id}/#{contact_id}/history", options)
      end
    end
  end
end