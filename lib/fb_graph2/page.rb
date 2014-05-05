module FbGraph2
  class Page < Node
    self.registered_attributes = {
      raw: [
        :about, :attire, :band_members, :booking_agent, :can_post, :category, :checkins, :company_overview,
        :current_location, :description, :directed_by, :founded, :general_info, :general_manager, :hometown,
        :is_permanently_closed, :is_published, :is_unclaimed, :likes, :link, :mission, :name, :phone, :press_contact,
        :products, :talking_about_count, :username, :website, :were_here_count
      ],
      date: [:birthday],
      custom: [
        :best_page, :category_list, :cover, :context, :hours, :location, :parking, :price_range, :restaurant_services,
        :restaurant_specialties
      ]
    }
    attr_accessor *registered_attributes.values.flatten

    def initialize(id, attributes = {})
      super
      assign attributes
    end

    def self.me(access_token)
      new(:me).authenticate access_token
    end
  end
end