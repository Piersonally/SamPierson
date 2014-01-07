# Wrap an OmniAuth::AuthHash
# and provide convenience methods to access it's data

class OauthResponse

  attr_reader :first_name, :last_name

  def initialize(oauth_response)
    raise "No OAUTH response!" unless oauth_response
    @auth = oauth_response
    first_and_last_name = group_names_into_first_and_last_name @auth["info"]["name"]
    @first_name = first_and_last_name.first
    @last_name = first_and_last_name.last
  end

  def email
    @auth["info"]["email"]
  end

  def uid
    @auth["uid"]
  end

  def gravatar_id
    @auth["extra"]["raw_info"]["gravatar_id"]
  end

  private

  # Return a 2 element array containing first and last names
  def group_names_into_first_and_last_name(full_name)
    names = full_name.split /\s/
    case names.count
      when 0; raise("This person has no name")
      when 1; [full_name, full_name]
      when 2; names
      else [names[0..-2].join(" "), names.last]
    end
  end
end
