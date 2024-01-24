class DogCeoApi

  attr_accessor :dog_ceo_host, :breed

  def initialize(breed)
    @dog_ceo_host = 'https://dog.ceo/'
    @breed = breed.downcase.split.reverse.join('/')
  end

  def random_image
    get("api/breed/#{uri_escape(breed)}/images/random")
  end

  def get(path)
    return not_configured unless configured?

    response = begin
      RestClient.get(dog_ceo_host + path)
    rescue RestClient::Exception => e
      e.response
    end

    respond_with(response)
  rescue
    return OpenStruct.new({
      status: 400,
      body: { error: "Request failed", message: "Breed not found." }
    })
  end

  def respond_with(response)
    OpenStruct.new({
      status: response.code,
      body: JSON.parse(response.body).with_indifferent_access
    })
  end

  def configured?
    breed.present?
  end

  def not_configured
    OpenStruct.new({
      status: 401,
      body: { message: "Please enter dog breed." }
    })
  end

  def uri_escape(text)
    ERB::Util.url_encode(text)
  end
end
