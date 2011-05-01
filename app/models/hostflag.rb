class Hostflag < ActiveRecord::Base
  belongs_to :host
  belongs_to :flag
end
