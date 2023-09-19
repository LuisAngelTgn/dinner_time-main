class DataController < ApplicationController
  def load_data
    file_path = Rails.root.join('public', 'recipes-en.json')
    data = JSON.parse(File.read(file_path))
    @json_data = data
  end
end

