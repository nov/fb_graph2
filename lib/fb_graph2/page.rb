module FbGraph2
  class Page < Node
    include Edge::Admins
    include Edge::Albums
    include Edge::Blocked
    include Edge::Conversations
    include Edge::Events
    include Edge::Feed
    include Edge::GlobalBrandChildren
    include Edge::Insights
    include Edge::Links
    include Edge::Locations
    include Edge::Milestones
    include Edge::Offers
    include Edge::Picture
    include Edge::Photos
    include Edge::Posts
    include Edge::PromotablePosts
    include Edge::Ratings
    include Edge::Roles::PageContext
    include Edge::Settings
    include Edge::Statuses
    include Edge::Tagged
    include Edge::Videos
    extend Searchable

    register_attributes(
      raw: [
        :about, :attire, :band_members, :booking_agent, :can_post, :category, :checkins, :company_overview,
        :current_location, :description, :directed_by, :founded, :general_info, :general_manager, :global_brand_page_name,
        :hometown, :hours, :impressum, :is_permanently_closed, :is_published, :is_unclaimed, :likes, :link, :mission, :name,
        :name_with_location_descriptor, :phone, :press_contact, :price_range, :products, :talking_about_count, :username,
        :website, :were_here_count,
        # NOTE: only within /:user_id/accounts context
        :perms
      ],
      time: [
        :created_time,
        # NOTE: only as Struct::Work#start_date
        :start_date, :end_date
      ],
      date: [:birthday],
      page: [:best_page, :global_brand_parent_page],
      photo: [:cover],
      users: [
        # NOTE: only as Struct::Education#classes and Struct::Work#projects
        :with
      ],
      location: [:location],
      custom: [
        :category_list, :context, :location, :parking, :restaurant_services, :restaurant_specialties,
        # NOTE: undocumented
        :payment_options
      ]
    )

    def initialize(id, attributes = {})
      super
      if attributes.include? :category_list
        self.category_list = attributes[:category_list].collect do |page_category|
          PageCategory.new page_category[:id], page_category
        end
      end
      if attributes.include? :context
        self.context = Struct::Context::PageContext.new attributes[:context]
      end
      if attributes.include? :parking
        self.parking = Struct::Parking.new attributes[:parking]
      end
      if attributes.include? :restaurant_services
        self.restaurant_services = Struct::RestaurantServices.new attributes[:restaurant_services]
      end
      if attributes.include? :restaurant_specialties
        self.restaurant_specialties = Struct::RestaurantSpecialties.new attributes[:restaurant_specialties]
      end
      if attributes.include? :payment_options
        self.payment_options = Struct::PaymentOptions.new attributes[:payment_options]
      end
    end
  end
end
