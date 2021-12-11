# == Schema Information
#
# Table name: intoclassics_pages
#
#  id         :bigint           not null, primary key
#  title      :string
#  h1         :string
#  slug       :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_intoclassics_pages_on_slug  (slug) UNIQUE
#
class Intoclassics::Page < ApplicationRecord
  #searchkick
  has_many :links, dependent: :destroy
  has_many :page_words, dependent: :destroy
  has_many :words, through: :page_words
  has_many :page_composers, dependent: :destroy
  has_many :composers, through: :page_composers, class_name: 'Ohmymusic::Composer'

  def should_index?
    content.size < 16000
  end

  def source_file_path
    File.join(Rails.application.secrets.ohmymusic_tmp_path, 'ic', slug).to_s
  end

  def source_html
    File.open(source_file_path).read
  end

  def source_doc
    Nokogiri::HTML(source_html)
  end

  def source_container_doc
    containers = source_doc.css('[width="550"]')
    raise "bad selector for container on page #{slug}" if containers.size != 1

    containers.first
  end

  def source_container_nodes
    source_container_doc.at_css('table').children.select { |c| %w[tr comment].include?(c.name) }
  end

  def source_container_separator_idx
    source_container_nodes.index { |n| n.name == 'comment' && n.text.tr(" ", '') == 'Comments' }
  end

  def source_content_nodes
    source_container_nodes[0..source_container_separator_idx]
  end

  def source_content_v1
    source_content_nodes.map(&:text).join("\n")
  end

  def source_content_v2
    source_content_nodes.map do |node|
      txts = []
      node.traverse do |child|
        txts << child.text.tr("\n\t", '') if child.name == 'text'
      end
      txts.join(" ").gsub(/ +/, ' ')
    end[2..-4]
  end

  def source_content_v3
    return "" if source_content_nodes.empty?
    ret = []
    source_content_nodes[2].traverse do |node|
      ret << node.text.tr("\n\t", '') if node.name == 'text'
    end
    ret.join(' ').gsub(/ +/, ' ')
  end
end
