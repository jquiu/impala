class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    self.per_page = 10

    devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable

    attr_accessor :login
    
    validates_presence_of :username
    validates_uniqueness_of :username
    validates_uniqueness_of :email
    validates_presence_of :email
    validates_presence_of :carrier
    validates_presence_of :cell_phone
    validates_presence_of :landline
    validates_format_of :email, :with  => Devise.email_regexp
    # relationship
    has_many :offers, :through => :offer_users
    has_many :offer_users, :dependent => :destroy 
    has_many :comments, :dependent => :destroy 
    after_initialize :init
    
    def init
        self.container  ||= false
        self.liquid_charge  ||= false
        self.dry_charge  ||= false
    end

    def self.find_first_by_auth_conditions(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
            where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        else
            where(conditions.to_hash).first
        end
    end

    def self.current
    	Thread.current[:user]
    end
    def self.current=(user)
    	Thread.current[:user] = user
    end
end
