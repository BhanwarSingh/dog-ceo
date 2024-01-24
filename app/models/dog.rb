class Dog < OpenStruct

  def fetch_image
    response = DogCeoApi.new(breed).random_image

    respond_with(response)
  end

  def respond_with(response)
    self.success = response.status == 200
    self.image_url = response.body[:message]
    self.message = response.body[:message]
  end
end
