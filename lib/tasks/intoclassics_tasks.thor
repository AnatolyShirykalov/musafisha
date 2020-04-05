# encoding: utf-8
require 'pycall/import'
class IntoclassicsTasks < Thor
  include PyCall::Import
  no_commands do
    def rails_path
      File.expand_path("../../../config/environment", __FILE__)
    end

    def load_env
      return if defined?(Rails)
      require rails_path
    end
  end
  desc 'load_pages', ''
  def load_pages
    load_env
    Dir.glob(File.join(Rails.application.secrets.ohmymusic_tmp_path, 'ic', '*')).each do |path|
      slug = File.basename(path)
      doc = Nokogiri::HTML(File.open(path))
      title = doc.at_css('title')&.text
      next if !title || title == 'Архив материалов - Погружение в классику'

      containers = doc.css('[width="550"]')
      raise "bad selector for container on page #{slug}" if containers.size != 1

      container = containers.first
      nodes = container.at_css('table').children.select { |c| %w[tr comment].include?(c.name) }
      separatorIdx = nodes.index { |n| n.name == 'comment' && n.text == 'Comments' }
      page = Intoclassics::Page.find_or_initialize_by(slug: slug)
      page.update!(
        slug: slug,
        title: title,
        content: nodes[0..separatorIdx].map(&:text).join("\n")
      )
    end
  end

  desc 'words', 'unuseed'
  def words
    load_env
    words = []
    Intoclassics::Page.find_in_batches do |batch|
      words += batch.map(&:content).join(' ').gsub(/[^a-zA-Zа-яёА-ЯЁ\- ]+/, '').split(' ').map(&:presence).compact.sort.uniq
      words = words.sort.uniq
    end
    Intoclassics::Word.transaction do
      words.each do |w|
        Intoclassics::Word.create!(content: w)
      end
    end
  end

  desc 'word_prefixes', 'unused'
  def word_prefixes
    last_word = Intoclassics::Word.find(1).content
    last_prefix = nil
    last_counter = 1
    max_counter = 1
    Intoclassics::Word.where.not(id: 1).find_each do |word|
      word.content
    end
  end

  desc 'pywords', 'use python virtual env "pyenv"'
  def pywords
    load_env
    pyimport :nltk
    res = {}
    Intoclassics::Page.where('id < 100').find_each do |page|
      all_words = nltk.word_tokenize("#{page.title}.\n#{page.content}")
      res[page] = nltk.pos_tag(all_words).select { |_w, type| type == 'NNP' }.map(&:to_a).map(&:first).sort.uniq
    end
    binding.irb
    Intoclassics::Word.transaction do
      res.values.reduce(&:+).sort.uniq.each do |word|
        Intoclassics::Word.create!(content: word)
      end
    end
    word_to_id = Hash[Intoclassics::Word.pluck(:content, :id)]
    res.each do |page, words|
      page.word_ids = words.map { |word| word_to_id[word] }
    end
  end

  desc 'pysb', 'python sandox'
  def pysb
    load_env
    pyimport :nltk

    binding.irb
  end
end
