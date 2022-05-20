# frozen_string_literal: true

module UsersConcerns
  extend ActiveSupport::Concern

  def validate_user_and_customer
    return if Customer.find(@user.customer_id).active? && @user.active?

    render json: { message: "You are set to be inactive. #{ERROR_MESSAGE}",
                   status: :unprocessable_entity }
  end

  def validate_user_type
    return unless @user.is_web_user?

    render json: { message: "This User is not a Mobile User. #{ERROR_MESSAGE}",
                   status: :unprocessable_entity }
  end

  def set_user
    @user = User.find_by_email(params[:email])
    return if @user.present?

    render json: { message: 'Invalid Email', status: :unauthorized }, status: :unauthorized
  end

  def authenticate(email, password, message)
    command = AuthenticateUser.call(email, password)
    user = command.result.second
    if command.success?
      render json: {
        access_token: command.result.first,
        message: message,
        user: user,
        customer_name: Customer.find(user.customer_id).name
      }
    else
      respond_to do |format|
        format.json do
          render json: { message: command.errors[:user_authentication][0],
                         status: :unauthorized }, status: :unauthorized
        end
      end
    end
  end

  def update_password(params)
    unless @current_user.valid_password? params[:old_password]
      return render json: { message: 'Your old password is invalid', status: 422 }
    end

    unless @current_user.reset_password params[:new_password], params[:confirm_password]
      return render json: { message: "Password and Confirm Password doesn't match", status: 422 }
    end

    render json: { message: 'Your Password has successfully been updated', status: 200 }
  end

  def convert_base64_to_image
    decode_img = Base64.decode64(params[:profile_picture])
    File.open(check_mkdir, 'wb') { |f| f.write(decode_img) }
  end

  def update_user_profile(params)
    @current_user.update(name: params[:name])
    return true unless params[:profile_picture].present?

    convert_base64_to_image
    image = ENV.fetch('PROFILE_PICTURE_PATH', '') + "#{@current_user.name}.png"
    src_file = File.new(File.join(Rails.root, image))
    update_profile_picture(src_file, image)
  end

  def update_profile_picture(image, used_image)
    @current_user.profile_picture = image
    @current_user.save
    File.delete(used_image) if File.exist?(used_image)
  end

  def check_mkdir
    image_path = ENV.fetch('PROFILE_PICTURE_PATH', '')
    Dir.mkdir('public/users') unless Dir.exist?('public/users')
    Dir.mkdir(image_path) unless Dir.exist?(image_path)

    image_path + "#{@current_user.name}.png"
  end

  def forget_password_configuration(params)
    user = User.find_for_authentication(email: params[:email])
    return render json: { message: 'Invalid email.', status: 422 } unless user.present?
    return render json: { message: 'This is not a mobile user.', status: 422 } if user.is_web_user?

    user.send_reset_password_instructions
    render json: { message: "We sent an email to #{user.email} to change your password",
                   status: 200 }
  end
end
