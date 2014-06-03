module FbGraph2
  class Page < Node
    include Edge::Admins
    include Edge::Albums
    include Edge::Blocked
    include Edge::Events
    include Edge::Feed
    include Edge::GlobalBrandChildren
    include Edge::Links
    include Edge::Locations
    include Edge::Milestones
    include Edge::Offers
    include Edge::Picture
    include Edge::Photos
    include Edge::Posts
    include Edge::PromotablePosts
    include Edge::Statuses
    include Edge::Tagged
    include Edge::Videos

    register_attributes(
      raw: [
        :about, :attire, :band_members, :booking_agent, :can_post, :category, :checkins, :company_overview,
        :current_location, :description, :directed_by, :founded, :general_info, :general_manager, :hometown,
        :is_permanently_closed, :is_published, :is_unclaimed, :likes, :link, :mission, :name, :phone, :press_contact,
        :products, :talking_about_count, :username, :website, :were_here_count,
        # NOTE: only within /:user_id/accounts context
        :perms
      ],
      time: [:created_time],
      date: [:birthday],
      page: [:best_page],
      photo: [:cover],
      custom: [
        :category_list, :context, :hours, :location, :parking, :price_range, :restaurant_services,
        :restaurant_specialties
      ]
    )

    def initialize(id, attributes = {})
      super
      if attributes.include? :category_list
        attributes[:category_list].collect do |page_category|
          PageCategory.new page_category[:id], page_category
        end
      end
      # TODO: handle other custom attributes.
    end
  end
end