class UserDecorator < Draper::Decorator
  delegate_all

  def avatar_pic
    if name == "Yun"
      '<img class="mx-3 avatar-users-index-bordered-new" alt="avatar-bordered" src="https://res.cloudinary.com/deyqjsowe/image/upload/v1589709320/Yun_Chung_Profile_Photo_2_rlfgi5.jpg" />'
    else
      '<img class="mx-3 avatar-users-index-bordered-new" alt="avatar-bordered" src="https://res.cloudinary.com/deyqjsowe/image/upload/v1591165384/WooChaHee_satbqe.jpg" />'
    end
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
