module Commentable
  # Comment model.
  # 
  # Example:
  # 
  #   class Comment < ActiveRecord::Base
  #     include Commentable::Model
  #     
  #     self.spam_quota  = 5
  #     self.troll_quota = 10
  #     self.quota_time  = 1.week
  #   end
  # 
  # Class attributes:
  # 
  # - spam_quota  - how many spams are allowed for a single IP (defaults to 4)
  # - troll_quota - how many trolls are allowed for a single IP (defaults to 4)
  # - time_quota  - since how long should we check for spams and trolls (defauls to 1 day)
  module Model
    extend ActiveSupport::Concern

    included do
      cattr_accessor :spam_quota, :troll_quota, :quota_time

      self.spam_quota  = 4
      self.troll_quota = 4
      self.quota_time  = 1.day

      belongs_to :commentable, :polymorphic => true, :counter_cache => true

      validates_presence_of :commentable
      validates_presence_of :body
      validate :spam_quota, :troll_quota
    end

    # Adds an error on base if current ip generated too much spams.
    def spam_quota
      errors[:base] << "spam_quota" if self.class.count_for_user_ip(:spam) >= self.class.spam_quota
    end

    # Adds an error on base if current ip generated too much trolls.
    def troll_quota
      errors[:base] << "troll_quota" if self.class.count_for_user_ip(:troll) >= self.class.troll_quota
    end

    module ClassMethods
      def count_for_user_ip(field)
        where("user_ip = ? AND #{field} = ? AND created_at >= ?",
          user_ip, true, Time.now - quota_time).count
      end
    end
  end
end
