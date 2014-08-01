# encoding: utf-8

class CompanyLogoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :ios do
    #eager
    cloudinary_transformation :crop => :fill, :width => 200, :height => 80, :format => 'png'
  end

  version :web do
  	cloudinary_transformation :height => 150, :crop => :limit
  end

end
