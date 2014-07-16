# encoding: utf-8

class CompanyLogoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :ios do
    #eager
    cloudinary_transformation :crop => :fill, :width => 200, :height => 80, :format => 'png'
  end

end
