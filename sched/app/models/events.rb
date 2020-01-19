class Event < ActiveRecord::Base
    validates_presence_of :event_name
    has_many :uploads
    has_many :notes
    belongs_to :user
end