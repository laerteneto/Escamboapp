class Ad < ActiveRecord::Base

  # Constants
  QTT_PER_PAGE = 6

  # RatyRate gem
  ratyrate_rateable 'quality'

  # Callbacks
  before_save :md_to_html


  # associations
  belongs_to :member
  belongs_to :category, counter_cache: true
  has_many :comments

  #validates
  validates :title, :description_md, :description_short, :category, presence: true
  validates :picture, :finish_date, presence: true
  validates :price, numericality: {greater_than: 0}


  # Scopes
  # Get 6 adds and order them
  scope :descending_order, ->(page) {
        order(created_at: :desc).page(page).per(QTT_PER_PAGE)
  }
  scope :search, ->(q, page) {
        where("lower(title) LIKE ?", "%#{q.downcase}%").page(page).per(QTT_PER_PAGE)
  }

  scope :to_the, ->(member) {where(member_id: member)}
  scope :by_category, ->(id, page) {where(category: id).page(page).per(QTT_PER_PAGE)}

  scope :random, -> (qtt) {limit(qtt).order("RANDOM()")}

  # gem money-rails
  monetize :price_cents

  # gem paperclip
  has_attached_file :picture, styles: {large: "800x300#", medium: "320x150#", thumb: "100x100", default_url: "/images/:style/missing.png"}
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/


  def second
    self[1]
  end

  def third
    self[3]
  end


private
    def md_to_html

        options = {
            filter_html: true, # Not allowed to input HTML
            link_attributes: {
              rel: "nofollow",
              target: "_blank"
            }
        }

        extensions = {
          space_after_headers: true,
          autolink: true
        }

        renderer = Redcarpet::Render::HTML.new(options)
        markdown = Redcarpet::Markdown.new(renderer, extensions)

        self.description = markdown.render(self.description_md)

    end




end
