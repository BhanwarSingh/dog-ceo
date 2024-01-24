class DogsController < ApplicationController

  def create
    @dog = Dog.new(dog_params)

    @dog.fetch_image

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('dog-details',
                                   partial: 'dog', locals: { if: 'any' }) }
    end
  end

  private

  def dog_params
    params.permit(:breed)
  end
end
